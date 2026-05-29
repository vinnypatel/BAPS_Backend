"""
Author: Hasmukh Ginoya
Year: 2026
Description: Authentication module for BAPS Backend Server - Handles user login and JWT token generation
"""

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from datetime import datetime, timedelta
import jwt
import os
from dotenv import load_dotenv
from core.config import settings
from core.rate_limiter import ACCOUNT_LOCKED_MESSAGE, LoginRateLimiter
# Load environment variables
load_dotenv()

# Get secret key from env or use default
SECRET_KEY = os.getenv("SECRET_KEY", "your-secret-key-change-in-production")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# Request/Response Models
class LoginRequest(BaseModel):
    username: str
    password: str

class TokenResponse(BaseModel):
    access_token: str
    token_type: str
    expires_in: int

# Dummy user database (replace with real database)
USERS_DB = {
    "admin": "admin123",
    "user": "user123"
}

class Auth:
    """Authentication class for handling login and token generation"""
    
    def __init__(self, secret_key: str = SECRET_KEY, algorithm: str = ALGORITHM, 
                 access_token_expire_minutes: int = ACCESS_TOKEN_EXPIRE_MINUTES):
        """
        Initialize Auth class
        
        Args:
            secret_key: Secret key for JWT encoding
            algorithm: Algorithm for JWT encoding
            access_token_expire_minutes: Token expiration time in minutes
        """
        self.secret_key = secret_key
        self.algorithm = algorithm
        self.access_token_expire_minutes = access_token_expire_minutes
        self.login_rate_limiter = LoginRateLimiter(
            max_attempts=settings.security.login_rate_limit_attempts,
            window_seconds=settings.security.login_rate_limit_window_seconds,
            lockout_seconds=settings.security.login_rate_limit_lockout_seconds,
            wait_attempts=settings.security.login_rate_limit_wait_attempts,
        )
    def generate_access_token(self, username: str, expires_delta: timedelta = None) -> str:
        """
        Generate JWT access token
        
        Args:
            username: Username for token
            expires_delta: Token expiration time
        
        Returns:
            str: Encoded JWT token
        """
        if expires_delta is None:
            expires_delta = timedelta(minutes=self.access_token_expire_minutes)
        
        expire = datetime.utcnow() + expires_delta
        payload = {
            "sub": username,
            "exp": expire,
            "iat": datetime.utcnow()
        }
        
        encoded_jwt = jwt.encode(payload, self.secret_key, algorithm=self.algorithm)
        return encoded_jwt
    
    def verify_credentials(self, username: str, password: str) -> bool:
        """
        Verify username and password
        
        Args:
            username: Username to verify
            password: Password to verify
        
        Returns:
            bool: True if credentials are valid, False otherwise
        """
        return username in USERS_DB and USERS_DB[username] == password
    
    def login(self, credentials: LoginRequest) -> TokenResponse:
        """
        Authenticate user and return access token
        
        Args:
            credentials: LoginRequest with username and password
        
        Returns:
            TokenResponse: Access token and expiration time
        
        Raises:
            HTTPException: If credentials are invalid
        """
        rate_limit_key = credentials.username.strip().lower()
        self.login_rate_limiter.check(rate_limit_key)

        if not self.verify_credentials(credentials.username, credentials.password):
            result = self.login_rate_limiter.record_failure(rate_limit_key)
            if result == "locked":
                raise HTTPException(
                    status_code=status.HTTP_423_LOCKED,
                    detail=ACCOUNT_LOCKED_MESSAGE,
                )
            if result == "wait":
                raise HTTPException(
                    status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                    detail="Please wait for 5 minutes before trying again.",
                    headers={"Retry-After": str(settings.security.login_rate_limit_lockout_seconds)},
                )
            raise HTTPException(status_code=401, detail="Invalid credentials")
        
        access_token = self.generate_access_token(credentials.username)
        self.login_rate_limiter.reset(rate_limit_key)
        
        return TokenResponse(
            access_token=access_token,
            token_type="bearer",
            expires_in=self.access_token_expire_minutes * 60
        )


# Create router
router = APIRouter(prefix="/auth", tags=["Authentication"])

# Create Auth instance
auth_service = Auth()

@router.post("/login", response_model=TokenResponse)
async def login(credentials: LoginRequest):
    """
    Login endpoint - validates username and password, returns access token
    
    Args:
        credentials: LoginRequest with username and password
    
    Returns:
        TokenResponse: Access token and expiration time
    """
    return auth_service.login(credentials)


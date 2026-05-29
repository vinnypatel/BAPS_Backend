"""
Author: BAPS Development Team
Year: 2026
Description: Authentication business logic

The service layer is the brain of the application.
Services are called by routers and call repositories.
They contain the real application rules: what happens when a user logs in,
how tokens are issued, etc.
"""

from datetime import datetime, timedelta

from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from core.config import settings
from core.rate_limiter import ACCOUNT_LOCKED_MESSAGE
from core.security import verify_password, create_access_token, create_refresh_token, verify_token
from repositories.karyakar_repo import KaryakarRepository
from models.karyakar import Karyakar


class AuthService:
    """
    Authentication service handling login and token operations.
    
    Responsibilities:
    - Authenticating users (password verification)
    - Issuing JWT tokens (access and refresh)
    - Validating and refreshing tokens
    """
    
    def __init__(self, db: AsyncSession):
        """
        Initialize service with database session.
        
        Args:
            db (AsyncSession): Async database session
        """
        self.db = db
        self.user_repo = KaryakarRepository(db)
    
    async def authenticate_user(self, username_or_email: str, password: str) -> Karyakar:
        """
        Authenticate a user by username/email and password.
        
        Fetches user from database, verifies bcrypt hash, raises InvalidCredentials if wrong.
        
        Args:
            username_or_email (str): Username or email address
            password (str): Plaintext password
            
        Returns:
            User: Authenticated user object
            
        Raises:
            HTTPException: If credentials are invalid
            
        Example:
            user = await auth_service.authenticate_user("john@example.com", "my_password")
        """
        # Since karyakar repo might not have get_by_email directly, 
        # but wait, does it have get_by_username? Yes it does.
        # Let's just use get_by_username for now.
        user = await self.user_repo.get_by_username(username_or_email)
        
        if not user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid credentials",
                headers={"WWW-Authenticate": "Bearer"}
            )

        now = datetime.utcnow()
        self._ensure_login_allowed(user, now)
        
        # Verify password
        if not verify_password(password, user.password_hash):
            await self._record_failed_login(user, now)
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid credentials",
                headers={"WWW-Authenticate": "Bearer"}
            )
        
        await self._reset_login_security(user)
        return user

    # async def authenticate_user(self, username_or_email: str, password: str) -> Karyakar:
    #     """
    #     Authenticate a user by username/email and password.
        
    #     Fetches user from database, verifies bcrypt hash, raises InvalidCredentials if wrong.
        
    #     Args:
    #         username_or_email (str): Username or email address
    #         password (str): Plaintext password
            
    #     Returns:
    #         User: Authenticated user object
            
    #     Raises:
    #         HTTPException: If credentials are invalid
            
    #     Example:
    #         user = await auth_service.authenticate_user("john@example.com", "my_password")
    #     """
    #     # Since karyakar repo might not have get_by_email directly, 
    #     # but wait, does it have get_by_username? Yes it does.
    #     # Let's just use get_by_username for now.
    #     user = await self.user_repo.get_by_username(username_or_email)
        
    #     if not user:
    #         raise HTTPException(
    #             status_code=status.HTTP_401_UNAUTHORIZED,
    #             detail="Invalid credentials",
    #             headers={"WWW-Authenticate": "Bearer"}
    #         )
        
    #     # Verify password
    #     if not verify_password(password, user.password_hash):
    #         raise HTTPException(
    #             status_code=status.HTTP_401_UNAUTHORIZED,
    #             detail="Invalid credentials",
    #             headers={"WWW-Authenticate": "Bearer"}
    #         )
        
    #     return user
    
    async def issue_tokens(self, user_id: int) -> dict:
        """
        Issue access and refresh tokens for a user.
        
        Creates JWT access token (short-lived) and refresh token (long-lived).
        
        Args:
            user_id (int): User ID to create tokens for
            
        Returns:
            dict: Dictionary with 'access_token', 'refresh_token', and 'token_type'
            
        Example:
            tokens = await auth_service.issue_tokens(user.id)
            return {
                "access_token": tokens["access_token"],
                "refresh_token": tokens["refresh_token"],
                "token_type": "bearer"
            }
        """
        access_token = create_access_token(subject=user_id)
        refresh_token = create_refresh_token(subject=user_id)
        
        return {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "token_type": "bearer"
        }
    
    async def refresh_access_token(self, refresh_token: str) -> dict:
        """
        Issue a new access token using a valid refresh token.
        
        Verifies refresh token and creates new access token with same user_id.
        
        Args:
            refresh_token (str): Valid refresh token
            
        Returns:
            dict: Dictionary with new 'access_token' and 'token_type'
            
        Raises:
            HTTPException: If refresh token is invalid or expired
            
        Example:
            new_tokens = await auth_service.refresh_access_token(refresh_token)
            return {"access_token": new_tokens["access_token"]}
        """
        # Verify refresh token
        payload = verify_token(refresh_token, token_type="refresh")
        user_id = payload.get("sub")
        
        # Issue new access token
        access_token = create_access_token(subject=user_id)
        
        return {
            "access_token": access_token,
            "token_type": "bearer"
        }
    
    def _ensure_login_allowed(self, user: Karyakar, now: datetime) -> None:
        if user.locked_at:
            raise HTTPException(
                status_code=status.HTTP_423_LOCKED,
                detail=ACCOUNT_LOCKED_MESSAGE,
            )

        if user.temporary_login_block_until and user.temporary_login_block_until > now:
            retry_after = max(1, int((user.temporary_login_block_until - now).total_seconds()))
            raise HTTPException(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                detail="Please wait for 5 minutes before trying again.",
                headers={"Retry-After": str(retry_after)},
            )
    
    async def _record_failed_login(self, user: Karyakar, now: datetime) -> None:
        user.failed_login_attempts = (user.failed_login_attempts or 0) + 1
        user.last_failed_login_at = now

        if user.failed_login_attempts >= settings.security.login_rate_limit_attempts:
            user.locked_at = now
            user.lock_reason = "Exceeded invalid login attempts"
            user.temporary_login_block_until = None
            user.status = "locked"
            await self.user_repo.update(user)
            await self.db.commit()
            raise HTTPException(
                status_code=status.HTTP_423_LOCKED,
                detail=ACCOUNT_LOCKED_MESSAGE,
            )

        if user.failed_login_attempts >= settings.security.login_rate_limit_wait_attempts:
            user.temporary_login_block_until = now + timedelta(
                seconds=settings.security.login_rate_limit_lockout_seconds
            )
            await self.user_repo.update(user)
            await self.db.commit()
            raise HTTPException(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                detail="Please wait for 5 minutes before trying again.",
                headers={"Retry-After": str(settings.security.login_rate_limit_lockout_seconds)},
            )

        await self.user_repo.update(user)
        await self.db.commit()

    async def _reset_login_security(self, user: Karyakar) -> None:
        user.failed_login_attempts = 0
        user.temporary_login_block_until = None
        user.locked_at = None
        user.lock_reason = None
        user.last_failed_login_at = None
        user.status = "active"
        await self.user_repo.update(user)
    
    
async def logout_user(self, token: str) -> dict:
        """
        Handle user logout.
        
        In a simple implementation, logout is client-side (delete token).
        For revocation, would store token in Redis blacklist.
        
        Args:
            token (str): The token being logged out
            
        Returns:
            dict: Logout confirmation message
            
        Note:
            Currently just returns success. For production, implement
            Redis blacklist to prevent token reuse after logout.
        """
        # TODO: Implement Redis blacklist for token revocation
        # await redis.setex(f"blacklist:{token}", token_ttl, "true")
        
        return {"message": "Logged out successfully"}

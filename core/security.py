"""
Author: BAPS Development Team
Year: 2026
Description: Security utilities for password hashing and JWT token management

This module handles:
- Password hashing and verification using bcrypt
- JWT token creation (access and refresh tokens)
- Token verification and payload extraction
"""

from datetime import datetime, timedelta, timezone
from typing import Optional, Any, Dict
import jwt
from passlib.context import CryptContext
from fastapi import HTTPException, status

from core.config import settings


# Configure bcrypt password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hash_password(password: str) -> str:
    """
    Hash a plaintext password using bcrypt.
    
    Args:
        password (str): The plaintext password to hash
        
    Returns:
        str: The hashed password
        
    Example:
        hashed = hash_password("my_password")
    """
    return pwd_context.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Verify a plaintext password against a bcrypt hash.
    
    Args:
        plain_password (str): The plaintext password to verify
        hashed_password (str): The bcrypt hash to verify against
        
    Returns:
        bool: True if password matches, False otherwise
        
    Example:
        is_valid = verify_password("my_password", hashed_pwd)
    """
    return pwd_context.verify(plain_password, hashed_password)


def create_access_token(
    subject: str,
    expires_delta: Optional[timedelta] = None
) -> str:
    """
    Create a JWT access token.
    
    Args:
        subject (str): The subject claim (typically user_id)
        expires_delta (Optional[timedelta]): Custom expiration time. 
                                           Defaults to settings value if None.
        
    Returns:
        str: Encoded JWT token
        
    Example:
        token = create_access_token(subject="123")
    """
    if expires_delta is None:
        expires_delta = timedelta(
            minutes=settings.security.access_token_expire_minutes
        )
    
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode = {
        "sub": str(subject),
        "exp": expire,
        "type": "access"
    }
    
    encoded_jwt = jwt.encode(
        to_encode,
        settings.security.secret_key,
        algorithm=settings.security.algorithm
    )
    return encoded_jwt


def create_refresh_token(
    subject: str,
    expires_delta: Optional[timedelta] = None
) -> str:
    """
    Create a JWT refresh token.
    
    Args:
        subject (str): The subject claim (typically user_id)
        expires_delta (Optional[timedelta]): Custom expiration time.
                                           Defaults to settings value if None.
        
    Returns:
        str: Encoded JWT token
        
    Example:
        token = create_refresh_token(subject="123")
    """
    if expires_delta is None:
        expires_delta = timedelta(
            days=settings.security.refresh_token_expire_days
        )
    
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode = {
        "sub": str(subject),
        "exp": expire,
        "type": "refresh"
    }
    
    encoded_jwt = jwt.encode(
        to_encode,
        settings.security.secret_key,
        algorithm=settings.security.algorithm
    )
    return encoded_jwt


def verify_token(token: str, token_type: str = "access") -> Dict[str, Any]:
    """
    Verify and decode a JWT token.
    
    Args:
        token (str): The JWT token to verify
        token_type (str): Expected token type ("access" or "refresh")
        
    Returns:
        Dict[str, Any]: The decoded token payload
        
    Raises:
        HTTPException: If token is invalid, expired, or wrong type
        
    Example:
        payload = verify_token(token, token_type="access")
        user_id = payload.get("sub")
    """
    try:
        payload = jwt.decode(
            token,
            settings.security.secret_key,
            algorithms=[settings.security.algorithm]
        )
        
        # Verify token type
        if payload.get("type") != token_type:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail=f"Invalid token type. Expected {token_type}",
                headers={"WWW-Authenticate": "Bearer"}
            )
        
        return payload
        
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token has expired",
            headers={"WWW-Authenticate": "Bearer"}
        )
    except jwt.InvalidTokenError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token",
            headers={"WWW-Authenticate": "Bearer"}
        )


def get_user_id_from_token(token: str) -> str:
    """
    Extract user_id from a valid token.
    
    Args:
        token (str): The JWT token
        
    Returns:
        str: The user_id from token subject
        
    Raises:
        HTTPException: If token is invalid or expired
        
    Example:
        user_id = get_user_id_from_token(token)
    """
    payload = verify_token(token)
    return payload.get("sub")

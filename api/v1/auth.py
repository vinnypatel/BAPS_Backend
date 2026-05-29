# """
# Author: BAPS Development Team
# Year: 2026
# Description: Authentication API endpoints

# Routes for:
# - POST /auth/login - User login with username/email and password
# - POST /auth/refresh - Refresh access token using refresh token
# - POST /auth/logout - User logout
# """

# from fastapi import APIRouter, Depends, HTTPException, status
# from sqlalchemy.ext.asyncio import AsyncSession

# from core.dependencies import get_db, get_current_user
# from schemas.token import LoginSchema, TokenSchema, RefreshTokenSchema, LogoutSchema
# from services.auth_service import AuthService


# router = APIRouter(prefix="/auth", tags=["auth"])


# @router.post(
#     "/login",
#     response_model=TokenSchema,
#     status_code=status.HTTP_200_OK,
#     summary="User Login",
#     description="Login with username/email and password to receive JWT tokens"
# )
# async def login(
#     login_data: LoginSchema,
#     db: AsyncSession = Depends(get_db)
# ) -> dict:
#     """
#     User login endpoint.
    
#     Authenticates user with username/email and password.
#     Returns both access and refresh tokens on successful authentication.
    
#     Args:
#         login_data (LoginSchema): Username/email and password
#         db (AsyncSession): Database session
        
#     Returns:
#         TokenSchema: Access token, refresh token, and token type
        
#     Raises:
#         HTTPException: 401 if credentials are invalid
        
#     Example:
#         POST /auth/login
#         {
#             "username": "john_doe",
#             "password": "SecurePass123!"
#         }
        
#         Response:
#         {
#             "access_token": "eyJhbGc...",
#             "refresh_token": "eyJhbGc...",
#             "token_type": "bearer"
#         }
#     """
#     auth_service = AuthService(db)
    
#     # Authenticate user
#     user = await auth_service.authenticate_user(
#         login_data.username,
#         login_data.password
#     )
    
#     # Issue tokens
#     tokens = await auth_service.issue_tokens(user.id)
    
#     return tokens


# @router.post(
#     "/refresh",
#     response_model=TokenSchema,
#     status_code=status.HTTP_200_OK,
#     summary="Refresh Access Token",
#     description="Use refresh token to get a new access token"
# )
# async def refresh_token(
#     refresh_data: RefreshTokenSchema,
#     db: AsyncSession = Depends(get_db)
# ) -> dict:
#     """
#     Refresh access token endpoint.
    
#     Exchanges a valid refresh token for a new short-lived access token.
#     The refresh token remains valid for future refreshes.
    
#     Args:
#         refresh_data (RefreshTokenSchema): Refresh token
#         db (AsyncSession): Database session
        
#     Returns:
#         TokenSchema: New access token
        
#     Raises:
#         HTTPException: 401 if refresh token is invalid or expired
        
#     Example:
#         POST /auth/refresh
#         {
#             "refresh_token": "eyJhbGc..."
#         }
        
#         Response:
#         {
#             "access_token": "eyJhbGc...",
#             "refresh_token": "eyJhbGc...",
#             "token_type": "bearer"
#         }
#     """
#     auth_service = AuthService(db)
    
#     # Validate refresh token and issue new access token
#     tokens = await auth_service.refresh_access_token(
#         refresh_data.refresh_token
#     )
    
#     # Also include the original refresh token in response
#     tokens["refresh_token"] = refresh_data.refresh_token
    
#     return tokens


# @router.post(
#     "/logout",
#     response_model=LogoutSchema,
#     status_code=status.HTTP_200_OK,
#     summary="User Logout",
#     description="Logout the current user"
# )
# async def logout(
#     _: str = Depends(get_current_user),
#     db: AsyncSession = Depends(get_db)
# ) -> dict:
#     """
#     User logout endpoint.
    
#     Invalidates the current session.
#     Requires valid access token in Authorization header.
    
#     Note: In current implementation, logout is client-side (delete token from storage).
#     For production, implement Redis blacklist to prevent token reuse.
    
#     Args:
#         _: Current user ID (validates token is valid)
#         db (AsyncSession): Database session
        
#     Returns:
#         LogoutSchema: Logout confirmation message
        
#     Example:
#         POST /auth/logout
#         Authorization: Bearer eyJhbGc...
        
#         Response:
#         {
#             "message": "Logged out successfully"
#         }
#     """
#     auth_service = AuthService(db)
    
#     result = await auth_service.logout_user("token")
    
#     return result



"""
Author: BAPS Development Team
Year: 2026
Description: Authentication API endpoints with MFA support
"""

from datetime import datetime, timedelta, timezone

import pyotp

from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    Request,
    status,
)

from jose import jwt, JWTError

from pydantic import BaseModel

from sqlalchemy.ext.asyncio import AsyncSession

from core.captcha import verify_captcha_token
from core.config import settings
from core.dependencies import (
    get_db,
    get_current_karyakar,
    get_current_user,
)

from models.karyakar import Karyakar

from schemas.token import (
    LoginSchema,
    TokenSchema,
    RefreshTokenSchema,
    LogoutSchema,
    UnlockLoginSchema,
)

from services.auth_service import AuthService
from services.karyakar_service import KaryakarService


router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

# =========================================================
# JWT / MFA CONFIG
# =========================================================

SECRET_KEY = settings.security.secret_key

ALGORITHM = settings.security.algorithm

MFA_TOKEN_EXPIRE_MINUTES = (
    settings.security.mfa_token_expire_minutes
)

# =========================================================
# MFA SCHEMAS
# =========================================================

class MfaVerifySchema(BaseModel):
    code: str
    temp_token: str


class LoginResponseSchema(BaseModel):
    access_token: str | None = None
    refresh_token: str | None = None
    token_type: str | None = None

    mfa_required: bool = False
    temp_token: str | None = None


# =========================================================
# MFA TOKEN HELPERS
# =========================================================

def create_temp_mfa_token(
    user_id: str
) -> str:

    expire = datetime.now(
        timezone.utc
    ) + timedelta(
        minutes=MFA_TOKEN_EXPIRE_MINUTES
    )

    payload = {
        "sub": user_id,
        "type": "mfa_temp",
        "exp": expire,
    }

    return jwt.encode(
        payload,
        SECRET_KEY,
        algorithm=ALGORITHM,
    )


def verify_temp_mfa_token(
    token: str
) -> str:

    try:
        payload = jwt.decode(
            token,
            SECRET_KEY,
            algorithms=[ALGORITHM],
        )

        token_type = payload.get("type")

        if token_type != "mfa_temp":
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid MFA token type",
            )

        user_id = payload.get("sub")

        if not user_id:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid MFA token payload",
            )

        return user_id

    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired MFA token",
        )


# =========================================================
# TOTP VERIFY
# =========================================================

def verify_totp_code(
    secret: str,
    code: str
) -> bool:

    totp = pyotp.TOTP(secret)

    return totp.verify(
        code,
        valid_window=1
    )


@router.post("/mfa/setup")
async def setup_mfa(
    current_user: Karyakar = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db),
):

    # Generate secret
    secret = pyotp.random_base32()

    # Save temporarily
    current_user.mfa_secret = secret

    await db.commit()

    # Generate QR URI
    totp = pyotp.TOTP(secret)

    qr_uri = totp.provisioning_uri(
        name=current_user.username,
        issuer_name="BAPS Atladara"
    )

    return {
        "secret": secret,
        "qr_code": qr_uri
    }

class EnableMfaSchema(BaseModel):
    code: str


@router.post("/mfa/enable")
async def enable_mfa(
    data: EnableMfaSchema,
    current_user: Karyakar = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db),
):

    if not current_user.mfa_secret:
        raise HTTPException(
            status_code=400,
            detail="MFA setup not initialized"
        )

    valid = verify_totp_code(
        current_user.mfa_secret,
        data.code
    )

    if not valid:
        raise HTTPException(
            status_code=400,
            detail="Invalid verification code"
        )

    current_user.mfa_enabled = True

    await db.commit()

    return {
        "message": "MFA enabled successfully"
    }


@router.post("/mfa/disable")
async def disable_mfa(
    current_user: Karyakar = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db),
):

    current_user.mfa_enabled = False
    current_user.mfa_secret = None

    await db.commit()

    return {
        "message": "MFA disabled successfully"
    }

# =========================================================
# LOGIN
# =========================================================

@router.post(
    "/login",
    response_model=LoginResponseSchema,
    status_code=status.HTTP_200_OK,
    summary="User Login",
    description="Login with username/email and password"
)
async def login(
    login_data: LoginSchema,
    request: Request,
    db: AsyncSession = Depends(get_db)
) -> dict:

    # CAPTCHA
    verify_captcha_token(
        login_data.captcha_token,
        request.client.host if request.client else None,
    )

    auth_service = AuthService(db)

    # AUTHENTICATE USER
    user = await auth_service.authenticate_user(
        login_data.username,
        login_data.password
    )

    # =====================================================
    # MFA FLOW
    # =====================================================

    if user.mfa_enabled:

        temp_token = create_temp_mfa_token(
            user.id
        )

        return {
            "mfa_required": True,
            "temp_token": temp_token
        }

    # =====================================================
    # NORMAL LOGIN
    # =====================================================

    tokens = await auth_service.issue_tokens(
        user.id
    )

    return {
        **tokens,
        "mfa_required": False
    }


# =========================================================
# MFA VERIFY
# =========================================================

@router.post(
    "/mfa-verify",
    response_model=TokenSchema,
    status_code=status.HTTP_200_OK,
    summary="Verify MFA",
    description="Verify TOTP MFA code"
)
async def verify_mfa(
    data: MfaVerifySchema,
    db: AsyncSession = Depends(get_db)
):

    # VERIFY TEMP TOKEN
    user_id = verify_temp_mfa_token(
        data.temp_token
    )

    # FETCH USER
    user = await db.get(
        Karyakar,
        user_id
    )

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    # CHECK MFA CONFIGURED
    if not user.mfa_secret:
        raise HTTPException(
            status_code=400,
            detail="MFA is not configured"
        )

    # VERIFY TOTP
    valid = verify_totp_code(
        user.mfa_secret,
        data.code
    )

    if not valid:
        raise HTTPException(
            status_code=401,
            detail="Invalid MFA code"
        )

    # ISSUE TOKENS
    auth_service = AuthService(db)

    return await auth_service.issue_tokens(
        user.id
    )


# =========================================================
# REFRESH TOKEN
# =========================================================

@router.post(
    "/refresh",
    response_model=TokenSchema,
    status_code=status.HTTP_200_OK,
    summary="Refresh Access Token",
    description="Use refresh token to get new access token"
)
async def refresh_token(
    refresh_data: RefreshTokenSchema,
    db: AsyncSession = Depends(get_db)
) -> dict:

    auth_service = AuthService(db)

    tokens = await auth_service.refresh_access_token(
        refresh_data.refresh_token
    )

    tokens["refresh_token"] = (
        refresh_data.refresh_token
    )

    return tokens


# =========================================================
# UNLOCK LOGIN
# =========================================================

@router.post(
    "/unlock-login",
    status_code=status.HTTP_200_OK,
    summary="Unlock Login Access",
)
async def unlock_login_access(
    data: UnlockLoginSchema,
    current_user=Depends(
        get_current_karyakar
    ),
    db: AsyncSession = Depends(get_db),
) -> dict:

    if current_user.role not in [
        "sant_nirdeshak",
        "admin"
    ]:
        raise HTTPException(
            status_code=403,
            detail=(
                "Only sant_nirdeshak "
                "or admin can unlock login access"
            )
        )

    service = KaryakarService(db)

    await service.unlock_login_access(
        data.username
    )

    return {
        "message":
        "Login access unlocked successfully"
    }


# =========================================================
# LOGOUT
# =========================================================

@router.post(
    "/logout",
    response_model=LogoutSchema,
    status_code=status.HTTP_200_OK,
    summary="User Logout",
)
async def logout(
    _: str = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
) -> dict:

    auth_service = AuthService(db)

    result = await auth_service.logout_user(
        "token"
    )

    return result
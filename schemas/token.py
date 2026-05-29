# """
# Author: BAPS Development Team
# Year: 2026
# Description: Pydantic schemas for authentication token handling

# These schemas validate login requests and format token responses.
# """

# from pydantic import BaseModel, EmailStr, Field
# from typing import Optional


# class TokenSchema(BaseModel):
#     """Schema for token response"""
#     access_token: str = Field(..., description="JWT access token")
#     refresh_token: str = Field(..., description="JWT refresh token")
#     token_type: str = Field(default="bearer", description="Token type (always 'bearer')")
    
#     class Config:
#         json_schema_extra = {
#             "example": {
#                 "access_token": "eyJhbGc...",
#                 "refresh_token": "eyJhbGc...",
#                 "token_type": "bearer"
#             }
#         }


# class LoginSchema(BaseModel):
#     """Schema for user login request"""
#     username: str = Field(..., description="Username or email")
#     password: str = Field(..., description="Password")
    
#     class Config:
#         json_schema_extra = {
#             "example": {
#                 "username": "john_doe",
#                 "password": "SecurePass123!"
#             }
#         }


# class RefreshTokenSchema(BaseModel):
#     """Schema for token refresh request"""
#     refresh_token: str = Field(..., description="Refresh token to exchange for new access token")
    
#     class Config:
#         json_schema_extra = {
#             "example": {
#                 "refresh_token": "eyJhbGc..."
#             }
#         }


# class LogoutSchema(BaseModel):
#     """Schema for logout request (optional refresh token blacklisting)"""
#     message: str = Field(default="Logged out successfully", description="Logout confirmation message")
    
#     class Config:
#         json_schema_extra = {
#             "example": {
#                 "message": "Logged out successfully"
#             }
#         }


"""
Author: BAPS Development Team
Year: 2026
Description: Pydantic schemas for authentication token handling

These schemas validate login requests and format token responses.
"""

from pydantic import BaseModel, EmailStr, Field
from typing import Optional


class TokenSchema(BaseModel):
    """Schema for token response"""
    access_token: str = Field(..., description="JWT access token")
    refresh_token: str = Field(..., description="JWT refresh token")
    token_type: str = Field(default="bearer", description="Token type (always 'bearer')")
    mfa_enabled: bool = Field(default=False, description="Indicates if MFA is enabled")
    class Config:
        json_schema_extra = {
            "example": {
                "access_token": "eyJhbGc...",
                "refresh_token": "eyJhbGc...",
                "token_type": "bearer",
                "mfa_enabled": False
            }
        }


class LoginSchema(BaseModel):
    """Schema for user login request"""
    username: str = Field(..., description="Username or email")
    password: str = Field(..., description="Password")
    captcha_token: Optional[str] = Field(default=None, description="CAPTCHA verification token")
    
    class Config:
        json_schema_extra = {
            "example": {
                "username": "john_doe",
                "password": "SecurePass123!",
                "captcha_token": "0.xxxxx"
            }
        }


class RefreshTokenSchema(BaseModel):
    """Schema for token refresh request"""
    refresh_token: str = Field(..., description="Refresh token to exchange for new access token")
    
    class Config:
        json_schema_extra = {
            "example": {
                "refresh_token": "eyJhbGc..."
            }
        }


class LogoutSchema(BaseModel):
    """Schema for logout request (optional refresh token blacklisting)"""
    message: str = Field(default="Logged out successfully", description="Logout confirmation message")
    
    class Config:
        json_schema_extra = {
            "example": {
                "message": "Logged out successfully"
            }
        }


class UnlockLoginSchema(BaseModel):
    """Schema for unlocking login access"""
    username: str = Field(..., description="Username to unlock")

    class Config:
        json_schema_extra = {
            "example": {
                "username": "john_doe"
            }
        }

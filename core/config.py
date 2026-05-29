"""
Author: BAPS Development Team
Year: 2026
Description: Configuration management for BAPS Backend Server
Features:
- Environment variable loading from .env file
- Pydantic BaseSettings for type validation
- PostgreSQL configuration
- Redis configuration
- RabbitMQ configuration
- SMTP/Email configuration
- JWT and Security settings
- Application settings
"""

import os
from typing import Optional, Any
from pathlib import Path
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import Field, validator
from dotenv import load_dotenv

# Load environment variables from .env file explicitly
env_path = Path(__file__).parent.parent / ".env"
load_dotenv(dotenv_path=env_path)


class PostgresConfig(BaseSettings):
    """
    PostgreSQL Database configuration
    
    Attributes:
        host: Database server hostname
        port: Database server port
        database: Database name
        user: Database user
        password: Database password
        pool_size: Connection pool size
        max_overflow: Max overflow connections
        echo: Enable SQL echo logging
    """
    host: str = Field(default="localhost", description="PostgreSQL host")
    port: int = Field(default=5432, description="PostgreSQL port")
    database: str = Field(default="baps_db", description="Database name")
    user: str = Field(default="postgres", description="Database user")
    password: str = Field(default="", description="Database password")
    # We remove the prefix requirement for the full URL to support standard DATABASE_URL
    full_url: Optional[str] = Field(default=os.environ.get("DATABASE_URL"), description="Full connection string")
    pool_size: int = Field(default=20, description="Connection pool size")
    max_overflow: int = Field(default=10, description="Max overflow connections")
    echo: bool = Field(default=False, description="Enable SQL logging")
    
    model_config = SettingsConfigDict(env_prefix="POSTGRES_", populate_by_name=True)
    
    @property
    def url(self) -> str:
        """Build PostgreSQL connection string"""
        if self.full_url:
            # Normalize prefix to postgresql:// first
            url = self.full_url.replace("postgres://", "postgresql://")
            # Then ensure it uses asyncpg for our async driver
            if "postgresql+asyncpg://" not in url:
                url = url.replace("postgresql://", "postgresql+asyncpg://")
            return url
        return f"postgresql+asyncpg://{self.user}:{self.password}@{self.host}:{self.port}/{self.database}"
    
    @property
    def sync_url(self) -> str:
        """Build synchronous PostgreSQL connection string (for Alembic)"""
        if self.full_url:
            return self.full_url.replace("postgresql+asyncpg://", "postgresql://")
        return f"postgresql://{self.user}:{self.password}@{self.host}:{self.port}/{self.database}"


class RedisConfig(BaseSettings):
    """
    Redis configuration for caching and session management
    
    Attributes:
        host: Redis server hostname
        port: Redis server port
        database: Redis database number
        password: Redis password (optional)
        ssl: Enable SSL connection
        max_connections: Maximum connection pool size
        decode_responses: Decode responses as strings
    """
    host: str = Field(default="localhost", description="Redis host")
    port: int = Field(default=6379, description="Redis port")
    database: int = Field(default=0, description="Redis database number")
    password: Optional[str] = Field(default=None, description="Redis password")
    ssl: bool = Field(default=False, description="Enable SSL")
    max_connections: int = Field(default=50, description="Max connection pool size")
    decode_responses: bool = Field(default=True, description="Decode responses as strings")
    
    model_config = SettingsConfigDict(env_prefix="REDIS_")
    
    full_url: Optional[str] = Field(default=os.environ.get("REDIS_URL"), description="Full Redis connection string")
    
    @property
    def url(self) -> str:
        """Build Redis connection string"""
        if self.full_url:
            return self.full_url
        protocol = "rediss://" if self.ssl else "redis://"
        if self.password:
            return f"{protocol}:{self.password}@{self.host}:{self.port}/{self.database}"
        return f"{protocol}{self.host}:{self.port}/{self.database}"


class RabbitMQConfig(BaseSettings):
    """
    RabbitMQ configuration for message queue
    
    Attributes:
        host: RabbitMQ server hostname
        port: RabbitMQ server port
        user: RabbitMQ user
        password: RabbitMQ password
        vhost: Virtual host
        pool_size: Connection pool size
        heartbeat: Heartbeat interval (seconds)
    """
    host: str = Field(default="localhost", description="RabbitMQ host")
    port: int = Field(default=5672, description="RabbitMQ port")
    user: str = Field(default="guest", description="RabbitMQ user")
    password: str = Field(default="guest", description="RabbitMQ password")
    vhost: str = Field(default="/", description="RabbitMQ virtual host")
    pool_size: int = Field(default=10, description="Connection pool size")
    heartbeat: int = Field(default=60, description="Heartbeat interval")
    
    model_config = SettingsConfigDict(env_prefix="RABBITMQ_")
    
    @property
    def url(self) -> str:
        """Build RabbitMQ connection string"""
        return f"amqp://{self.user}:{self.password}@{self.host}:{self.port}/{self.vhost}"


class SMTPConfig(BaseSettings):
    """
    SMTP configuration for email notifications
    
    Attributes:
        host: SMTP server hostname
        port: SMTP server port
        user: SMTP authentication user
        password: SMTP authentication password
        from_email: Default sender email address
        from_name: Default sender name
        use_tls: Use TLS encryption
        use_ssl: Use SSL encryption
    """
    host: str = Field(default="smtp.gmail.com", description="SMTP server host")
    port: int = Field(default=587, description="SMTP server port")
    user: str = Field(default="", description="SMTP username")
    password: str = Field(default="", description="SMTP password")
    from_email: str = Field(default="noreply@baps.com", description="Default from email")
    from_name: str = Field(default="BAPS System", description="Default from name")
    use_tls: bool = Field(default=True, description="Use TLS encryption")
    use_ssl: bool = Field(default=False, description="Use SSL encryption")
    timeout: int = Field(default=10, description="SMTP timeout in seconds")
    
    model_config = SettingsConfigDict(env_prefix="SMTP_")


# class SecurityConfig(BaseSettings):
#     """
#     Security and JWT configuration
    
#     Attributes:
#         secret_key: Secret key for JWT signing
#         algorithm: JWT algorithm (HS256, HS512, RS256, etc.)
#         access_token_expire_minutes: Access token expiration time
#         refresh_token_expire_days: Refresh token expiration time
#         password_min_length: Minimum password length
#         password_require_uppercase: Require uppercase letters
#         password_require_numbers: Require numbers
#         password_require_special: Require special characters
#     """
#     secret_key: str = Field(default="change-me-in-production", description="JWT secret key")
#     algorithm: str = Field(default="HS256", description="JWT algorithm")
#     access_token_expire_minutes: int = Field(default=30, description="Access token expiration (minutes)")
#     refresh_token_expire_days: int = Field(default=7, description="Refresh token expiration (days)")
#     password_min_length: int = Field(default=8, description="Minimum password length")
#     password_require_uppercase: bool = Field(default=True, description="Require uppercase")
#     password_require_numbers: bool = Field(default=True, description="Require numbers")
#     password_require_special: bool = Field(default=True, description="Require special characters")
    
#     model_config = SettingsConfigDict(env_prefix="SECURITY_")

class SecurityConfig(BaseSettings):
    """
    Security and JWT configuration
    """

    # =====================================================
    # JWT CONFIG
    # =====================================================

    secret_key: str = Field(
        default="change-me-in-production",
        description="JWT secret key"
    )

    algorithm: str = Field(
        default="HS256",
        description="JWT algorithm"
    )

    access_token_expire_minutes: int = Field(
        default=30,
        description="Access token expiration (minutes)"
    )

    refresh_token_expire_days: int = Field(
        default=7,
        description="Refresh token expiration (days)"
    )

    # =====================================================
    # MFA CONFIG
    # =====================================================

    mfa_token_expire_minutes: int = Field(
        default=5,
        description="Temporary MFA token expiration (minutes)"
    )

    # =====================================================
    # PASSWORD POLICY
    # =====================================================

    password_min_length: int = Field(
        default=8,
        description="Minimum password length"
    )

    password_require_uppercase: bool = Field(
        default=True,
        description="Require uppercase"
    )

    password_require_numbers: bool = Field(
        default=True,
        description="Require numbers"
    )

    password_require_special: bool = Field(
        default=True,
        description="Require special characters"
    )

    # =====================================================
    # LOGIN RATE LIMIT
    # =====================================================

    login_rate_limit_attempts: int = Field(
        default=7,
        description="Failed login attempts before account lock"
    )

    login_rate_limit_wait_attempts: int = Field(
        default=5,
        description="Failed login attempts before temporary wait"
    )

    login_rate_limit_window_seconds: int = Field(
        default=300,
        description="Failed login rate limit window in seconds"
    )

    login_rate_limit_lockout_seconds: int = Field(
        default=300,
        description="Temporary login wait duration in seconds"
    )

    # =====================================================
    # CAPTCHA
    # =====================================================

    captcha_enabled: bool = Field(
        default=False,
        description="Require CAPTCHA verification on login"
    )

    captcha_secret_key: str = Field(
        default="",
        description="Cloudflare Turnstile secret key"
    )

    captcha_verify_url: str = Field(
        default=(
            "https://challenges.cloudflare.com/"
            "turnstile/v0/siteverify"
        ),
        description="Cloudflare Turnstile verification URL",
    )

    # =====================================================
    # ENV PREFIX
    # =====================================================

    model_config = SettingsConfigDict(
        env_prefix="SECURITY_"
    )


class AppConfig(BaseSettings):
    """
    Main application configuration
    
    Attributes:
        app_name: Application name
        app_version: Application version
        app_description: Application description
        environment: Environment (development, staging, production)
        debug: Enable debug mode
        log_level: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
        cors_origins: CORS allowed origins
        docs_enabled: Enable API documentation
    """
    app_name: str = Field(default="BAPS Backend Server", description="Application name")
    app_version: str = Field(default="1.0.0", description="Application version")
    app_description: str = Field(default="Building Asset Portal System Backend", description="App description")
    environment: str = Field(default="development", description="Environment")
    debug: bool = Field(default=True, description="Debug mode")
    log_level: str = Field(default="INFO", description="Logging level")
    cors_origins: Any = Field(default=["*"], description="CORS origins")
    docs_enabled: bool = Field(default=True, description="Enable API docs")
    
    @validator("cors_origins", pre=True)
    def assemble_cors_origins(cls, v):
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, (list, str)):
            return v
        raise ValueError(v)
    
    model_config = SettingsConfigDict(env_prefix="APP_")
    
    @property
    def is_production(self) -> bool:
        """Check if running in production"""
        return self.environment.lower() == "production"
    
    @property
    def is_development(self) -> bool:
        """Check if running in development"""
        return self.environment.lower() == "development"


class ServerConfig(BaseSettings):
    """
    Server configuration (legacy compatibility)
    
    Attributes:
        host: Server host address
        port: Server port number
    """
    host: str = Field(default="127.0.0.1", description="Server host")
    port: int = Field(default=9000, description="Server port")
    
    model_config = SettingsConfigDict(env_prefix="SERVER_")


class Settings(BaseSettings):
    """
    Master settings class that combines all configuration sections
    
    This is the single source of truth for all configuration in the application.
    Import and use this class everywhere instead of using os.environ directly.
    
    Usage:
        from core.config import settings
        
        db_url = settings.postgres.url
        redis_url = settings.redis.url
        secret_key = settings.security.secret_key
    """
    
    # Configuration sections
    postgres: PostgresConfig = Field(default_factory=PostgresConfig)
    redis: RedisConfig = Field(default_factory=RedisConfig)
    rabbitmq: RabbitMQConfig = Field(default_factory=RabbitMQConfig)
    smtp: SMTPConfig = Field(default_factory=SMTPConfig)
    security: SecurityConfig = Field(default_factory=SecurityConfig)
    app: AppConfig = Field(default_factory=AppConfig)
    server: ServerConfig = Field(default_factory=ServerConfig)
    
    model_config = SettingsConfigDict(
        env_file=str(Path(__file__).parent.parent / ".env"),
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore"
    )
    
    def __str__(self) -> str:
        """Return configuration summary (safe for logging)"""
        return f"""
BAPS Backend Configuration
=========================
App: {self.app.app_name} v{self.app.app_version}
Environment: {self.app.environment}
Debug: {self.app.debug}
Server: {self.server.host}:{self.server.port}

Database: {self.postgres.user}@{self.postgres.host}:{self.postgres.port}/{self.postgres.database}
Redis: {self.redis.host}:{self.redis.port}
RabbitMQ: {self.rabbitmq.user}@{self.rabbitmq.host}:{self.rabbitmq.port}
SMTP: {self.smtp.host}:{self.smtp.port}
"""


# Create singleton instance of settings
settings = Settings()

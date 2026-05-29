"""
Author: BAPS Development Team
Year: 2026
Description: SQLAlchemy async session configuration and dependency injection

This module creates the AsyncEngine from the database URL and provides:
- AsyncSessionLocal: Factory for creating async database sessions
- get_db(): FastAPI dependency that yields sessions and handles cleanup

This layer knows nothing about the business domain - it's purely for database session setup.
"""

from typing import AsyncGenerator
from sqlalchemy.ext.asyncio import (
    AsyncEngine,
    AsyncSession,
    create_async_engine,
    async_sessionmaker,
)
from fastapi import Depends

from core.config import settings


# Create async engine from the PostgreSQL async connection string or SQLite local string
# Debug: Print the URL being used (masking password)
url_for_log = settings.postgres.url.split("@")[-1]
print(f"Connecting to Database at: {url_for_log}")

is_sqlite = settings.postgres.url.startswith("sqlite")

engine_kwargs = {
    "url": settings.postgres.url,
    "echo": settings.postgres.echo,
}

if is_sqlite:
    # SQLite does not support pool_size, max_overflow, or server_settings in connect_args.
    # We pass pool_pre_ping to ensure connection health checks.
    engine_kwargs["pool_pre_ping"] = True
else:
    # PostgreSQL specific settings
    engine_kwargs.update({
        "pool_size": settings.postgres.pool_size,
        "max_overflow": settings.postgres.max_overflow,
        "pool_pre_ping": True,
        "connect_args": {
            "server_settings": {"jit": "off"},  # Disable JIT for predictable performance
        }
    })

engine: AsyncEngine = create_async_engine(**engine_kwargs)


# Create async session factory
# This factory creates a new AsyncSession instance each time it's called
AsyncSessionLocal = async_sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False,  # Prevent lazy loading after commit
    autocommit=False,
    autoflush=False,
)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """
    Dependency function to get a database session.
    
    This is used as a FastAPI dependency to inject database sessions into route handlers.
    The session is automatically committed on success and rolled back on error.
    
    Usage in route handlers:
        from fastapi import Depends
        from db.session import get_db
        
        @app.get("/users")
        async def list_users(db: AsyncSession = Depends(get_db)):
            result = await db.execute(select(User))
            return result.scalars().all()
    
    Yields:
        AsyncSession: Database session that is automatically cleaned up
        
    Raises:
        Any exceptions from the route handler are propagated, but the session
        is guaranteed to be rolled back and closed in the finally block.
    """
    async with AsyncSessionLocal() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise
        finally:
            await session.close()

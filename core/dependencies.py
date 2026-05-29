from typing import AsyncGenerator
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.ext.asyncio import AsyncSession

from db.session import AsyncSessionLocal
from core.security import get_user_id_from_token

from repositories.karyakar_repo import KaryakarRepository
from repositories.haribhakt_repo import HaribhaktRepository
from repositories.mandal_repo import MandalRepository
from repositories.xetra_repo import XetraRepository
from repositories.announcement_repo import AnnouncementRepository

from services.karyakar_service import KaryakarService
from services.haribhakt_service import HaribhaktService
from services.mandal_service import MandalService
from services.xetra_service import XetraService
from services.announcement_service import AnnouncementService

security = HTTPBearer(description="JWT Bearer token")

async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSessionLocal() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise
        finally:
            await session.close()

async def get_current_user_id(credentials: HTTPAuthorizationCredentials = Depends(security)) -> str:
    token = credentials.credentials
    return get_user_id_from_token(token)

async def get_current_user(
    user_id: str = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db)
):
    from services.karyakar_service import KaryakarService
    service = KaryakarService(db)
    user = await service.get_by_id(user_id)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User not found",
            headers={"WWW-Authenticate": "Bearer"}
        )
    return user

async def get_current_karyakar(
    user = Depends(get_current_user)
):
    """Returns the full Karyakar ORM object for the authenticated user"""
    return user


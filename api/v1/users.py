from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from core.dependencies import get_current_karyakar, get_db
from repositories.karyakar_repo import KaryakarRepository
from schemas.karyakar import KaryakarResponse

router = APIRouter(prefix="/users", tags=["users"])


@router.get("/me", response_model=KaryakarResponse)
async def me(current=Depends(get_current_karyakar), db: AsyncSession = Depends(get_db)):
    repo = KaryakarRepository(db)
    xetra_ids = await repo.get_xetra_ids(current.id)
    mandal_ids = await repo.get_mandal_ids(current.id)
    data = current.__dict__.copy()
    data["xetra_ids"] = xetra_ids
    data["mandal_ids"] = mandal_ids
    return data

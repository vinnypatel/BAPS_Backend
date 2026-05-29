from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.ext.asyncio import AsyncSession
from core.dependencies import get_db, get_current_karyakar
from models.karyakar import Karyakar
from services.mandal_service import MandalService
from schemas.mandal import MandalResponse, MandalCreate, MandalUpdate

router = APIRouter(prefix="/mandals", tags=["mandals"])

@router.get("", response_model=list[MandalResponse])
async def list_mandals(
    xetra_id: str | None = Query(None),
    include_all: bool = Query(False, alias="all"),
    current_user: Karyakar = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = MandalService(db)
    return await service.get_all(current_user, xetra_id, include_all)

@router.get("/{id}", response_model=MandalResponse)
async def get_mandal(
    id: str,
    _: str = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = MandalService(db)
    return await service.get_by_id(id)

@router.post("", response_model=MandalResponse)
async def create_mandal(
    mandal_data: MandalCreate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only sant_nirdeshak or admin can create mandals"
        )
    service = MandalService(db)
    return await service.create(mandal_data)

@router.patch("/{id}", response_model=MandalResponse)
async def update_mandal(
    id: str,
    data: MandalUpdate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only sant_nirdeshak or admin can update mandals"
        )
    service = MandalService(db)
    return await service.update(id, data)

@router.delete("/{id}")
async def delete_mandal(
    id: str,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only sant_nirdeshak or admin can delete mandals"
        )
    service = MandalService(db)
    await service.delete(id)
    return {"message": "Mandal deleted"}

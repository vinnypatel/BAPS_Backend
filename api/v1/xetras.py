from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.ext.asyncio import AsyncSession
from core.dependencies import get_db, get_current_karyakar
from models.karyakar import Karyakar
from services.xetra_service import XetraService
from schemas.xetra import XetraResponse, XetraCreate, XetraUpdate

router = APIRouter(prefix="/xetras", tags=["xetras"])

@router.get("", response_model=list[XetraResponse])
async def list_xetras(
    include_all: bool = Query(False, alias="all"),
    current_user: Karyakar = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = XetraService(db)
    return await service.get_all(current_user, include_all)

@router.post("", response_model=XetraResponse)
async def create_xetra(
    xetra_data: XetraCreate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only sant_nirdeshak or admin can create xetras"
        )
    service = XetraService(db)
    return await service.create(xetra_data)

@router.patch("/{id}", response_model=XetraResponse)
async def update_xetra(
    id: str,
    data: XetraUpdate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only sant_nirdeshak or admin can update xetras"
        )
    service = XetraService(db)
    return await service.update(id, data)

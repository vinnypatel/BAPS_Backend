from fastapi import APIRouter, Depends, HTTPException, status, File, UploadFile
from sqlalchemy.ext.asyncio import AsyncSession
from core.dependencies import get_db, get_current_karyakar
from services.karyakar_service import KaryakarService
from schemas.karyakar import KaryakarResponse, KaryakarCreate, KaryakarUpdate, KaryakarProfileUpdate
from typing import List
import shutil
import os
import uuid

router = APIRouter(prefix="/karyakars", tags=["karyakars"])

@router.get("", response_model=list[KaryakarResponse])
async def list_karyakars(
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = KaryakarService(db)
    return await service.get_all(current_user)

@router.get("/me", response_model=KaryakarResponse)
async def get_me(current_user = Depends(get_current_karyakar)):
    return current_user

@router.patch("/me", response_model=KaryakarResponse)
async def update_my_profile(
    data: KaryakarProfileUpdate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = KaryakarService(db)
    return await service.update_profile(current_user.id, data.model_dump(exclude_unset=True))

@router.get("/{id}", response_model=KaryakarResponse)
async def get_karyakar(
    id: str,
    _: str = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = KaryakarService(db)
    return await service.get_by_id(id)

@router.post("", response_model=KaryakarResponse)
async def create_karyakar(
    data: KaryakarCreate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can create karyakars")
    service = KaryakarService(db)
    return await service.create(data)

@router.put("/{id}/mandals")
async def update_karyakar_mandals(
    id: str,
    mandal_ids: List[str],
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can manage mandals")
    service = KaryakarService(db)
    return await service.update_mandals(id, mandal_ids)

@router.put("/{id}/xetras")
async def update_karyakar_xetras(
    id: str,
    xetra_ids: List[str],
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can manage xetras")
    service = KaryakarService(db)
    return await service.update_xetras(id, xetra_ids)

@router.post("/{id}/assignments")
async def update_karyakar_assignments(
    id: str,
    data: KaryakarUpdate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can manage assignments")
    service = KaryakarService(db)
    return await service.update(id, data)

@router.patch("/{id}", response_model=KaryakarResponse)
async def update_karyakar(
    id: str,
    data: KaryakarUpdate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can update karyakars")
    service = KaryakarService(db)
    return await service.update(id, data)

@router.delete("/{id}")
async def delete_karyakar(
    id: str,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can delete karyakars")
    service = KaryakarService(db)
    await service.delete(id)
    return {"message": "Karyakar deleted successfully"}

@router.post("/{id}/avatar")
async def upload_karyakar_avatar(
    id: str,
    file: UploadFile = File(...),
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    # Only allow self-upload or admin
    if current_user.id != id and current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Permission denied")
        
    # Create directory if not exists
    os.makedirs("uploads/avatars", exist_ok=True)
    
    file_ext = os.path.splitext(file.filename)[1]
    file_name = f"kk_{id}_{uuid.uuid4().hex}{file_ext}"
    file_path = os.path.join("uploads/avatars", file_name)
    
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
        
    # Update DB
    service = KaryakarService(db)
    avatar_url = f"/uploads/avatars/{file_name}"
    await service.update_profile(id, {"avatar": avatar_url})
    
    return {"avatar": avatar_url}

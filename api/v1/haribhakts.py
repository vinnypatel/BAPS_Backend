from fastapi import APIRouter, Depends, HTTPException, status, Query, File, UploadFile
from sqlalchemy.ext.asyncio import AsyncSession
from core.dependencies import get_db, get_current_karyakar
from services.haribhakt_service import HaribhaktService
from schemas.haribhakt import HaribhaktResponse, HaribhaktCreate, HaribhaktUpdate
from typing import List
import shutil
import os
import uuid

router = APIRouter(prefix="/haribhakts", tags=["haribhakts"])

@router.get("", response_model=List[HaribhaktResponse])
async def list_haribhakts(
    search: str | None = Query(None),
    mandal_id: str | None = Query(None),
    family_id: str | None = Query(None),
    view: str | None = Query(None),
    include_all: bool = Query(False, alias="all"),
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = HaribhaktService(db)
    filters = {
        'search': search,
        'mandal_id': mandal_id,
        'family_id': family_id,
        'view': view,
        'all': include_all
    }
    return await service.get_all(current_user, filters)

@router.get("/{id}", response_model=HaribhaktResponse)
async def get_haribhakt(
    id: str,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = HaribhaktService(db)
    # Note: Scoping for single fetch could be added here
    return await service.get_by_id(id)

@router.post("", response_model=HaribhaktResponse)
async def create_haribhakt(
    data: HaribhaktCreate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = HaribhaktService(db)
    return await service.create(data, current_user)

@router.patch("/{id}", response_model=HaribhaktResponse)
async def update_haribhakt(
    id: str,
    data: HaribhaktUpdate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = HaribhaktService(db)
    return await service.update(id, data, current_user)

@router.patch("/{id}/status", response_model=HaribhaktResponse)
async def toggle_haribhakt_status(
    id: str,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = HaribhaktService(db)
    return await service.toggle_status(id, current_user)

@router.post("/family/{family_id}/action")
async def handle_family_action(
    family_id: str,
    action: str,
    extra_data: dict | None = None,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = HaribhaktService(db)
    count = await service.handle_family_action(family_id, action, current_user, extra_data)
    return {"message": f"Action {action} applied to {count} family members", "count": count}
@router.delete("/{id}")
async def delete_haribhakt(
    id: str,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = HaribhaktService(db)
    success = await service.delete(id, current_user)
    if not success:
        raise HTTPException(status_code=404, detail="Haribhakt not found or already deleted")
    return {"message": "Haribhakt deleted successfully"}

@router.post("/{id}/avatar")
async def upload_haribhakt_avatar(
    id: str,
    file: UploadFile = File(...),
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    # Create directory if not exists
    os.makedirs("uploads/avatars", exist_ok=True)
    
    file_ext = os.path.splitext(file.filename)[1]
    file_name = f"hb_{id}_{uuid.uuid4().hex}{file_ext}"
    file_path = os.path.join("uploads/avatars", file_name)
    
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
        
    # Update DB
    service = HaribhaktService(db)
    avatar_url = f"/uploads/avatars/{file_name}"
    # Scoping check inside update
    await service.update(id, {"avatar": avatar_url}, current_user)
    
    return {"avatar": avatar_url}

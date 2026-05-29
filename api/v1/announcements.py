from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from core.dependencies import get_db, get_current_karyakar
from services.announcement_service import AnnouncementService
from schemas.announcement import AnnouncementResponse, AnnouncementCreate
from typing import List

router = APIRouter(prefix="/announcements", tags=["announcements"])

@router.get("", response_model=List[AnnouncementResponse])
async def list_announcements(
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = AnnouncementService(db)
    return await service.get_all_for_user(current_user)

@router.post("", response_model=AnnouncementResponse)
async def create_announcement(
    data: AnnouncementCreate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can create announcements")
    service = AnnouncementService(db)
    return await service.create(data)

@router.patch("/{id}", response_model=AnnouncementResponse)
async def update_announcement(
    id: str,
    data: AnnouncementCreate,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can update announcements")
    service = AnnouncementService(db)
    return await service.update(id, data)

@router.delete("/{id}")
async def delete_announcement(
    id: str,
    current_user = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    if current_user.role not in ["sant_nirdeshak", "admin"]:
        raise HTTPException(status_code=403, detail="Only sant_nirdeshak or admin can delete announcements")
    service = AnnouncementService(db)
    await service.delete(id)
    return {"message": "Announcement deleted"}

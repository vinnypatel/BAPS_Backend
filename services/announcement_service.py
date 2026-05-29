from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from repositories.announcement_repo import AnnouncementRepository
from models.announcement import Announcement

class AnnouncementService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.repo = AnnouncementRepository(db)
        
    async def get_all(self) -> list[Announcement]:
        return await self.repo.get_all()
        
    async def get_all_for_user(self, user) -> list[Announcement]:
        return await self.repo.get_all_for_user(user)
    async def create(self, data) -> Announcement:
        announcement = Announcement(**data.model_dump())
        return await self.repo.create(announcement)

    async def delete(self, id: str) -> bool:
        success = await self.repo.delete(id)
        if not success:
            raise HTTPException(status_code=404, detail="Announcement not found")
        return True

    async def update(self, id: str, data) -> Announcement:
        announcement = await self.repo.get_by_id(id)
        if not announcement:
            raise HTTPException(status_code=404, detail="Announcement not found")
            
        update_dict = data.model_dump(exclude_unset=True)
        for key, value in update_dict.items():
            setattr(announcement, key, value)
            
        return await self.repo.update(announcement)

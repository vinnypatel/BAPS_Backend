"""
Author: BAPS Atladara Development Team
"""

from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from repositories.mandal_repo import MandalRepository
from models.mandal import Mandal
from models.karyakar import Karyakar

class MandalService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.repo = MandalRepository(db)

    async def get_all(self, actor: Karyakar, xetra_id: str | None = None, include_all: bool = False) -> list[Mandal]:
        filters = {'xetra_id': xetra_id} if xetra_id else {}
        
        # Role-based scoping
        if include_all or actor.role in ["sant_nirdeshak", "sanyojak", "admin"]:
            pass # Global access
        elif actor.role == "nirdeshak":
            # Must have explicit xetras, or see nothing
            filters['xetra_id_list'] = actor.xetra_ids if actor.xetra_ids else ["NONE"]
        elif actor.role in ["sah_nirdeshak", "mandal_sanchalak", "nirikshak", "sampark_karyakar"]:
            # Must have explicit mandals, or see nothing
            filters['mandal_id_list'] = actor.mandal_ids if actor.mandal_ids else ["NONE"]
                
        return await self.repo.get_all(filters)

    async def get_by_id(self, mandal_id: str) -> Mandal:
        mandal = await self.repo.get_by_id(mandal_id)
        if not mandal:
            raise HTTPException(status_code=404, detail="Mandal not found")
        return mandal

    async def create(self, mandal_data) -> Mandal:
        mandal = Mandal(**mandal_data.model_dump())
        return await self.repo.create(mandal)

    async def update(self, mandal_id: str, update_data) -> Mandal:
        mandal = await self.get_by_id(mandal_id)
        data = update_data.model_dump(exclude_unset=True)
        for key, value in data.items():
            setattr(mandal, key, value)
        return await self.repo.update(mandal)

    async def delete(self, mandal_id: str) -> bool:
        mandal = await self.get_by_id(mandal_id)
        return await self.repo.delete(mandal_id)


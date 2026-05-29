"""
Author: BAPS Atladara Development Team
"""

from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from repositories.xetra_repo import XetraRepository
from models.xetra import Xetra
from models.karyakar import Karyakar

class XetraService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.repo = XetraRepository(db)

    async def get_all(self, actor: Karyakar, include_all: bool = False) -> list[Xetra]:
        filters = {}
        
        # Role-based scoping
        if include_all or actor.role in ["sant_nirdeshak", "sanyojak", "admin"]:
            pass # Global access
        else:
            # Must have explicit xetras, or see nothing
            filters['xetra_id_list'] = actor.xetra_ids if actor.xetra_ids else ["NONE"]
                
        return await self.repo.get_all(filters)

    async def get_by_id(self, xetra_id: str) -> Xetra:
        xetra = await self.repo.get_by_id(xetra_id)
        if not xetra:
            raise HTTPException(status_code=404, detail="Xetra not found")
        return xetra

    async def create(self, xetra_data) -> Xetra:
        xetra = Xetra(**xetra_data.model_dump())
        return await self.repo.create(xetra)

    async def update(self, xetra_id: str, update_data) -> Xetra:
        xetra = await self.get_by_id(xetra_id)
        data = update_data.model_dump(exclude_unset=True)
        for key, value in data.items():
            setattr(xetra, key, value)
        return await self.repo.update(xetra)


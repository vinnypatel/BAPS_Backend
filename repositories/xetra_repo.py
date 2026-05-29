"""
Author: BAPS Atladara Development Team
"""

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from models.xetra import Xetra

class XetraRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_all(self, filters: dict = None) -> list[Xetra]:
        query = select(Xetra)
        if filters and filters.get('xetra_id_list'):
            query = query.where(Xetra.id.in_(filters['xetra_id_list']))
        result = await self.db.execute(query)
        return result.scalars().all()

    async def get_by_id(self, xetra_id: str) -> Xetra | None:
        result = await self.db.execute(select(Xetra).where(Xetra.id == xetra_id))
        return result.scalars().first()

    async def create(self, xetra: Xetra) -> Xetra:
        self.db.add(xetra)
        await self.db.flush()
        await self.db.refresh(xetra)
        return xetra


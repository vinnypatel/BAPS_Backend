"""
Author: BAPS Atladara Development Team
"""

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from models.mandal import Mandal

class MandalRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_all(self, filters: dict = None) -> list[Mandal]:
        query = select(Mandal)
        if filters:
            if filters.get('xetra_id'):
                query = query.where(Mandal.xetra_id == filters['xetra_id'])
            if filters.get('xetra_id_list'):
                query = query.where(Mandal.xetra_id.in_(filters['xetra_id_list']))
            if filters.get('mandal_id_list'):
                query = query.where(Mandal.id.in_(filters['mandal_id_list']))
        result = await self.db.execute(query)
        return result.scalars().all()

    async def get_by_id(self, mandal_id: str) -> Mandal | None:
        result = await self.db.execute(select(Mandal).where(Mandal.id == mandal_id))
        return result.scalars().first()

    async def create(self, mandal: Mandal) -> Mandal:
        self.db.add(mandal)
        await self.db.flush()
        await self.db.refresh(mandal)
        return mandal


"""
Author: BAPS Atladara Development Team
"""

from sqlalchemy import select
from sqlalchemy.orm import selectinload
from sqlalchemy.ext.asyncio import AsyncSession
from models.karyakar import Karyakar
from models.xetra import Xetra
from models.mandal import Mandal

class KaryakarRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_all(self, filters: dict = None) -> list[Karyakar]:
        query = select(Karyakar).options(
            selectinload(Karyakar.mandals),
            selectinload(Karyakar.xetras)
        )
        
        if filters:
            if 'mandal_id' in filters:
                m_ids = filters['mandal_id']
                if isinstance(m_ids, list):
                    query = query.join(Karyakar.mandals).where(Mandal.id.in_(m_ids))
                else:
                    query = query.join(Karyakar.mandals).where(Mandal.id == m_ids)
            
            if 'xetra_id' in filters:
                x_ids = filters['xetra_id']
                if isinstance(x_ids, list):
                    query = query.join(Karyakar.xetras).where(Xetra.id.in_(x_ids))
                else:
                    query = query.join(Karyakar.xetras).where(Xetra.id == x_ids)

            for key, value in filters.items():
                if key not in ['mandal_id', 'xetra_id'] and value is not None and hasattr(Karyakar, key):
                    attr = getattr(Karyakar, key)
                    if isinstance(value, list):
                        query = query.where(attr.in_(value))
                    else:
                        query = query.where(attr == value)
        
        # Ensure we don't get duplicates due to joins
        query = query.distinct()
        
        result = await self.db.execute(query)
        return result.scalars().all()

    async def get_by_id(self, karyakar_id: str) -> Karyakar | None:
        query = select(Karyakar).where(Karyakar.id == karyakar_id).options(
            selectinload(Karyakar.mandals),
            selectinload(Karyakar.xetras)
        )
        result = await self.db.execute(query)
        return result.scalars().first()

    async def get_by_username(self, username: str) -> Karyakar | None:
        query = select(Karyakar).where(Karyakar.username == username).options(
            selectinload(Karyakar.mandals),
            selectinload(Karyakar.xetras)
        )
        result = await self.db.execute(query)
        return result.scalars().first()

    async def create(self, karyakar: Karyakar) -> Karyakar:
        self.db.add(karyakar)
        await self.db.flush()
        await self.db.refresh(karyakar)
        return karyakar

    async def update(self, karyakar: Karyakar) -> Karyakar:
        self.db.add(karyakar)
        await self.db.flush()
        await self.db.refresh(karyakar)
        return karyakar


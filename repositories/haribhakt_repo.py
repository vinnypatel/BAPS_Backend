"""
Author: BAPS Atladara Development Team
"""

from sqlalchemy import select, or_
from sqlalchemy.ext.asyncio import AsyncSession
from models.haribhakt import Haribhakt

class HaribhaktRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_all(self, filters: dict = None) -> list[Haribhakt]:
        query = select(Haribhakt)
        if filters:
            for key, value in filters.items():
                if value is not None:
                    if key == 'search':
                        query = query.where(or_(
                            Haribhakt.full_name.ilike(f"%{value}%"),
                            Haribhakt.mobile.ilike(f"%{value}%"),
                            Haribhakt.person_id.ilike(f"%{value}%")
                        ))
                    elif hasattr(Haribhakt, key):
                        attr = getattr(Haribhakt, key)
                        if isinstance(value, list):
                            query = query.where(attr.in_(value))
                        else:
                            query = query.where(attr == value)
        result = await self.db.execute(query)
        return result.scalars().all()

    async def get_by_id(self, haribhakt_id: str) -> Haribhakt | None:
        result = await self.db.execute(select(Haribhakt).where(Haribhakt.id == haribhakt_id))
        return result.scalars().first()

    async def get_by_family_id(self, family_id: str) -> list[Haribhakt]:
        result = await self.db.execute(
            select(Haribhakt).where(
                or_(
                    Haribhakt.family_id == family_id,
                    Haribhakt.id == family_id
                )
            )
        )
        return result.scalars().all()

    async def create(self, haribhakt: Haribhakt) -> Haribhakt:
        self.db.add(haribhakt)
        await self.db.flush()
        await self.db.refresh(haribhakt)
        return haribhakt

    async def update(self, haribhakt: Haribhakt) -> Haribhakt:
        self.db.add(haribhakt)
        await self.db.flush()
        await self.db.refresh(haribhakt)
        return haribhakt

    async def delete(self, haribhakt_id: str) -> bool:
        from sqlalchemy import delete
        result = await self.db.execute(delete(Haribhakt).where(Haribhakt.id == haribhakt_id))
        await self.db.flush()
        return result.rowcount > 0

from sqlalchemy import select, delete, or_, and_
from sqlalchemy.ext.asyncio import AsyncSession
from models.announcement import Announcement

class AnnouncementRepository:
    def __init__(self, db: AsyncSession):
        self.db = db
        
    async def get_all(self) -> list[Announcement]:
        result = await self.db.execute(select(Announcement).order_by(Announcement.created_at.desc()))
        return result.scalars().all()
        
    async def get_all_for_user(self, user) -> list[Announcement]:
        # If user is admin or sant_nirdeshak, they see everything!
        if user.role in ["admin", "sant_nirdeshak"]:
            result = await self.db.execute(select(Announcement).order_by(Announcement.created_at.desc()))
            return result.scalars().all()
            
        user_mandal_ids = [m.id for m in user.mandals] if hasattr(user, "mandals") and user.mandals else []
        user_wing = user.wing if hasattr(user, "wing") else None
        user_role = user.role if hasattr(user, "role") else None
        
        # Build conditions for targeted announcements:
        # 1. Global announcements (no target fields are set)
        global_cond = and_(
            Announcement.target_karyakar_id.is_(None),
            Announcement.target_mandal_id.is_(None),
            Announcement.target_wing.is_(None),
            Announcement.target_roles.is_(None)
        )
        
        # 2. Directly targeted to this Karyakar
        direct_cond = Announcement.target_karyakar_id == user.id
        
        # 3. Targeted to this Karyakar's Mandal
        mandal_cond = None
        if user_mandal_ids:
            # Must match the mandal id
            m_cond = Announcement.target_mandal_id.in_(user_mandal_ids)
            
            # Optional Wing condition (if set, must match user's wing)
            w_cond = or_(
                Announcement.target_wing.is_(None),
                Announcement.target_wing == user_wing
            )
            
            # Optional Role condition (if set, user's role must be listed in target_roles)
            r_cond = or_(
                Announcement.target_roles.is_(None),
                Announcement.target_roles.contains(user_role)
            )
            
            mandal_cond = and_(m_cond, w_cond, r_cond)
            
        conditions = [global_cond, direct_cond]
        if mandal_cond is not None:
            conditions.append(mandal_cond)
            
        query = select(Announcement).where(or_(*conditions)).order_by(Announcement.created_at.desc())
        result = await self.db.execute(query)
        return result.scalars().all()
        
    async def create(self, announcement: Announcement) -> Announcement:
        self.db.add(announcement)
        await self.db.flush()
        await self.db.refresh(announcement)
        return announcement

    async def delete(self, id: str) -> bool:
        result = await self.db.execute(delete(Announcement).where(Announcement.id == id))
        return result.rowcount > 0

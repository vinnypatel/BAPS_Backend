from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from repositories.karyakar_repo import KaryakarRepository
from repositories.xetra_repo import XetraRepository
from repositories.mandal_repo import MandalRepository
from models.karyakar import Karyakar
from core.security import hash_password

class KaryakarService:
    ROLE_HIERARCHY = {
        'admin': 8,
        'sant_nirdeshak': 7,
        'sanyojak': 6,
        'nirdeshak': 5,
        'sah_nirdeshak': 4,
        'nirikshak': 3,
        'mandal_sanchalak': 2,
        'sampark_karyakar': 1
    }

    def __init__(self, db: AsyncSession):
        self.db = db
        self.repo = KaryakarRepository(db)
        self.xetra_repo = XetraRepository(db)
        self.mandal_repo = MandalRepository(db)

    async def assign_karyakar_id_if_needed(self, karyakar: Karyakar, force: bool = False):
        from sqlalchemy import select
        import uuid

        if karyakar.role == 'sampark_karyakar':
            if not force and karyakar.karyakar_number and karyakar.karyakar_number.startswith("Sk-"):
                return
                
            query = select(Karyakar).where(
                Karyakar.role == 'sampark_karyakar',
                Karyakar.id != karyakar.id
            )
            res = await self.db.execute(query)
            sks = res.scalars().all()
            
            # Sort by joined_at and then ID to keep stable creation order
            sks_sorted = sorted(sks, key=lambda x: (x.joined_at or "", x.id))
            serial_no = len(sks_sorted) + 1
            karyakar.karyakar_number = f"Sk-{serial_no}"
        else:
            if not karyakar.karyakar_number or karyakar.karyakar_number.startswith("Sk-"):
                karyakar.karyakar_number = f"kk_{uuid.uuid4().hex[:8]}"


    async def get_all(self, current_user: Karyakar) -> list[Karyakar]:
        filters = {}
        if current_user.role not in ['admin', 'sant_nirdeshak', 'sanyojak']:
            if current_user.role == 'nirdeshak':
                filters['xetra_id'] = current_user.xetra_ids
            elif current_user.role in ['sah_nirdeshak', 'nirikshak', 'mandal_sanchalak', 'sampark_karyakar']:
                filters['mandal_id'] = current_user.mandal_ids
            
            if current_user.wing:
                filters['wing'] = current_user.wing
        
        all_karyakars = await self.repo.get_all(filters)
        
        user_level = self.ROLE_HIERARCHY.get(current_user.role, 0)
        
        # Filter by hierarchy: only see those with lower level
        return [
            k for k in all_karyakars 
            if self.ROLE_HIERARCHY.get(k.role, 0) < user_level
        ]

    async def get_by_id(self, karyakar_id: str) -> Karyakar:
        karyakar = await self.repo.get_by_id(karyakar_id)
        if not karyakar:
            raise HTTPException(status_code=404, detail="Karyakar not found")
        return karyakar

    async def get_by_username(self, username: str) -> Karyakar:
        karyakar = await self.repo.get_by_username(username)
        if not karyakar:
            raise HTTPException(status_code=404, detail="Karyakar not found")
        return karyakar

    async def create(self, karyakar_data) -> Karyakar:
        # Check if username exists
        existing = await self.repo.get_by_username(karyakar_data.username)
        if existing:
            raise HTTPException(status_code=400, detail="Username already registered")
        
        data = karyakar_data.model_dump()
        password = data.pop('password')
        xetra_ids = data.pop('xetra_ids', [])
        mandal_ids = data.pop('mandal_ids', [])
        
        data['password_hash'] = hash_password(password)

        
        karyakar = Karyakar(**data)
        
        # Add relationships
        if xetra_ids:
            for x_id in xetra_ids:
                xetra = await self.xetra_repo.get_by_id(x_id)
                if xetra:
                    karyakar.xetras.append(xetra)
        
        if mandal_ids:
            for m_id in mandal_ids:
                mandal = await self.mandal_repo.get_by_id(m_id)
                if mandal:
                    karyakar.mandals.append(mandal)
                    
        await self.assign_karyakar_id_if_needed(karyakar)
        return await self.repo.create(karyakar)

    async def update_mandals(self, karyakar_id: str, mandal_ids: list[str]) -> Karyakar:
        karyakar = await self.get_by_id(karyakar_id)
        old_mandals = list(karyakar.mandals)
        old_mandal_ids = {m.id for m in old_mandals}
        old_mandal_names = [m.name for m in old_mandals]
        
        karyakar.mandals = []
        for m_id in mandal_ids:
            mandal = await self.mandal_repo.get_by_id(m_id)
            if mandal:
                karyakar.mandals.append(mandal)
                
        new_mandals = list(karyakar.mandals)
        new_mandal_ids = {m.id for m in new_mandals}
        new_mandal_names = [m.name for m in new_mandals]
        
        if old_mandal_ids != new_mandal_ids:
            import uuid
            from models.announcement import Announcement
            
            # 1. Notify the Karyakar directly
            announcement = Announcement(
                id=f"ann_{uuid.uuid4().hex}",
                title="Mandal Assignments Updated",
                content=f"Your mandal assignments have been updated. Assigned Mandals: {', '.join(new_mandal_names) if new_mandal_names else 'None'}.",
                target_karyakar_id=karyakar.id
            )
            self.db.add(announcement)
            
            # 2. Notify sanchalaks and nirikshaks of newly assigned mandals
            for mandal in new_mandals:
                if mandal.id not in old_mandal_ids:
                    ann = Announcement(
                        id=f"ann_{uuid.uuid4().hex}",
                        title="New Karyakar Assigned to Mandal",
                        content=f"Karyakar {karyakar.name} ({karyakar.karyakar_number}) has been assigned to Mandal {mandal.name}.",
                        target_mandal_id=mandal.id,
                        target_wing=karyakar.wing,
                        target_roles="mandal_sanchalak,nirikshak"
                    )
                    self.db.add(ann)
                    
            # 3. Notify sanchalaks and nirikshaks of unassigned mandals
            for mandal in old_mandals:
                if mandal.id not in new_mandal_ids:
                    ann = Announcement(
                        id=f"ann_{uuid.uuid4().hex}",
                        title="Karyakar Deassigned from Mandal",
                        content=f"Karyakar {karyakar.name} ({karyakar.karyakar_number}) has been deassigned from Mandal {mandal.name}.",
                        target_mandal_id=mandal.id,
                        target_wing=karyakar.wing,
                        target_roles="mandal_sanchalak,nirikshak"
                    )
                    self.db.add(ann)
            
        await self.assign_karyakar_id_if_needed(karyakar)
        return await self.repo.update(karyakar)

    async def update_xetras(self, karyakar_id: str, xetra_ids: list[str]) -> Karyakar:
        karyakar = await self.get_by_id(karyakar_id)
        old_xetra_names = [x.name for x in karyakar.xetras]
        
        karyakar.xetras = []
        for x_id in xetra_ids:
            xetra = await self.xetra_repo.get_by_id(x_id)
            if xetra:
                karyakar.xetras.append(xetra)
                
        new_xetra_names = [x.name for x in karyakar.xetras]
        if set(old_xetra_names) != set(new_xetra_names):
            import uuid
            from models.announcement import Announcement
            announcement = Announcement(
                id=f"ann_{uuid.uuid4().hex}",
                title="Xetra Assignments Updated",
                content=f"Your xetra assignments have been updated. Assigned Xetras: {', '.join(new_xetra_names) if new_xetra_names else 'None'}.",
                target_karyakar_id=karyakar.id
            )
            self.db.add(announcement)
            
        return await self.repo.update(karyakar)

    async def update(self, karyakar_id: str, update_data) -> Karyakar:
        karyakar = await self.get_by_id(karyakar_id)
        old_role = karyakar.role
        old_mandals = list(karyakar.mandals)
        old_mandal_ids = {m.id for m in old_mandals}
        old_mandal_names = [m.name for m in old_mandals]
        old_xetra_names = [x.name for x in karyakar.xetras]
        
        data = update_data.model_dump(exclude_unset=True)
        
        mandal_changed = False
        xetra_changed = False
        role_changed = False
        
        if 'password' in data:
            karyakar.password_hash = hash_password(data.pop('password'))
            
        if 'mandal_ids' in data or 'mandalIds' in data:
            mandal_ids = data.pop('mandal_ids', data.pop('mandalIds', []))
            karyakar.mandals = []
            for m_id in mandal_ids:
                mandal = await self.mandal_repo.get_by_id(m_id)
                if mandal:
                    karyakar.mandals.append(mandal)
            mandal_changed = True
                    
        if 'xetra_ids' in data or 'xetraIds' in data:
            xetra_ids = data.pop('xetra_ids', data.pop('xetraIds', []))
            karyakar.xetras = []
            for x_id in xetra_ids:
                xetra = await self.xetra_repo.get_by_id(x_id)
                if xetra:
                    karyakar.xetras.append(xetra)
            xetra_changed = True
                    
        for key, value in data.items():
            if hasattr(karyakar, key):
                setattr(karyakar, key, value)
                
        if old_role != karyakar.role:
            role_changed = True
            
        # Generate Targeted Notifications/Announcements
        import uuid
        from models.announcement import Announcement
        
        if role_changed:
            # 1. Direct notification to karyakar
            announcement = Announcement(
                id=f"ann_{uuid.uuid4().hex}",
                title="Your Role Changed",
                content=f"Your role has been changed from {old_role} to {karyakar.role}.",
                target_karyakar_id=karyakar.id
            )
            self.db.add(announcement)
            
            # 2. Notify sanchalaks and nirikshaks of their assigned mandals
            for mandal in karyakar.mandals:
                ann = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="Karyakar Role Changed in Mandal",
                    content=f"Role for Karyakar {karyakar.name} ({karyakar.karyakar_number}) in Mandal {mandal.name} has been changed from {old_role} to {karyakar.role}.",
                    target_mandal_id=mandal.id,
                    target_wing=karyakar.wing,
                    target_roles="mandal_sanchalak,nirikshak"
                )
                self.db.add(ann)
            
        if mandal_changed:
            new_mandals = list(karyakar.mandals)
            new_mandal_ids = {m.id for m in new_mandals}
            new_mandal_names = [m.name for m in new_mandals]
            
            if old_mandal_ids != new_mandal_ids:
                # 1. Direct notification
                announcement = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="Mandal Assignments Updated",
                    content=f"Your mandal assignments have been updated. Assigned Mandals: {', '.join(new_mandal_names) if new_mandal_names else 'None'}.",
                    target_karyakar_id=karyakar.id
                )
                self.db.add(announcement)
                
                # 2. Notify sanchalaks and nirikshaks of newly assigned mandals
                for mandal in new_mandals:
                    if mandal.id not in old_mandal_ids:
                        ann = Announcement(
                            id=f"ann_{uuid.uuid4().hex}",
                            title="New Karyakar Assigned to Mandal",
                            content=f"Karyakar {karyakar.name} ({karyakar.karyakar_number}) has been assigned to Mandal {mandal.name}.",
                            target_mandal_id=mandal.id,
                            target_wing=karyakar.wing,
                            target_roles="mandal_sanchalak,nirikshak"
                        )
                        self.db.add(ann)
                        
                # 3. Notify sanchalaks and nirikshaks of unassigned mandals
                for mandal in old_mandals:
                    if mandal.id not in new_mandal_ids:
                        ann = Announcement(
                            id=f"ann_{uuid.uuid4().hex}",
                            title="Karyakar Deassigned from Mandal",
                            content=f"Karyakar {karyakar.name} ({karyakar.karyakar_number}) has been deassigned from Mandal {mandal.name}.",
                            target_mandal_id=mandal.id,
                            target_wing=karyakar.wing,
                            target_roles="mandal_sanchalak,nirikshak"
                        )
                        self.db.add(ann)
                
        if xetra_changed:
            new_xetra_names = [x.name for x in karyakar.xetras]
            if set(old_xetra_names) != set(new_xetra_names):
                announcement = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="Xetra Assignments Updated",
                    content=f"Your xetra assignments have been updated. Assigned Xetras: {', '.join(new_xetra_names) if new_xetra_names else 'None'}.",
                    target_karyakar_id=karyakar.id
                )
                self.db.add(announcement)
            
        await self.assign_karyakar_id_if_needed(karyakar)
        return await self.repo.update(karyakar)

    async def delete(self, karyakar_id: str) -> bool:
        karyakar = await self.get_by_id(karyakar_id)
        return await self.repo.delete(karyakar_id)

    async def update_profile(self, karyakar_id: str, profile_data: dict) -> Karyakar:
        karyakar = await self.get_by_id(karyakar_id)
        
        if 'password' in profile_data and profile_data['password']:
            karyakar.password_hash = hash_password(profile_data['password'])
            
        if 'phone' in profile_data:
            karyakar.phone = profile_data['phone']
            
        if 'email' in profile_data:
            karyakar.email = profile_data['email']
        
        if 'mfa_enabled' in profile_data:
            karyakar.mfa_enabled = profile_data['mfa_enabled']

        if 'avatar' in profile_data:
            karyakar.avatar = profile_data['avatar']

        return await self.repo.update(karyakar)

    async def unlock_login_access(self, username: str) -> Karyakar:
        karyakar = await self.repo.get_by_username(username)
        if not karyakar:
            raise HTTPException(status_code=404, detail="Karyakar not found")

        karyakar.failed_login_attempts = 0
        karyakar.temporary_login_block_until = None
        karyakar.locked_at = None
        karyakar.lock_reason = None
        karyakar.last_failed_login_at = None
        karyakar.status = "active"
        return await self.repo.update(karyakar)
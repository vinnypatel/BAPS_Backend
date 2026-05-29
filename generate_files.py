import os

files = {}

# MODELS
files['models/mandal.py'] = '''from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from db.base import Base

class Mandal(Base):
    __tablename__ = "mandals"
    
    id: Mapped[str] = mapped_column(String(20), primary_key=True, index=True)
    xetra_id: Mapped[str] = mapped_column(String(10), index=True)
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    wing: Mapped[str] = mapped_column(String(50), nullable=False)
    total_haribhakts: Mapped[int] = mapped_column(Integer, default=0)
    
    def __repr__(self) -> str:
        return f"<Mandal(id='{self.id}', name='{self.name}')>"
'''

files['models/xetra.py'] = '''from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import Mapped, mapped_column
from db.base import Base

class Xetra(Base):
    __tablename__ = "xetras"
    
    id: Mapped[str] = mapped_column(String(10), primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(50), nullable=False)
    total_mandals: Mapped[int] = mapped_column(Integer, default=0)
    total_karyakars: Mapped[int] = mapped_column(Integer, default=0)
    total_haribhakts: Mapped[int] = mapped_column(Integer, default=0)
    
    def __repr__(self) -> str:
        return f"<Xetra(id='{self.id}', name='{self.name}')>"
'''

files['models/karyakar.py'] = '''from sqlalchemy import Column, String, Table, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from db.base import Base
from models.xetra import Xetra
from models.mandal import Mandal

karyakar_xetra_association = Table(
    'karyakar_xetra',
    Base.metadata,
    Column('karyakar_id', String(50), ForeignKey('karyakars.id', ondelete='CASCADE')),
    Column('xetra_id', String(10), ForeignKey('xetras.id', ondelete='CASCADE'))
)

karyakar_mandal_association = Table(
    'karyakar_mandal',
    Base.metadata,
    Column('karyakar_id', String(50), ForeignKey('karyakars.id', ondelete='CASCADE')),
    Column('mandal_id', String(20), ForeignKey('mandals.id', ondelete='CASCADE'))
)

class Karyakar(Base):
    __tablename__ = "karyakars"
    
    id: Mapped[str] = mapped_column(String(50), primary_key=True, index=True)
    karyakar_number: Mapped[str] = mapped_column(String(50), nullable=False)
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    role: Mapped[str] = mapped_column(String(50), nullable=False)
    username: Mapped[str] = mapped_column(String(100), nullable=False, unique=True, index=True)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    phone: Mapped[str | None] = mapped_column(String(20), nullable=True)
    email: Mapped[str | None] = mapped_column(String(150), nullable=True)
    avatar: Mapped[str | None] = mapped_column(String(255), nullable=True)
    birthday: Mapped[str | None] = mapped_column(String(50), nullable=True)
    wing: Mapped[str | None] = mapped_column(String(50), nullable=True)
    gender: Mapped[str | None] = mapped_column(String(20), nullable=True)
    
    xetras = relationship('Xetra', secondary=karyakar_xetra_association, lazy='selectin')
    mandals = relationship('Mandal', secondary=karyakar_mandal_association, lazy='selectin')

    @property
    def mandal_ids(self) -> list[str]:
        if "mandals" not in self.__dict__:
            return []
        return [m.id for m in self.mandals]

    @property
    def xetra_ids(self) -> list[str]:
        if "xetras" not in self.__dict__:
            return []
        return [x.id for x in self.xetras]
'''

files['models/haribhakt.py'] = '''from sqlalchemy import Column, String, Boolean
from sqlalchemy.orm import Mapped, mapped_column
from db.base import Base

class Haribhakt(Base):
    __tablename__ = "haribhakts"
    
    id: Mapped[str] = mapped_column(String(50), primary_key=True, index=True)
    member_id: Mapped[str] = mapped_column(String(50), nullable=False)
    person_id: Mapped[str] = mapped_column(String(50), nullable=True)
    family_id: Mapped[str] = mapped_column(String(50), nullable=True)
    is_family_head: Mapped[bool] = mapped_column(Boolean, default=False)
    full_name: Mapped[str] = mapped_column(String(150), nullable=False)
    mobile: Mapped[str] = mapped_column(String(20), nullable=True)
    email: Mapped[str] = mapped_column(String(150), nullable=True)
    gender: Mapped[str] = mapped_column(String(20), nullable=True)
    dob: Mapped[str] = mapped_column(String(50), nullable=True)
    address: Mapped[str] = mapped_column(String(255), nullable=True)
    education: Mapped[str] = mapped_column(String(100), nullable=True)
    occupation: Mapped[str] = mapped_column(String(100), nullable=True)
    mandal_id: Mapped[str] = mapped_column(String(50), index=True)
    xetra_id: Mapped[str] = mapped_column(String(50), index=True)
    
    kanthi: Mapped[str] = mapped_column(String(20), nullable=True)
    daily_pooja: Mapped[bool] = mapped_column(Boolean, default=False)
    ravisabha: Mapped[bool] = mapped_column(Boolean, default=False)
    parasabha: Mapped[bool] = mapped_column(Boolean, default=False)
    ghar_mandir: Mapped[str] = mapped_column(String(20), nullable=True)
    daily_vachnamrut: Mapped[str] = mapped_column(String(50), nullable=True)
    daily_swami_vato: Mapped[bool] = mapped_column(Boolean, default=False)
    satsang_grade: Mapped[str] = mapped_column(String(10), nullable=True)
'''

files['models/announcement.py'] = '''from sqlalchemy import Column, String, Integer, Text, DateTime, func
from sqlalchemy.orm import Mapped, mapped_column
from db.base import Base

class Announcement(Base):
    __tablename__ = "announcements"
    
    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True, index=True)
    title: Mapped[str] = mapped_column(String(200), nullable=False)
    content: Mapped[str] = mapped_column(Text, nullable=False)
    priority: Mapped[str] = mapped_column(String(50), nullable=False)
    author_id: Mapped[str] = mapped_column(String(50), nullable=False)
    created_at = mapped_column(DateTime, default=func.now())
'''

# SCHEMAS
files['schemas/mandal.py'] = '''from pydantic import BaseModel

class MandalBase(BaseModel):
    id: str
    name: str
    wing: str
    xetra_id: str

class Mandal(MandalBase):
    class Config:
        from_attributes = True
'''

files['schemas/xetra.py'] = '''from pydantic import BaseModel

class XetraBase(BaseModel):
    id: str
    name: str

class Xetra(XetraBase):
    class Config:
        from_attributes = True
'''

files['schemas/karyakar.py'] = '''from pydantic import BaseModel
from typing import Optional, List
from schemas.xetra import Xetra
from schemas.mandal import Mandal

class KaryakarBase(BaseModel):
    karyakar_number: str
    name: str
    role: str
    username: str
    phone: Optional[str] = None
    email: Optional[str] = None
    wing: Optional[str] = None
    gender: Optional[str] = None

class KaryakarCreate(KaryakarBase):
    password: str
    xetra_ids: Optional[List[str]] = None
    mandal_ids: Optional[List[str]] = None

class KaryakarUpdate(BaseModel):
    name: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    password: Optional[str] = None
    xetra_ids: Optional[List[str]] = None
    mandal_ids: Optional[List[str]] = None

class KaryakarResponse(KaryakarBase):
    id: str
    xetras: List[Xetra] = []
    mandals: List[Mandal] = []
    
    class Config:
        from_attributes = True
'''

files['schemas/haribhakt.py'] = '''from pydantic import BaseModel
from typing import Optional

class HaribhaktBase(BaseModel):
    member_id: str
    person_id: Optional[str] = None
    family_id: Optional[str] = None
    is_family_head: bool = False
    full_name: str
    mobile: Optional[str] = None
    email: Optional[str] = None
    gender: Optional[str] = None
    dob: Optional[str] = None
    address: Optional[str] = None
    education: Optional[str] = None
    occupation: Optional[str] = None
    mandal_id: str
    xetra_id: str
    kanthi: Optional[str] = None
    daily_pooja: bool = False
    ravisabha: bool = False
    parasabha: bool = False
    ghar_mandir: Optional[str] = None
    daily_vachnamrut: Optional[str] = None
    daily_swami_vato: bool = False
    satsang_grade: Optional[str] = None

class HaribhaktCreate(HaribhaktBase):
    pass

class HaribhaktUpdate(HaribhaktBase):
    pass

class Haribhakt(HaribhaktBase):
    id: str
    class Config:
        from_attributes = True
'''

files['schemas/announcement.py'] = '''from pydantic import BaseModel
from datetime import datetime

class AnnouncementBase(BaseModel):
    title: str
    content: str
    priority: str

class AnnouncementCreate(AnnouncementBase):
    author_id: str

class Announcement(AnnouncementBase):
    id: int
    author_id: str
    created_at: datetime
    class Config:
        from_attributes = True
'''

# REPOSITORIES
files['repositories/xetra_repo.py'] = '''from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from models.xetra import Xetra

class XetraRepository:
    def __init__(self, db: AsyncSession):
        self.db = db
        
    async def get_all(self):
        result = await self.db.execute(select(Xetra))
        return result.scalars().all()
'''

files['repositories/mandal_repo.py'] = '''from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from models.mandal import Mandal

class MandalRepository:
    def __init__(self, db: AsyncSession):
        self.db = db
        
    async def get_all(self):
        result = await self.db.execute(select(Mandal))
        return result.scalars().all()
'''

files['repositories/karyakar_repo.py'] = '''from sqlalchemy import select
from sqlalchemy.orm import selectinload
from sqlalchemy.ext.asyncio import AsyncSession
from models.karyakar import Karyakar
from models.xetra import Xetra
from models.mandal import Mandal

class KaryakarRepository:
    def __init__(self, db: AsyncSession):
        self.db = db
        
    async def get_by_id(self, id: str):
        result = await self.db.execute(
            select(Karyakar)
            .options(selectinload(Karyakar.xetras), selectinload(Karyakar.mandals))
            .where(Karyakar.id == id)
        )
        return result.scalars().first()
        
    async def get_by_username(self, username: str):
        result = await self.db.execute(
            select(Karyakar)
            .options(selectinload(Karyakar.xetras), selectinload(Karyakar.mandals))
            .where(Karyakar.username == username)
        )
        return result.scalars().first()
        
    async def get_all(self, skip: int = 0, limit: int = 100, xetra_ids: list[str] | None = None, mandal_ids: list[str] | None = None, allowed_roles: list[str] | None = None, wing: str | None = None):
        stmt = select(Karyakar).options(selectinload(Karyakar.xetras), selectinload(Karyakar.mandals))
        
        if allowed_roles is not None:
            stmt = stmt.where(Karyakar.role.in_(allowed_roles))
            
        if wing is not None:
            stmt = stmt.where(Karyakar.wing == wing)
            
        if xetra_ids is not None:
            stmt = stmt.join(Karyakar.xetras).where(Xetra.id.in_(xetra_ids))
        elif mandal_ids is not None:
            stmt = stmt.join(Karyakar.mandals).where(Mandal.id.in_(mandal_ids))
            
        result = await self.db.execute(stmt.offset(skip).limit(limit))
        return list(set(result.scalars().all()))

    async def create(self, karyakar: Karyakar):
        self.db.add(karyakar)
        await self.db.flush()
        await self.db.refresh(karyakar)
        return karyakar
        
    async def update(self, karyakar: Karyakar):
        self.db.add(karyakar)
        await self.db.flush()
        await self.db.refresh(karyakar)
        return karyakar
'''

files['repositories/haribhakt_repo.py'] = '''from sqlalchemy import select, or_
from sqlalchemy.ext.asyncio import AsyncSession
from models.haribhakt import Haribhakt

class HaribhaktRepository:
    def __init__(self, db: AsyncSession):
        self.db = db
        
    async def get_by_id(self, id: str):
        result = await self.db.execute(select(Haribhakt).where(Haribhakt.id == id))
        return result.scalars().first()
        
    async def get_all(self, skip: int = 0, limit: int = 100):
        result = await self.db.execute(select(Haribhakt).offset(skip).limit(limit))
        return result.scalars().all()
        
    async def search(self, query: str | None = None, xetra_id: str | None = None, xetra_ids: list[str] | None = None, mandal_id: str | None = None, mandal_ids: list[str] | None = None, skip: int = 0, limit: int = 100):
        stmt = select(Haribhakt)
        
        if xetra_id:
            stmt = stmt.where(Haribhakt.xetra_id == xetra_id)
        elif xetra_ids:
            stmt = stmt.where(Haribhakt.xetra_id.in_(xetra_ids))
            
        if mandal_id:
            stmt = stmt.where(Haribhakt.mandal_id == mandal_id)
        elif mandal_ids:
            stmt = stmt.where(Haribhakt.mandal_id.in_(mandal_ids))
            
        if query:
            stmt = stmt.where(or_(Haribhakt.full_name.ilike(f"%{query}%"), Haribhakt.mobile.ilike(f"%{query}%"), Haribhakt.email.ilike(f"%{query}%")))
            
        result = await self.db.execute(stmt.offset(skip).limit(limit))
        return result.scalars().all()
        
    async def create(self, haribhakt: Haribhakt):
        self.db.add(haribhakt)
        await self.db.flush()
        await self.db.refresh(haribhakt)
        return haribhakt
        
    async def update(self, haribhakt: Haribhakt):
        self.db.add(haribhakt)
        await self.db.flush()
        await self.db.refresh(haribhakt)
        return haribhakt
'''

files['repositories/announcement_repo.py'] = '''from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from models.announcement import Announcement

class AnnouncementRepository:
    def __init__(self, db: AsyncSession):
        self.db = db
        
    async def get_all(self, skip: int = 0, limit: int = 100):
        result = await self.db.execute(select(Announcement).order_by(Announcement.created_at.desc()).offset(skip).limit(limit))
        return result.scalars().all()
        
    async def create(self, announcement: Announcement):
        self.db.add(announcement)
        await self.db.flush()
        await self.db.refresh(announcement)
        return announcement
'''

# SERVICES
files['services/xetra_service.py'] = '''from repositories.xetra_repo import XetraRepository

class XetraService:
    def __init__(self, repo: XetraRepository):
        self.repo = repo
        
    async def get_all_xetras(self):
        return await self.repo.get_all()
'''

files['services/mandal_service.py'] = '''from repositories.mandal_repo import MandalRepository

class MandalService:
    def __init__(self, repo: MandalRepository):
        self.repo = repo
        
    async def get_all_mandals(self):
        return await self.repo.get_all()
'''

files['services/karyakar_service.py'] = '''from repositories.karyakar_repo import KaryakarRepository
from models.karyakar import Karyakar
from schemas.karyakar import KaryakarCreate, KaryakarUpdate
from core.security import get_password_hash
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from models.xetra import Xetra
from models.mandal import Mandal
import uuid

class KaryakarService:
    ROLE_HIERARCHY = {
        'sant_nirdeshak': 7,
        'sanyojak': 6,
        'nirdeshak': 5,
        'sah_nirdeshak': 4,
        'nirikshak': 3,
        'mandal_sanchalak': 2,
        'sampark_karyakar': 1
    }

    def __init__(self, repo: KaryakarRepository, db: AsyncSession):
        self.repo = repo
        self.db = db

    def _get_allowed_roles(self, current_role: str) -> list[str]:
        current_rank = self.ROLE_HIERARCHY.get(current_role, 0)
        return [role for role, rank in self.ROLE_HIERARCHY.items() if rank < current_rank]

    def can_view_karyakar(self, current_user: Karyakar, target: Karyakar) -> bool:
        if current_user.role == 'sant_nirdeshak':
            return True
            
        allowed_roles = self._get_allowed_roles(current_user.role)
        if not allowed_roles or target.role not in allowed_roles:
            return False
            
        if current_user.wing and target.wing and current_user.wing != target.wing:
            return False
            
        if current_user.role in ['sanyojak', 'nirdeshak']:
            assigned_xetras = {x.id for x in current_user.xetras}
            target_xetras = {x.id for x in target.xetras}
            target_mandals = {m.xetra_id for m in target.mandals}
            return bool(assigned_xetras.intersection(target_xetras) or assigned_xetras.intersection(target_mandals))
            
        elif current_user.role in ['sah_nirdeshak', 'nirikshak', 'mandal_sanchalak']:
            assigned_mandals = {m.id for m in current_user.mandals}
            target_mandals = {m.id for m in target.mandals}
            return bool(assigned_mandals.intersection(target_mandals))
            
        return False

    async def get_karyakar(self, id: str) -> Karyakar | None:
        return await self.repo.get_by_id(id)

    async def get_all_karyakars(self, skip: int = 0, limit: int = 100, current_user: Karyakar | None = None):
        xetra_ids = None
        mandal_ids = None
        allowed_roles = None
        wing = None

        if current_user:
            if current_user.role != 'sant_nirdeshak':
                wing = current_user.wing

            allowed_roles = self._get_allowed_roles(current_user.role)
            if not allowed_roles:
                return []
                
            if current_user.role in ['sanyojak', 'nirdeshak']:
                xetra_ids = [x.id for x in current_user.xetras]
            elif current_user.role in ['sah_nirdeshak', 'nirikshak', 'mandal_sanchalak']:
                mandal_ids = [m.id for m in current_user.mandals]
            
        return await self.repo.get_all(skip=skip, limit=limit, xetra_ids=xetra_ids, mandal_ids=mandal_ids, allowed_roles=allowed_roles, wing=wing)

    async def create_karyakar(self, data: KaryakarCreate) -> Karyakar:
        k_id = str(uuid.uuid4())
        hashed_pw = get_password_hash(data.password)
        
        karyakar = Karyakar(
            id=k_id,
            karyakar_number=data.karyakar_number,
            name=data.name,
            role=data.role,
            username=data.username,
            password_hash=hashed_pw,
            phone=data.phone,
            email=data.email,
            wing=data.wing,
            gender=data.gender
        )
        
        if data.xetra_ids:
            res = await self.db.execute(select(Xetra).where(Xetra.id.in_(data.xetra_ids)))
            karyakar.xetras = res.scalars().all()
            
        if data.mandal_ids:
            res = await self.db.execute(select(Mandal).where(Mandal.id.in_(data.mandal_ids)))
            karyakar.mandals = res.scalars().all()
            
        return await self.repo.create(karyakar)

    async def update_karyakar(self, id: str, data: KaryakarUpdate) -> Karyakar | None:
        karyakar = await self.repo.get_by_id(id)
        if not karyakar:
            return None
            
        update_data = data.model_dump(exclude_unset=True)
        
        if 'password' in update_data:
            karyakar.password_hash = get_password_hash(update_data.pop('password'))
            
        xetra_ids = update_data.pop('xetra_ids', None)
        mandal_ids = update_data.pop('mandal_ids', None)
        
        for key, value in update_data.items():
            setattr(karyakar, key, value)
            
        if xetra_ids is not None:
            res = await self.db.execute(select(Xetra).where(Xetra.id.in_(xetra_ids)))
            karyakar.xetras = res.scalars().all()
            
        if mandal_ids is not None:
            res = await self.db.execute(select(Mandal).where(Mandal.id.in_(mandal_ids)))
            karyakar.mandals = res.scalars().all()
            
        return await self.repo.update(karyakar)
'''

files['services/haribhakt_service.py'] = '''from repositories.haribhakt_repo import HaribhaktRepository
from models.haribhakt import Haribhakt
from models.karyakar import Karyakar
from schemas.haribhakt import HaribhaktCreate, HaribhaktUpdate
import uuid

class HaribhaktService:
    def __init__(self, repo: HaribhaktRepository):
        self.repo = repo
        
    async def get_haribhakt(self, id: str) -> Haribhakt | None:
        return await self.repo.get_by_id(id)
        
    async def get_all_haribhakts(self, skip: int = 0, limit: int = 100) -> list[Haribhakt]:
        return await self.repo.get_all(skip=skip, limit=limit)
        
    async def search_haribhakts(self, query: str | None = None, skip: int = 0, limit: int = 100, current_user: Karyakar | None = None) -> list[Haribhakt]:
        xetra_ids = None
        mandal_ids = None
        
        if current_user and current_user.role != 'sant_nirdeshak':
            if current_user.role in ['sanyojak', 'nirdeshak']:
                xetra_ids = [x.id for x in current_user.xetras]
            elif current_user.role in ['sah_nirdeshak', 'nirikshak', 'mandal_sanchalak', 'sampark_karyakar']:
                mandal_ids = [m.id for m in current_user.mandals]
                
        return await self.repo.search(query=query, xetra_ids=xetra_ids, mandal_ids=mandal_ids, skip=skip, limit=limit)
        
    async def create_haribhakt(self, data: HaribhaktCreate) -> Haribhakt:
        h_id = str(uuid.uuid4())
        haribhakt = Haribhakt(id=h_id, **data.model_dump())
        return await self.repo.create(haribhakt)
        
    async def update_haribhakt(self, id: str, data: HaribhaktUpdate) -> Haribhakt | None:
        haribhakt = await self.repo.get_by_id(id)
        if not haribhakt:
            return None
        for key, value in data.model_dump(exclude_unset=True).items():
            setattr(haribhakt, key, value)
        return await self.repo.update(haribhakt)
'''

files['services/announcement_service.py'] = '''from repositories.announcement_repo import AnnouncementRepository
from models.announcement import Announcement
from schemas.announcement import AnnouncementCreate

class AnnouncementService:
    def __init__(self, repo: AnnouncementRepository):
        self.repo = repo
        
    async def get_all_announcements(self, skip: int = 0, limit: int = 100):
        return await self.repo.get_all(skip=skip, limit=limit)
        
    async def create_announcement(self, data: AnnouncementCreate) -> Announcement:
        announcement = Announcement(**data.model_dump())
        return await self.repo.create(announcement)
'''

for fpath, content in files.items():
    with open(fpath, 'w', encoding='utf-8') as f:
        # Prepend the required header
        header = '"""\nAuthor: BAPS Atladara Development Team\n"""\n\n'
        f.write(header + content)
print('ALL FILES GENERATED.')

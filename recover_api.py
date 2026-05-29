import os

files = {}

# api/v1/xetras.py
files['api/v1/xetras.py'] = '''from fastapi import APIRouter, Depends
from schemas.xetra import Xetra
from services.xetra_service import XetraService
from core.dependencies import get_xetra_service

router = APIRouter()

@router.get("/", response_model=list[Xetra])
async def get_all_xetras(service: XetraService = Depends(get_xetra_service)):
    return await service.get_all_xetras()
'''

# api/v1/mandals.py
files['api/v1/mandals.py'] = '''from fastapi import APIRouter, Depends
from schemas.mandal import Mandal
from services.mandal_service import MandalService
from core.dependencies import get_mandal_service

router = APIRouter()

@router.get("/", response_model=list[Mandal])
async def get_all_mandals(service: MandalService = Depends(get_mandal_service)):
    return await service.get_all_mandals()
'''

# api/v1/karyakars.py
files['api/v1/karyakars.py'] = '''from fastapi import APIRouter, Depends, HTTPException, status
from schemas.karyakar import KaryakarCreate, KaryakarUpdate, KaryakarResponse
from services.karyakar_service import KaryakarService
from core.dependencies import get_karyakar_service, get_current_user
from models.karyakar import Karyakar

router = APIRouter()

@router.get("/me", response_model=KaryakarResponse)
async def get_me(current_user: Karyakar = Depends(get_current_user)):
    return current_user

@router.get("/", response_model=list[KaryakarResponse])
async def get_all_karyakars(skip: int = 0, limit: int = 100, service: KaryakarService = Depends(get_karyakar_service), current_user: Karyakar = Depends(get_current_user)):
    return await service.get_all_karyakars(skip=skip, limit=limit, current_user=current_user)

@router.get("/{id}", response_model=KaryakarResponse)
async def get_karyakar(id: str, service: KaryakarService = Depends(get_karyakar_service), current_user: Karyakar = Depends(get_current_user)):
    karyakar = await service.get_karyakar(id)
    if not karyakar:
        raise HTTPException(status_code=404, detail="Karyakar not found")
    if not service.can_view_karyakar(current_user, karyakar):
        raise HTTPException(status_code=403, detail="Not authorized to view this Karyakar")
    return karyakar

@router.post("/", response_model=KaryakarResponse, status_code=status.HTTP_201_CREATED)
async def create_karyakar(data: KaryakarCreate, service: KaryakarService = Depends(get_karyakar_service)):
    return await service.create_karyakar(data)

@router.put("/{id}", response_model=KaryakarResponse)
async def update_karyakar(id: str, data: KaryakarUpdate, service: KaryakarService = Depends(get_karyakar_service)):
    karyakar = await service.update_karyakar(id, data)
    if not karyakar:
        raise HTTPException(status_code=404, detail="Karyakar not found")
    return karyakar
'''

# api/v1/haribhakts.py
files['api/v1/haribhakts.py'] = '''from fastapi import APIRouter, Depends, HTTPException, status
from schemas.haribhakt import HaribhaktCreate, HaribhaktUpdate, Haribhakt
from services.haribhakt_service import HaribhaktService
from core.dependencies import get_haribhakt_service, get_current_user
from models.karyakar import Karyakar

router = APIRouter()

@router.get("/", response_model=list[Haribhakt])
async def search_haribhakts(query: str | None = None, skip: int = 0, limit: int = 100, service: HaribhaktService = Depends(get_haribhakt_service), current_user: Karyakar = Depends(get_current_user)):
    return await service.search_haribhakts(query=query, skip=skip, limit=limit, current_user=current_user)

@router.get("/{id}", response_model=Haribhakt)
async def get_haribhakt(id: str, service: HaribhaktService = Depends(get_haribhakt_service)):
    haribhakt = await service.get_haribhakt(id)
    if not haribhakt:
        raise HTTPException(status_code=404, detail="Haribhakt not found")
    return haribhakt

@router.post("/", response_model=Haribhakt, status_code=status.HTTP_201_CREATED)
async def create_haribhakt(data: HaribhaktCreate, service: HaribhaktService = Depends(get_haribhakt_service)):
    return await service.create_haribhakt(data)

@router.put("/{id}", response_model=Haribhakt)
async def update_haribhakt(id: str, data: HaribhaktUpdate, service: HaribhaktService = Depends(get_haribhakt_service)):
    haribhakt = await service.update_haribhakt(id, data)
    if not haribhakt:
        raise HTTPException(status_code=404, detail="Haribhakt not found")
    return haribhakt
'''

# api/v1/announcements.py
files['api/v1/announcements.py'] = '''from fastapi import APIRouter, Depends, status
from schemas.announcement import AnnouncementCreate, Announcement
from services.announcement_service import AnnouncementService
from core.dependencies import get_announcement_service

router = APIRouter()

@router.get("/", response_model=list[Announcement])
async def get_all_announcements(skip: int = 0, limit: int = 100, service: AnnouncementService = Depends(get_announcement_service)):
    return await service.get_all_announcements(skip=skip, limit=limit)

@router.post("/", response_model=Announcement, status_code=status.HTTP_201_CREATED)
async def create_announcement(data: AnnouncementCreate, service: AnnouncementService = Depends(get_announcement_service)):
    return await service.create_announcement(data)
'''

for fpath, content in files.items():
    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content)
print('API recovered.')

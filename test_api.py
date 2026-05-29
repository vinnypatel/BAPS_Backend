import asyncio
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlalchemy import text
from services.haribhakt_service import HaribhaktService
from repositories.karyakar_repo import KaryakarRepository

async def test_api():
    engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5435/baps_parivar_db')
    AsyncSessionLocal = sessionmaker(engine, class_=AsyncSession)
    
    async with AsyncSessionLocal() as db:
        repo = KaryakarRepository(db)
        # Find a sanyukt sampark karyakar
        res = await db.execute(text("SELECT id FROM karyakars WHERE role='sampark_karyakar' AND wing='sanyukt' LIMIT 1"))
        sk_id = res.scalar()
        
        if not sk_id:
            print("No sanyukt sampark_karyakar found. Trying any...")
            res = await db.execute(text("SELECT id FROM karyakars WHERE role='sampark_karyakar' LIMIT 1"))
            sk_id = res.scalar()
            
        actor = await repo.get_by_id(sk_id)
        print(f"Testing as: {actor.name} role={actor.role} wing={actor.wing}")
        print(f"Actor mandal_ids: {actor.mandal_ids}")
        
        service = HaribhaktService(db)
        filters = {'search': None, 'mandal_id': None, 'family_id': None, 'view': None}
        
        haribhakts = await service.get_all(actor, filters)
        print(f"Service returned {len(haribhakts)} haribhakts")
        for h in haribhakts[:3]:
            print(f"  id={h.id} name={h.full_name} wing={h.wing} mandal={h.mandal_id}")

asyncio.run(test_api())

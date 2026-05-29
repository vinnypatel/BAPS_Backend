import asyncio
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

async def migrate():
    engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5435/baps_parivar_db')
    async with engine.begin() as conn:
        print("Migrating Mandals...")
        await conn.execute(text("UPDATE mandals SET wing = 'sanyukt' WHERE wing = 'sankyukt'"))
        
        print("Migrating Karyakars...")
        await conn.execute(text("UPDATE karyakars SET wing = 'sanyukt' WHERE wing = 'sankyukt'"))
        
        print("Migrating Haribhakts...")
        await conn.execute(text("UPDATE haribhakts SET wing = 'sanyukt' WHERE wing = 'sankyukt'"))
        
        print("Done!")

asyncio.run(migrate())

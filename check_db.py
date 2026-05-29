import asyncio
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

async def check():
    engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5435/baps_parivar_db')
    async with engine.connect() as conn:
        res = await conn.execute(text("SELECT COUNT(*) FROM haribhakts"))
        print("Total haribhakts:", res.scalar())

        res2 = await conn.execute(text("SELECT COUNT(*) FROM haribhakts WHERE wing = 'sanyukt'"))
        print("Sanyukt haribhakts:", res2.scalar())

        # Just print any first few records' sampark_karyakar_id
        res5 = await conn.execute(text("SELECT id, sampark_karyakar_id, mandal_id FROM haribhakts LIMIT 5"))
        print("Sample Haribhakts:", res5.fetchall())

asyncio.run(check())

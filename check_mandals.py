import asyncio
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

async def check():
    engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5435/baps_parivar_db')
    async with engine.connect() as conn:
        res = await conn.execute(text("SELECT COUNT(*) FROM mandals WHERE wing = 'sankyukt'"))
        print("Mandals with sankyukt:", res.scalar())

        res2 = await conn.execute(text("SELECT COUNT(*) FROM mandals WHERE wing = 'sanyukt'"))
        print("Mandals with sanyukt:", res2.scalar())

asyncio.run(check())

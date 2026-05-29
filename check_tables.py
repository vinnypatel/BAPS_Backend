import asyncio
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5432/baps_parivar_db')

async def check_tables():
    async with engine.begin() as conn:
        result = await conn.execute(text("SELECT table_name FROM information_schema.tables WHERE table_schema='public'"))
        tables = result.scalars().all()
        print('Tables in DB:', tables)

asyncio.run(check_tables())

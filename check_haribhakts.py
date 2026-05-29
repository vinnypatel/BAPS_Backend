import asyncio
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5432/baps_parivar_db')

async def check_columns():
    async with engine.begin() as conn:
        for table in ['haribhakts', 'announcements']:
            result = await conn.execute(text(f"SELECT column_name FROM information_schema.columns WHERE table_name='{table}'"))
            cols = result.scalars().all()
            print(f'Columns in {table}:', cols)

asyncio.run(check_columns())

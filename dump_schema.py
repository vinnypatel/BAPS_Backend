import asyncio
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5432/baps_parivar_db')

async def dump_schema():
    async with engine.begin() as conn:
        for table in ['haribhakts', 'announcements']:
            result = await conn.execute(text(f"SELECT column_name, data_type FROM information_schema.columns WHERE table_name='{table}'"))
            cols = result.fetchall()
            print(f'Table {table}:')
            for col in cols:
                print(f'  {col[0]}: {col[1]}')

asyncio.run(dump_schema())

import asyncio
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

async def debug():
    engine = create_async_engine('postgresql+asyncpg://postgres:baps123@localhost:5435/baps_parivar_db')
    async with engine.connect() as conn:
        # Check karyakar wings
        res = await conn.execute(text("SELECT id, name, role, wing FROM karyakars WHERE role='sampark_karyakar' LIMIT 5"))
        print("Sampark Karyakars:")
        for row in res.fetchall():
            print(" ", row)

        # Check haribhakt wings
        res2 = await conn.execute(text("SELECT DISTINCT wing, COUNT(*) FROM haribhakts GROUP BY wing"))
        print("\nHaribhakt wing distribution:")
        for row in res2.fetchall():
            print(" ", row)

        # Check mandal wings
        res3 = await conn.execute(text("SELECT DISTINCT wing, COUNT(*) FROM mandals GROUP BY wing"))
        print("\nMandal wing distribution:")
        for row in res3.fetchall():
            print(" ", row)

asyncio.run(debug())

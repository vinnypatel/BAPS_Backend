import asyncio
from db.session import AsyncSessionLocal
from sqlalchemy import select
from models.karyakar import Karyakar

async def check():
    async with AsyncSessionLocal() as db:
        res = await db.execute(select(Karyakar))
        rows = res.scalars().all()
        print(f"Karyakars found: {len(rows)}")
        for k in rows:
            print(f"User: {k.username}, Role: {k.role}, Mandals: {k.mandal_ids}, Xetras: {k.xetra_ids}")

if __name__ == "__main__":
    asyncio.run(check())

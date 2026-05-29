
import asyncio
from sqlalchemy import select
from db.session import AsyncSessionLocal
from models.haribhakt import Haribhakt

async def check_data():
    async with AsyncSessionLocal() as session:
        result = await session.execute(select(Haribhakt))
        hbs = result.scalars().all()
        for h in hbs:
            if h.full_name.startswith("Patel Heer"):
                print(f"ID: {h.id}, Name: {h.full_name}, Wing: {h.wing}, SK: {h.sampark_karyakar_id}")

if __name__ == "__main__":
    asyncio.run(check_data())

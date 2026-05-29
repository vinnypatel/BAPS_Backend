import asyncio
import os
import sys

# Add backend server path
sys.path.append(os.path.abspath('.'))

from db.session import AsyncSessionLocal
from sqlalchemy import select
from models.karyakar import Karyakar

async def main():
    async with AsyncSessionLocal() as db:
        res = await db.execute(select(Karyakar))
        karyakars = res.scalars().all()
        for k in karyakars:
            m_names = [m.name for m in k.mandals]
            print(f"ID: {k.id}, Name: {k.name}, Role: {k.role}, Number: {k.karyakar_number}, Mandals: {m_names}, Joined: {k.joined_at}")

if __name__ == '__main__':
    asyncio.run(main())

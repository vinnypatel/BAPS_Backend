import asyncio
from db.session import engine
from db.base import Base
from models.xetra import Xetra
from models.mandal import Mandal
from models.karyakar import Karyakar
from models.haribhakt import Haribhakt
from models.announcement import Announcement

async def init_db():
    async with engine.begin() as conn:
        print("Creating tables...")
        await conn.run_sync(Base.metadata.create_all)
        print("Tables created successfully!")

if __name__ == "__main__":
    asyncio.run(init_db())

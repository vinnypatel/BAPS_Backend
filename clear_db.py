import asyncio
from sqlalchemy import text
from db.session import engine

async def clear_db():
    async with engine.begin() as conn:
        print("Clearing all tables...")
        # Disable foreign key checks for clearing
        await conn.execute(text("DROP TABLE IF EXISTS karyakar_mandals CASCADE;"))
        await conn.execute(text("DROP TABLE IF EXISTS karyakar_xetras CASCADE;"))
        await conn.execute(text("DROP TABLE IF EXISTS haribhakts CASCADE;"))
        await conn.execute(text("DROP TABLE IF EXISTS karyakars CASCADE;"))
        await conn.execute(text("DROP TABLE IF EXISTS mandals CASCADE;"))
        await conn.execute(text("DROP TABLE IF EXISTS xetras CASCADE;"))

        await conn.execute(text("DROP TABLE IF EXISTS announcements CASCADE;"))
        await conn.execute(text("DROP TABLE IF EXISTS alembic_version CASCADE;"))
        print("Tables cleared.")

if __name__ == "__main__":
    asyncio.run(clear_db())

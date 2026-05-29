import asyncio
from sqlalchemy import text
from db.session import engine

async def run_migration():
    async with engine.begin() as conn:
        print("Running migrations...")
        new_cols = [
            ("status_reason", "VARCHAR(50)"),      # Marriage, Death, Foreign, Other
            ("status_note", "TEXT"),               # Free text reason
            ("transfer_status", "VARCHAR(20) DEFAULT 'accepted'"), # pending, accepted
            ("is_nri", "BOOLEAN DEFAULT FALSE"),
        ]
        for col, definition in new_cols:
            try:
                await conn.execute(text(f"ALTER TABLE haribhakts ADD COLUMN {col} {definition};"))
                print(f"Added {col}")
            except Exception as e:
                print(f"Skipped {col}: {e}")
    print("Migrations complete.")

if __name__ == "__main__":
    asyncio.run(run_migration())

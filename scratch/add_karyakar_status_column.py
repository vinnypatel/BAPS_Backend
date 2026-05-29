import asyncio
import os
import sys

sys.path.append(os.path.abspath('.'))

from db.session import engine
from sqlalchemy import text

async def main():
    async with engine.begin() as conn:
        # Check if status column exists in karyakars table
        result = await conn.execute(text(
            "SELECT column_name FROM information_schema.columns "
            "WHERE table_name='karyakars' AND column_name='status'"
        ))
        row = result.fetchone()
        if not row:
            print("Adding 'status' column to 'karyakars' table...")
            await conn.execute(text(
                "ALTER TABLE karyakars ADD COLUMN status VARCHAR(10) DEFAULT 'active'"
            ))
            # Also update existing rows to be 'active' just in case
            await conn.execute(text(
                "UPDATE karyakars SET status = 'active' WHERE status IS NULL"
            ))
            print("Column 'status' added successfully.")
        else:
            print("Column 'status' already exists in 'karyakars' table.")

if __name__ == '__main__':
    asyncio.run(main())

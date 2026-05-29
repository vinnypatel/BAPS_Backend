import asyncio
import os
import sys

# Add backend server path
sys.path.append(os.path.abspath('.'))

from db.session import AsyncSessionLocal
from sqlalchemy import select
from models.karyakar import Karyakar
import uuid

async def main():
    async with AsyncSessionLocal() as db:
        # Get all karyakars
        res = await db.execute(select(Karyakar))
        all_karyakars = res.scalars().all()
        
        updated_count = 0
        
        # 1. Filter out sampark karyakars
        sks = [k for k in all_karyakars if k.role == "sampark_karyakar"]
        # Sort stably by joined_at and id (creation order)
        sks = sorted(sks, key=lambda k: (k.joined_at or "", k.id))
        
        # To avoid unique constraint violation while executing inline updates,
        # we can first assign temporary dummy numbers, then set final numbers.
        for idx, sk in enumerate(sks):
            temp_num = f"temp_sk_{uuid.uuid4().hex[:10]}"
            sk.karyakar_number = temp_num
        await db.flush()
        
        # Now set final numbers
        for idx, sk in enumerate(sks):
            new_num = f"Sk-{idx + 1}"
            print(f"Assigning SK '{sk.name}' -> {new_num}")
            sk.karyakar_number = new_num
            updated_count += 1
            
        # 2. Filter out non-sampark karyakars and clean their IDs if they have Sk prefix
        non_sks = [k for k in all_karyakars if k.role != "sampark_karyakar"]
        for nk in non_sks:
            if nk.karyakar_number.startswith("Sk") or nk.karyakar_number.startswith("KN"):
                new_num = f"kk_{uuid.uuid4().hex[:8]}"
                print(f"Updating Non-SK '{nk.name}' (Role: {nk.role}): {nk.karyakar_number} -> {new_num}")
                nk.karyakar_number = new_num
                updated_count += 1
                
        if updated_count > 0:
            await db.commit()
            print(f"Migration completed successfully. Updated {updated_count} karyakars.")
        else:
            print("No karyakar numbers needed updating.")

if __name__ == '__main__':
    asyncio.run(main())

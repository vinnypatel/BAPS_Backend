import asyncio
import os
import sys

# Add backend server path
sys.path.append(os.path.abspath('.'))

from db.session import AsyncSessionLocal
from sqlalchemy import select
from models.karyakar import Karyakar
from models.mandal import Mandal
import uuid

async def main():
    async with AsyncSessionLocal() as db:
        # Get all mandals
        res_m = await db.execute(select(Mandal))
        mandals = res_m.scalars().all()
        
        # Group mandal IDs by clean name
        mandals_by_clean_name = {}
        for mandal in mandals:
            clean_name = (mandal.name or "Unknown").replace(" ", "")
            if clean_name not in mandals_by_clean_name:
                mandals_by_clean_name[clean_name] = []
            mandals_by_clean_name[clean_name].append(mandal.id)
            
        updated_count = 0
        
        # Process each unique clean mandal name group
        for clean_name, mandal_ids in mandals_by_clean_name.items():
            # Get all sampark karyakars for these mandals
            res_k = await db.execute(
                select(Karyakar)
                .join(Karyakar.mandals)
                .where(Mandal.id.in_(mandal_ids), Karyakar.role == "sampark_karyakar")
            )
            sks = res_k.scalars().all()
            
            # Since join can return duplicates, make sure we have unique Karyakar objects
            unique_sks = {}
            for sk in sks:
                unique_sks[sk.id] = sk
                
            sks_list = list(unique_sks.values())
            
            # Sort stably by joined_at and id (creation order)
            sks_list = sorted(sks_list, key=lambda k: (k.joined_at or "", k.id))
            
            for idx, sk in enumerate(sks_list):
                new_num = f"Sk_{clean_name}_{idx + 1}"
                if sk.karyakar_number != new_num:
                    print(f"Updating SK '{sk.name}' in group '{clean_name}': {sk.karyakar_number} -> {new_num}")
                    sk.karyakar_number = new_num
                    updated_count += 1
                    
        # Get all non-sampark karyakars
        res_nk = await db.execute(
            select(Karyakar).where(Karyakar.role != "sampark_karyakar")
        )
        non_sks = res_nk.scalars().all()
        for nk in non_sks:
            if nk.karyakar_number.startswith("Sk_") or nk.karyakar_number.startswith("KN_"):
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

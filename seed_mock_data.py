import asyncio
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlalchemy import select
from models.karyakar import Karyakar
from models.haribhakt import Haribhakt
from models.xetra import Xetra
from models.mandal import Mandal
from core.security import hash_password

import random

# Use the same connection string as defined in core/config.py
DATABASE_URL = "postgresql+asyncpg://postgres:baps123@localhost:5432/baps_parivar_db"
engine = create_async_engine(DATABASE_URL)
AsyncSessionLocal = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

async def seed_data():
    async with AsyncSessionLocal() as session:
        # Check if Xetras exist
        result = await session.execute(select(Xetra))
        xetras = result.scalars().all()
        if not xetras:
            print("No xetras found. Please ensure basic seed data is run first.")
            return
            
        xetra_ids = [x.id for x in xetras]
        
        result = await session.execute(select(Mandal))
        mandals = result.scalars().all()
        mandal_ids = [m.id for m in mandals]
        
        wings = ["yuvak", "yuvati", "mahila", "sankyukt", "bal", "balika"]

        print("Seeding mock Karyakars...")
        roles = [
            ("sanyojak", "Sanyojak", "k_sanyojak_mock"),
            ("nirdeshak", "Nirdeshak", "k_nirdeshak_mock"),
            ("sah_nirdeshak", "Sah Nirdeshak", "k_sah_mock"),
            ("nirikshak", "Nirikshak", "k_nirikshak_mock"),
            ("mandal_sanchalak", "Mandal Sanchalak", "k_sanchalak_mock"),
            ("sampark_karyakar", "Sampark Karyakar", "k_sampark_mock1"),
            ("sampark_karyakar", "Sampark Karyakar 2", "k_sampark_mock2"),
        ]

        karyakars_to_add = []
        for i, (role, name, username) in enumerate(roles):
            # Check if exists
            res = await session.execute(select(Karyakar).where(Karyakar.username == username))
            if res.scalars().first():
                continue
                
            k = Karyakar(
                id=f"mock_k_{i}",
                karyakar_number=f"KN-MOCK-{i:03d}",
                name=name + f" {i}",
                role=role,
                username=username,
                password_hash=hash_password("baps123"),
                phone=f"+91 90000 000{i:02d}",
                wing=random.choice(wings),
                gender="Male" if "yuvak" in name.lower() or "bal" in name.lower() else "Female"
            )
            karyakars_to_add.append(k)

        if karyakars_to_add:
            session.add_all(karyakars_to_add)
            await session.commit()
            print(f"Added {len(karyakars_to_add)} mock Karyakars.")
            
        # Get sampark karyakars to assign
        res = await session.execute(select(Karyakar).where(Karyakar.role == 'sampark_karyakar'))
        sampark_karyakars = res.scalars().all()
        sampark_ids = [k.id for k in sampark_karyakars]

        print("Seeding mock Haribhakts...")
        # Create different subtypes and family relationships
        haribhakts_to_add = []
        
        # Helper to generate IDs
        def gen_id(prefix, idx): return f"mock_{prefix}_{idx}"

        mock_data_params = [
            # Standard single member
            {"idx": 1, "name": "Ramesh Patel", "kanthi": "Yes", "pooja": True, "ravi": True, "para": True, "vach": "niyamit", "swami": True, "mandir": "Yes", "arati": "Yes"},
            # Member missing criteria (G grade)
            {"idx": 2, "name": "Suresh Shah", "kanthi": "Yes", "pooja": False, "ravi": True, "para": False, "vach": "kabhi_kabhi", "swami": False, "mandir": "No", "arati": "No"},
            # Inactive member
            {"idx": 3, "name": "Mahesh Kumar", "kanthi": "No", "pooja": False, "ravi": False, "para": False, "vach": "kabhi_kabhi", "swami": False, "mandir": "No", "arati": "No", "status": "inactive"},
        ]

        for p in mock_data_params:
            idx = p["idx"]
            res = await session.execute(select(Haribhakt).where(Haribhakt.person_id == f"PID-MOCK-{idx}"))
            if res.scalars().first():
                continue
                
            m_id = random.choice(mandal_ids)
            # Find the xetra for this mandal
            x_id = next(m.xetra_id for m in mandals if m.id == m_id)
            s_id = random.choice(sampark_ids) if sampark_ids else None
            
            h = Haribhakt(
                id=gen_id("hb", idx),
                member_id=f"M-MOCK-{idx}",
                person_id=f"PID-MOCK-{idx}",
                form_id=f"FORM-MOCK-{idx}",
                family_id=f"FAM-MOCK-{idx}",
                full_name=p["name"],
                mobile=f"98765432{idx:02d}",
                mandal_id=m_id,
                xetra_id=x_id,
                sampark_karyakar_id=s_id,
                kanthi=p["kanthi"],
                daily_pooja=p["pooja"],
                ravisabha=p["ravi"],
                parasabha=p["para"],
                daily_vachnamrut=p["vach"],
                daily_swami_vato=p["swami"],
                ghar_mandir=p["mandir"],
                arati_thai=p["arati"],
                status=p.get("status", "active"),
                is_family_head=True
            )
            haribhakts_to_add.append(h)
            
        # Add a family with S1 grade (one member meets all, others don't)
        res = await session.execute(select(Haribhakt).where(Haribhakt.family_id == "FAM-MOCK-FAMILY1"))
        if not res.scalars().first():
            m_id = random.choice(mandal_ids)
            x_id = next(m.xetra_id for m in mandals if m.id == m_id)
            s_id = random.choice(sampark_ids) if sampark_ids else None
            
            # Head (meets all)
            h_head = Haribhakt(
                id=gen_id("hb_fam", 1), member_id="M-MOCK-F1-1", person_id="PID-MOCK-F1-1",
                family_id="FAM-MOCK-FAMILY1", full_name="Dinesh Patel (Head)", mandal_id=m_id, xetra_id=x_id, sampark_karyakar_id=s_id,
                kanthi="Yes", daily_pooja=True, ravisabha=True, parasabha=True, daily_vachnamrut="niyamit", daily_swami_vato=True,
                ghar_mandir="S", arati_thai="Yes", status="active", is_family_head=True
            )
            # Wife (doesn't meet all)
            h_wife = Haribhakt(
                id=gen_id("hb_fam", 2), member_id="M-MOCK-F1-2", person_id="PID-MOCK-F1-2",
                family_id="FAM-MOCK-FAMILY1", full_name="Geeta Patel (Wife)", mandal_id=m_id, xetra_id=x_id, sampark_karyakar_id=s_id,
                kanthi="Yes", daily_pooja=True, ravisabha=False, parasabha=False, daily_vachnamrut="niyamit", daily_swami_vato=True,
                ghar_mandir="S", arati_thai="Yes", status="active", is_family_head=False, relation="Wife"
            )
            haribhakts_to_add.extend([h_head, h_wife])

        if haribhakts_to_add:
            session.add_all(haribhakts_to_add)
            await session.commit()
            print(f"Added {len(haribhakts_to_add)} mock Haribhakts.")
        else:
            print("Mock Haribhakts already exist.")
            
        print("Mock data generation complete!")

asyncio.run(seed_data())

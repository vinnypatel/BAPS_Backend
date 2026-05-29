import asyncio
from sqlalchemy.ext.asyncio import AsyncSession
from db.session import AsyncSessionLocal
from models.xetra import Xetra
from models.mandal import Mandal
from models.karyakar import Karyakar
from core.security import hash_password
import uuid

from sqlalchemy import select

# Import mandal data from the main seed script
from seed_massive_data import MANDAL_DATA

XETRAS = [
    {"id": "x1", "name": "Vadodara 1"},
    {"id": "x2", "name": "Vadodara 2"},
    {"id": "x3", "name": "Vadodara 3"},
]

WINGS = ["yuvak", "yuvati", "mahila", "sanyukt", "bal", "balika", "sadbhavi"]


async def seed():
    print("Seed process started...")
    try:
        async with AsyncSessionLocal() as db:
            print("Database session opened successfully.")

            # 1. Seed Xetras
            print("Seeding Xetras...")
            xetra_objects = {}
            for x_data in XETRAS:
                result = await db.execute(select(Xetra).filter_by(id=x_data['id']))
                existing = result.scalar_one_or_none()
                if not existing:
                    xetra = Xetra(**x_data)
                    db.add(xetra)
                    xetra_objects[x_data['id']] = xetra
                else:
                    xetra_objects[x_data['id']] = existing

            await db.flush()

            # 2. Seed Mandals (wing-specific)
            print("Seeding Mandals (wing-specific)...")
            m_counter = 0
            for wing, xetra_map in MANDAL_DATA.items():
                for x_id, m_names in xetra_map.items():
                    for m_name in m_names:
                        m_counter += 1
                        mid = f"m_{m_counter:04d}"
                        res = await db.execute(select(Mandal).filter_by(id=mid))
                        if not res.scalar_one_or_none():
                            db.add(Mandal(id=mid, name=m_name, xetra_id=x_id, wing=wing))

            await db.flush()
            print(f"  Seeded {m_counter} mandals.")

            # 3. Seed Sant Nirdeshak
            print("Seeding Sant Nirdeshak...")
            res = await db.execute(select(Karyakar).filter_by(username="santnirdeshak"))
            if not res.scalar_one_or_none():
                sant = Karyakar(
                    id=str(uuid.uuid4()),
                    karyakar_number="SN001",
                    name="Sant Nirdeshak",
                    role="sant_nirdeshak",
                    username="santnirdeshak",
                    password_hash=hash_password("baps123"),
                    phone="1234567890",
                    email="sant@baps.org",
                    joined_at="2026-01-01"
                )
                for x in xetra_objects.values():
                    sant.xetras.append(x)
                db.add(sant)

            # 3.5 Seed Admin
            print("Seeding Admin...")
            res = await db.execute(select(Karyakar).filter_by(username="admin"))
            if not res.scalar_one_or_none():
                admin = Karyakar(
                    id=str(uuid.uuid4()),
                    karyakar_number="AD001",
                    name="System Admin",
                    role="admin",
                    username="admin",
                    password_hash=hash_password("admin"),
                    phone="0000000000",
                    email="admin@baps.org",
                    joined_at="2026-01-01"
                )
                for x in xetra_objects.values():
                    admin.xetras.append(x)
                db.add(admin)

            # 4. Seed Demo Karyakars and Haribhakts
            print("Seeding Demo Karyakars...")
            from models.haribhakt import Haribhakt

            res = await db.execute(select(Mandal))
            all_mandals = res.scalars().all()

            # First sanyukt V1 mandal
            first_mandal = next((m for m in all_mandals if m.wing == "sanyukt" and m.xetra_id == "x1"), all_mandals[0] if all_mandals else None)

            frontend_demos = [
                ("sanyojak1", "sanyojak", "Bhargav Bhai Shah"),
                ("nirdeshak1", "nirdeshak", "Nirdeshak V1"),
                ("nirdeshak2", "nirdeshak", "Nirdeshak V2"),
                ("nirdeshak3", "nirdeshak", "Nirdeshak V3"),
                ("sah_nirdeshak1", "sah_nirdeshak", "Sah-Nirdeshak V1"),
                ("nirikshak1", "nirikshak", "Nirikshak V1"),
                ("ms_m1_0", "mandal_sanchalak", "Mandal Sanchalak"),
                ("sk_m1_0", "sampark_karyakar", "Sampark Karyakar 1"),
            ]

            for username, role, name in frontend_demos:
                res = await db.execute(select(Karyakar).filter_by(username=username))
                if not res.scalar_one_or_none():
                    k = Karyakar(
                        id=str(uuid.uuid4()),
                        karyakar_number=f"DEMO_{username}",
                        name=name,
                        role=role,
                        username=username,
                        password_hash=hash_password("baps123"),
                        phone="0000000000",
                        email=f"{username}@baps.org",
                        joined_at="2026-01-01",
                        wing="sanyukt",
                    )
                    if first_mandal:
                        k.mandals.append(first_mandal)
                    if xetra_objects:
                        k.xetras.append(list(xetra_objects.values())[0])
                    db.add(k)

            await db.commit()
            print("Seeding complete!")
    except Exception as e:
        print(f"Error during seeding: {str(e)}")
        import traceback
        traceback.print_exc()
        raise e


if __name__ == "__main__":
    asyncio.run(seed())

import asyncio
import random
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlalchemy import select, text, delete
from core.security import hash_password
from db.base import Base
from models.karyakar import Karyakar, karyakar_xetras, karyakar_mandals
from models.haribhakt import Haribhakt
from models.xetra import Xetra
from models.mandal import Mandal

DATABASE_URL = "postgresql+asyncpg://postgres:baps123@localhost:5435/baps_parivar_db"

# =============================================================================
# MANDAL DATA — Wing-specific mandals per Xetra
# =============================================================================

MANDAL_DATA = {
    # ── MAHILA WING ──────────────────────────────────────────────────────────
    "mahila": {
        "x1": [
            "P.Sw.Nagar - 1", "P.Sw.Nagar - 2", "Niramay - 1", "Niramay - 2",
            "Kalali - 1", "Kalali - 2", "Vishwamitri Township",
            "Racecourse - 1", "Racecourse - 2", "Racecourse - 3",
            "Racecourse - 4", "Racecourse - 5", "Samta", "Harani",
            "Atladara - 1", "Atladara - 2", "Atladara - 3",
            "Ramlaxman - 1", "Ramlaxman - 2", "Vadsar",
            "AvadhUpavan", "Vrajdham", "Vrundavan", "Krishna Darshan",
        ],
        "x2": [
            "Indrapuri - 1", "Indrapuri - 2", "Indrapuri - 3", "Indrapuri - 4",
            "Kapurai", "Sayajipura", "Maneja",
            "Manjalpur - 1", "Manjalpur - 2", "Manjalpur - 3",
            "Manjalpur - 4", "Manjalpur - 5",
            "GIDC - 1", "GIDC - 2", "GIDC - 3", "GIDC - 4",
            "Wadi - 1", "Wadi - 2",
            "Shiyabaug - 1", "Shiyabaug - 2", "Shiyabaug - 3",
            "Shiyabaug - 4", "Shiyabaug - 5",
            "Danteshwar - 1", "Danteshwar - 2",
            "Tarsali - 1", "Tarsali - 2",
            "Makarpura - 1", "Makarpura - 2", "Makarpura - 3", "Makarpura - 4",
            "Gayatrinagar",
        ],
        "x3": [
            "Sevasi - 1", "Sevasi - 2",
            "Gotri - 1", "Gotri - 2", "Gotri - 3", "Gotri - 4", "Gotri - 5",
            "Chhani Jakatnaka - 1", "Chhani Jakatnaka - 2", "Chhani Jakatnaka - 3",
            "Chhanigam - 1", "Chhanigam - 2",
            "Karelibaug - 1", "Karelibaug - 2",
            "Sama", "Vemali", "Motnath", "Lileriya", "Sardarnagar",
            "Gorwa - 1", "Gorwa - 2", "Gorwa - 3", "Gorwa - 4",
            "Bajwa", "Karachiya", "Lakshmipura",
        ],
    },

    # ── SANYUKT WING ─────────────────────────────────────────────────────────
    "sanyukt": {
        "x1": [
            "Akota", "Atladra", "Kalali", "Narayanwadi", "Niramay",
            "P.Sw.Nagar", "Racecourse - 1", "Racecourse - 2",
            "Samta", "Shyamvilla", "Vadsar",
        ],
        "x2": [
            "Danteshwar", "Gayatrinagar", "Indrapuri - 1", "Indrapuri - 2",
            "Makarpura", "Maneja", "Manjalpur - 1", "Manjalpur - 2",
            "Shiyabaug", "Tarsali", "Wadi",
        ],
        "x3": [
            "Bajwa", "Chhani Jakatnaka - 1", "Chhani Jakatnaka - 2",
            "Chhanigam", "Gorwa", "Gotri", "Karelibaug - 1", "Karelibaug - 2",
            "Panchvati", "Sama", "Sardarnagar", "Sevasi",
        ],
    },

    # ── YUVAK WING ───────────────────────────────────────────────────────────
    "yuvak": {
        "x1": ["Racecourse", "Samta", "Niramay", "Narayanwadi", "Atladara", "P.Sw.Nagar", "Vadsar"],
        "x2": ["Manjalpur", "Indrapuri", "Danteshwar", "Makarpura", "Tarsali", "Maneja", "Shiyabaug", "Wadi"],
        "x3": ["Gorwa", "Gotri", "Karelibaug", "Sama", "Chhanigam", "Sardarnagar", "Chhani Jakatnaka"],
    },

    # ── YUVATI WING ──────────────────────────────────────────────────────────
    "yuvati": {
        "x1": ["Atladara", "Kalali - PR", "Niramay", "P.Sw.Nagar", "Racecourse", "Samta", "Shyamvilla", "Vadsar"],
        "x2": [
            "Gayatrinagar", "Indrapuri - 1", "Indrapuri - 3",
            "Makarpura - 1", "Makarpura - 2", "Maneja",
            "Manjalpur - 1", "Manjalpur - 2", "Manjalpur - 3",
            "Shiyabaug", "Tarsali", "Wadi - 1", "Danteshwar",
        ],
        "x3": ["Karelibaug", "Sama", "Sardarnagar", "Chhani Jakatnaka", "Chhanigam", "Gorwa", "Gotri - 1", "Gotri - 2"],
    },

    # ── BAL WING ─────────────────────────────────────────────────────────────
    # V1 = VD-7 (Niramay/Atladra/PSN/Akota area) + VD-4 (Kalali/Atladra/AvadhUpavan area)
    # V2 = Xetra 01 (Indrapuri) + Xetra 2 (Danteshwar/Tarsali/Makarpura) + Xetra 10 (Shiyabaug/Wadi) + V8 (Manjalpur)
    # V3 = Xetra 9 (Sama/Karelibaug/Chhani)
    "bal": {
        "x1": [
            # VD-7 — Niramay Sanyukt
            "Labh Bal", "Labh Shishu", "Nilkanth Bal", "Nilkanth Shishu",
            "Sun Pharma Bal", "Akshar Green Shishu",
            # VD-7 — Atladara Sanyukt
            "Atladara Bal", "Atladara Shishu",
            # VD-7 — PSN Sanyukt
            "Pramukh Swami Nagar Bal", "Hiranagar Bal", "Hiranagar Shishu",
            # VD-7 — Akota Sanyukt
            "Vidyut Nagar Bal",
            # VD-4 — Kalali Sanyukt
            "Kalali Bal",
            # VD-4 — Atladara Sanyukt
            "Atladara Gam Bal", "Atladara Gam 2 Bal",
            "Gunatitdham Bal", "Gunatitdham Shishu", "Sairang Bal",
            # VD-4 — Shyamvilla Sanyukt
            "Avadh Upavan Bal", "Avadh Upavan Shishu",
            "Akshar Paradise Bal", "Indravilla Bal", "Anant Swagatam Bal",
            "Param Krisht Bal", "Arya Empire Bal", "Green Yard Bal", "Kishan Glory Bal",
            # VD-4 — Narayanwadi Sanyukt
            "Pramukh Swami Villa Bal", "Yoginagar Bal",
            "Vrundavan Shishu", "Pramukh Swami Tirth Bal",
        ],
        "x2": [
            # Xetra 01 — Indrapuri-1
            "Indrapuri Bal", "Nathiba Nagar Bal", "Vaikunth Bal",
            # Xetra 01 — Indrapuri-2
            "Kamlanagar Bal", "Seva Kunj Bal", "Pancham Villa Bal",
            "Sugam Park Bal", "Shri Hari Township Bal", "Ambika Darshan 2 Bal",
            "Harikrishna Township Bal", "Parimal 3 Bal", "Sayajinagar Bal",
            "Kishanwadi Bal", "Satadhar Bal", "Bhailalbhai Park Bal",
            "Indrapuri Shishu",
            # Xetra 2 — Danteshwar
            "Danteshwar Bal", "Anupam Nagar Bal",
            # Xetra 2 — Tarsali
            "Zillion Bal", "Tarsali Bal", "Vallabh Duplex Bal", "Gold City Bal",
            # Xetra 2 — Makarpura
            "Tuljanagar Bal", "Makarpura Bal", "Akruti Duplex Bal",
            # Xetra 2 — Maneja
            "Maneja Bal",
            # Xetra 2 — Gayatrinagar
            "Gayatrinagar Bal",
            # Xetra 2 — Shishu
            "Danteshwar Shishu", "Sharadnagar Shishu", "Gayatrinagar Shishu",
            # Xetra 10 — Shiyabaug
            "Shiyabaug Bal", "Nyaymandir Bal",
            # Xetra 10 — Wadi
            "Wadi Bal",
            # Xetra 10 — Indrapuri-1
            "Akshar Tenament Bal", "Vaishnav Park Bal", "Yogi Raday Bal",
            "Shivam Bal", "Soles Bal", "Darshanam Green Bal",
            "Jalaram Nagar Bal", "D Mart Bal", "Dhanlaxmi Tenament Bal",
            # V8 — Manjalpur
            "Manjalpur Bal", "Surabhipark Bal", "Pujan Bal",
            "Vaibhav Vatika Bal", "Kedardham Bal", "Kamleshwar Nagar Bal",
            "Gayatri Krupa Bal", "Parthbhumi Bal", "Vadsar Bal",
        ],
        "x3": [
            # Xetra 9 — Sama
            "Sama Bal", "Vemali Bal", "Vemali Gam Sanskar Kendra",
            # Xetra 9 — Karelibaug-1
            "Karelibaug Bal", "Pramukh Preet Bal",
            # Xetra 9 — Karelibaug-2
            "Airport Bal", "Khodiyar Nagar Bal", "Vrundavan Bal",
            # Xetra 9 — Sama Gam
            "Siddharth Bungalow Sanskar Kendra",
            # Xetra 9 — Karelibaug-2 / Motnath
            "Motnath Residency Sanskar Kendra",
            # Xetra 9 — Chhani Jakatnaka-1
            "Chhani Jakatnaka Bal", "Nakshatra Bal",
            # Xetra 9 — Chhani Jakatnaka-2
            "Satyanarayan Bal",
            # Xetra 9 — Sardarnagar
            "Sardarnagar Bal",
            # Xetra 9 — Chhanigam
            "Chhanigam Bal", "Marutinandan Sanskar Kendra",
            # Xetra 9 — Shishu
            "Karelibaug Shishu", "Sama Shishu", "Chhani Jakatnaka Shishu",
        ],
    },

    # ── BALIKA WING ──────────────────────────────────────────────────────────
    # Xetra mapped from Sanyukt parent mandals: Racecourse/Samta→V1, Gotri/Sevasi→V3
    "balika": {
        "x1": [
            # Racecourse-1 Sanyukt area
            "Pushpam",
            # Racecourse-2 Sanyukt area
            "Harinagar", "Harinagar Shishu", "Chandranagar",
            # Samta Sanyukt area
            "Jay Ambe", "Shreeji", "Vaikunth", "Samta Balika",
        ],
        "x2": [],  # No Balika mandals provided for V2
        "x3": [
            # Gotri Sanyukt area
            "Gokulnagar", "Jaladarshan", "Gotri Balika",
            "Yagnapurush", "Life Arena",
            # Sevasi Sanyukt area
            "Khanpur",
        ],
    },

    # ── SADBHAVI WING ────────────────────────────────────────────────────────
    # Same mandal and xetra structure as Sanyukt wing
    "sadbhavi": {
        "x1": [
            "Akota", "Atladra", "Kalali", "Narayanwadi", "Niramay",
            "P.Sw.Nagar", "Racecourse - 1", "Racecourse - 2",
            "Samta", "Shyamvilla", "Vadsar",
        ],
        "x2": [
            "Danteshwar", "Gayatrinagar", "Indrapuri - 1", "Indrapuri - 2",
            "Makarpura", "Maneja", "Manjalpur - 1", "Manjalpur - 2",
            "Shiyabaug", "Tarsali", "Wadi",
        ],
        "x3": [
            "Bajwa", "Chhani Jakatnaka - 1", "Chhani Jakatnaka - 2",
            "Chhanigam", "Gorwa", "Gotri", "Karelibaug - 1", "Karelibaug - 2",
            "Panchvati", "Sama", "Sardarnagar", "Sevasi",
        ],
    },
}

WINGS = ["yuvak", "yuvati", "mahila", "sanyukt", "bal", "balika", "sadbhavi"]


def sanitize_id(name):
    return name.lower().replace(" ", "_").replace(".", "").replace("-", "").replace("(", "").replace(")", "")


async def seed_data():
    engine = create_async_engine(DATABASE_URL)
    AsyncSessionLocal = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

    async with engine.begin() as conn:
        print("Dropping all tables and recreating schema...")
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)

    async with AsyncSessionLocal() as session:

        # =====================================================================
        # 1. XETRAS
        # =====================================================================
        print("Adding Xetras...")
        x1 = Xetra(id="x1", name="Vadodara 1")
        x2 = Xetra(id="x2", name="Vadodara 2")
        x3 = Xetra(id="x3", name="Vadodara 3")
        session.add_all([x1, x2, x3])
        await session.commit()

        # =====================================================================
        # 2. MANDALS — Wing-specific per Xetra
        # =====================================================================
        print("Adding Mandals (wing-specific)...")
        mandals_to_add = []
        m_counter = 0

        for wing, xetra_map in MANDAL_DATA.items():
            for x_id, m_names in xetra_map.items():
                for m_name in m_names:
                    m_counter += 1
                    m = Mandal(
                        id=f"m_{m_counter:04d}",
                        xetra_id=x_id,
                        name=m_name,
                        wing=wing,
                    )
                    mandals_to_add.append(m)

        session.add_all(mandals_to_add)
        await session.commit()
        print(f"  Added {len(mandals_to_add)} mandals across {len(MANDAL_DATA)} wings.")

        # Reload all mandals
        result = await session.execute(select(Mandal))
        all_mandals = result.scalars().all()

        # Helper: get mandals by xetra and/or wing
        def get_mandals(xetra_id=None, wing=None):
            return [
                m for m in all_mandals
                if (xetra_id is None or m.xetra_id == xetra_id)
                and (wing is None or m.wing == wing)
            ]

        # =====================================================================
        # 3. DEMO KARYAKARS
        # =====================================================================
        print("Adding Demo Karyakars...")
        default_pwd = hash_password("baps123")
        karyakars_to_add = []
        karyakar_mandal_inserts = []
        karyakar_xetra_inserts = []

        # First sanyukt V1 mandal for mandal-level demo accounts
        sanyukt_v1 = get_mandals("x1", "sanyukt")
        first_mandal_id = sanyukt_v1[0].id if sanyukt_v1 else "m_0001"

        demo_configs = [
            {
                "id": "demo_santnirdeshak", "username": "santnirdeshak",
                "name": "Pujya Sant Nirdeshak", "role": "sant_nirdeshak",
                "x_ids": ["x1", "x2", "x3"], "m_scope": "all", "wing": None,
            },
            {
                "id": "demo_sanyojak1", "username": "sanyojak1",
                "name": "Bhargav Bhai Shah", "role": "sanyojak",
                "x_ids": ["x1", "x2", "x3"], "m_scope": "all", "wing": None,
            },
            {
                "id": "demo_nirdeshak1", "username": "nirdeshak1",
                "name": "Nirdeshak V1", "role": "nirdeshak",
                "x_ids": ["x1"], "m_scope": "x1", "wing": "sanyukt",
            },
            {
                "id": "demo_nirdeshak2", "username": "nirdeshak2",
                "name": "Nirdeshak V2", "role": "nirdeshak",
                "x_ids": ["x2"], "m_scope": "x2", "wing": "sanyukt",
            },
            {
                "id": "demo_nirdeshak3", "username": "nirdeshak3",
                "name": "Nirdeshak V3", "role": "nirdeshak",
                "x_ids": ["x3"], "m_scope": "x3", "wing": "sanyukt",
            },
            {
                "id": "demo_sah_nirdeshak1", "username": "sah_nirdeshak1",
                "name": "Sah-Nirdeshak V1", "role": "sah_nirdeshak",
                "x_ids": ["x1"], "m_scope": "first_3_sanyukt_v1", "wing": "sanyukt",
            },
            {
                "id": "demo_nirikshak1", "username": "nirikshak1",
                "name": "Nirikshak V1", "role": "nirikshak",
                "x_ids": ["x1"], "m_scope": [first_mandal_id], "wing": "sanyukt",
            },
            {
                "id": "demo_ms_m1_0", "username": "ms_m1_0",
                "name": "Mandal Sanchalak", "role": "mandal_sanchalak",
                "x_ids": ["x1"], "m_scope": [first_mandal_id], "wing": "sanyukt",
            },
            {
                "id": "demo_sk_m1_0", "username": "sk_m1_0",
                "name": "Sampark Karyakar 1", "role": "sampark_karyakar",
                "x_ids": ["x1"], "m_scope": [first_mandal_id], "wing": "sanyukt",
            },
        ]

        for d in demo_configs:
            k = Karyakar(
                id=d["id"],
                karyakar_number=f"DEMO-{d['username'].upper()}",
                name=d["name"],
                role=d["role"],
                username=d["username"],
                password_hash=default_pwd,
                phone="+91 99999 99999",
                email=f"{d['username']}@demo.com",
                joined_at="2020-01-01",
                wing=d.get("wing"),
            )
            karyakars_to_add.append(k)

            for x_id in d["x_ids"]:
                karyakar_xetra_inserts.append({"karyakar_id": d["id"], "xetra_id": x_id})

            scope = d["m_scope"]
            if scope == "all":
                for m in all_mandals:
                    karyakar_mandal_inserts.append({"karyakar_id": d["id"], "mandal_id": m.id})
            elif scope in ("x1", "x2", "x3"):
                for m in get_mandals(xetra_id=scope):
                    karyakar_mandal_inserts.append({"karyakar_id": d["id"], "mandal_id": m.id})
            elif scope == "first_3_sanyukt_v1":
                for m in sanyukt_v1[:3]:
                    karyakar_mandal_inserts.append({"karyakar_id": d["id"], "mandal_id": m.id})
            elif isinstance(scope, list):
                for m_id in scope:
                    karyakar_mandal_inserts.append({"karyakar_id": d["id"], "mandal_id": m_id})

        # =====================================================================
        # 4. HIERARCHY KARYAKARS (per wing per xetra)
        # =====================================================================
        print("Adding hierarchy karyakars...")
        k_count = 0
        sampark_map = {}  # (mandal_id) -> karyakar_id

        HIERARCHY_WINGS = ["sanyukt", "yuvak", "yuvati", "mahila", "bal", "balika"]

        for wing in HIERARCHY_WINGS:
            for x_id in ["x1", "x2", "x3"]:
                wing_mandals = get_mandals(x_id, wing)
                if not wing_mandals:
                    continue

                # One Nirikshak per xetra/wing (covers all mandals in that scope)
                k_count += 1
                nk_id = f"k_{k_count}"
                karyakars_to_add.append(Karyakar(
                    id=nk_id,
                    karyakar_number=f"KN-{k_count:05d}",
                    name=f"Nirikshak {x_id.upper()} {wing.title()}",
                    role="nirikshak",
                    username=f"user{k_count}",
                    password_hash=default_pwd,
                    phone=f"+91 90000 {k_count % 100000:05d}",
                    email=f"user{k_count}@baps.org",
                    joined_at="2020-01-01",
                    wing=wing,
                ))
                karyakar_xetra_inserts.append({"karyakar_id": nk_id, "xetra_id": x_id})
                for wm in wing_mandals:
                    karyakar_mandal_inserts.append({"karyakar_id": nk_id, "mandal_id": wm.id})

                # One Mandal Sanchalak + Sampark Karyakar per mandal
                for wm in wing_mandals:
                    # Mandal Sanchalak
                    k_count += 1
                    ms_id = f"k_{k_count}"
                    karyakars_to_add.append(Karyakar(
                        id=ms_id,
                        karyakar_number=f"KN-{k_count:05d}",
                        name=f"MS {wm.name} ({wing.title()})",
                        role="mandal_sanchalak",
                        username=f"user{k_count}",
                        password_hash=default_pwd,
                        phone=f"+91 90000 {k_count % 100000:05d}",
                        email=f"user{k_count}@baps.org",
                        joined_at="2020-01-01",
                        wing=wing,
                    ))
                    karyakar_mandal_inserts.append({"karyakar_id": ms_id, "mandal_id": wm.id})
                    karyakar_xetra_inserts.append({"karyakar_id": ms_id, "xetra_id": x_id})

                    # Sampark Karyakar
                    k_count += 1
                    sk_id = f"k_{k_count}"
                    karyakars_to_add.append(Karyakar(
                        id=sk_id,
                        karyakar_number=f"Sk-{k_count}",
                        name=f"SK {wm.name} ({wing.title()})",
                        role="sampark_karyakar",
                        username=f"user{k_count}",
                        password_hash=default_pwd,
                        phone=f"+91 90000 {k_count % 100000:05d}",
                        email=f"user{k_count}@baps.org",
                        joined_at="2020-01-01",
                        wing=wing,
                    ))
                    karyakar_mandal_inserts.append({"karyakar_id": sk_id, "mandal_id": wm.id})
                    karyakar_xetra_inserts.append({"karyakar_id": sk_id, "xetra_id": x_id})
                    sampark_map[wm.id] = sk_id

        session.add_all(karyakars_to_add)
        await session.commit()

        if karyakar_mandal_inserts:
            await session.execute(
                text("INSERT INTO karyakar_mandals (karyakar_id, mandal_id) VALUES (:karyakar_id, :mandal_id)"),
                karyakar_mandal_inserts,
            )
        if karyakar_xetra_inserts:
            await session.execute(
                text("INSERT INTO karyakar_xetras (karyakar_id, xetra_id) VALUES (:karyakar_id, :xetra_id)"),
                karyakar_xetra_inserts,
            )
        await session.commit()
        print(f"  Added {len(karyakars_to_add)} karyakars.")

        # =====================================================================
        # 5. HARIBHAKTS — mock data for testing
        # =====================================================================
        print("Adding Haribhakts...")
        haribhakts_to_add = []
        h_count = 0

        FIRST_NAMES = [
            "Ramesh", "Suresh", "Mahesh", "Rajesh", "Dinesh", "Bhavesh",
            "Jayesh", "Nilesh", "Hitesh", "Paresh", "Mukesh", "Alpesh",
            "Kiran", "Meena", "Sunita", "Hetal", "Nisha", "Priya",
            "Kavita", "Rekha", "Sonal", "Jyoti", "Asha", "Mina",
        ]
        SURNAMES = ["Patel", "Shah", "Mehta", "Desai", "Joshi", "Dave", "Trivedi", "Bhatt", "Pandya", "Amin"]

        for wing in HIERARCHY_WINGS:
            for x_id in ["x1", "x2", "x3"]:
                wing_mandals = get_mandals(x_id, wing)
                for wm in wing_mandals:
                    h_count += 1
                    fname = FIRST_NAMES[h_count % len(FIRST_NAMES)]
                    sname = SURNAMES[h_count % len(SURNAMES)]
                    h = Haribhakt(
                        id=f"hb_{h_count}",
                        member_id=f"M-{h_count:05d}",
                        person_id=f"PID-{h_count:05d}",
                        form_id=f"FORM-{h_count:05d}",
                        full_name=f"{fname}",
                        father_name="Father",
                        surname=sname,
                        mobile=f"98765{h_count % 100000:05d}",
                        whatsapp=f"98765{h_count % 100000:05d}",
                        email=f"hb{h_count}@baps.org",
                        area=wm.name,
                        city="Vadodara",
                        pin_code="390001",
                        dob="1990-01-01",
                        wing=wing,
                        mandal_id=wm.id,
                        xetra_id=x_id,
                        sampark_karyakar_id=sampark_map.get(wm.id),
                        kanthi="Yes",
                        daily_pooja=True,
                        ravisabha=True,
                        parasabha=True,
                        daily_vachnamrut="niyamit",
                        daily_swami_vato=True,
                        ghar_mandir="S",
                        arati="Yes",
                        status="active",
                        s_grade="A",
                        satsang_grade="S1",
                    )
                    haribhakts_to_add.append(h)

        session.add_all(haribhakts_to_add)
        await session.commit()
        print(f"  Added {len(haribhakts_to_add)} haribhakts.")

        # ── Summary ──
        print("\n" + "=" * 60)
        print("SEED COMPLETE — Summary")
        print("=" * 60)
        for wing in HIERARCHY_WINGS:
            for x_id in ["x1", "x2", "x3"]:
                count = len(get_mandals(x_id, wing))
                if count > 0:
                    x_name = {"x1": "V1", "x2": "V2", "x3": "V3"}[x_id]
                    print(f"  {wing.title():10s} | {x_name}: {count} mandals")
        print(f"\n  Total Mandals:    {len(all_mandals)}")
        print(f"  Total Karyakars:  {len(karyakars_to_add)}")
        print(f"  Total Haribhakts: {len(haribhakts_to_add)}")
        print("=" * 60)


if __name__ == "__main__":
    asyncio.run(seed_data())

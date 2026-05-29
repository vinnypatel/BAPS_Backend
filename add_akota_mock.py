import asyncio
from sqlalchemy.ext.asyncio import AsyncSession
from db.session import AsyncSessionLocal
from models.mandal import Mandal
from models.haribhakt import Haribhakt
from models.karyakar import Karyakar
from sqlalchemy import select
import uuid
import random

async def add_akota_mocks():
    async with AsyncSessionLocal() as db:
        res = await db.execute(select(Mandal).filter_by(name="Akota", wing="sanyukt"))
        akota_mandal = res.scalar_one_or_none()
        
        if not akota_mandal:
            print("Akota mandal not found!")
            return
            
        print(f"Found Akota Mandal ID: {akota_mandal.id}")
        xetra_id = akota_mandal.xetra_id
        
        # We will create 10 families
        haribhakts_to_add = []
        family_counter = 1
        
        for i in range(1, 11):
            family_id = f"FAM_AKOTA_{i}_{uuid.uuid4().hex[:8]}"
            
            # Head of family
            head = Haribhakt(
                id=f"hb_akota_{uuid.uuid4().hex[:8]}",
                member_id=f"MEM_{family_id}_1",
                person_id=f"PID_AKOTA_{i}_1_{uuid.uuid4().hex[:4]}",
                form_id=f"FORM_AKOTA_{i}_1_{uuid.uuid4().hex[:4]}",
                family_id=family_id,
                full_name=f"MockHead {i}",
                father_name="MockFather",
                surname="Patel",
                mobile=f"99999000{i:02d}",
                whatsapp=f"99999000{i:02d}",
                email=f"mockhead{i}@example.com",
                area="Akota",
                city="Vadodara",
                pin_code="390001",
                dob="1990-01-01",
                wing="sanyukt",
                mandal_id=akota_mandal.id,
                xetra_id=xetra_id,
                relation=None, # Head of family
                gender="Male",
                kanthi="Yes",
                daily_pooja=True,
                ravisabha=True,
                parasabha=True,
                daily_vachnamrut="niyamit",
                daily_swami_vato=True,
                ghar_mandir="S",
                arati="Yes",
                s_grade="A",
                satsang_grade="S1",
                status="active"
            )
            haribhakts_to_add.append(head)
            
            # 3-4 families get 1 family member
            if i <= 4:
                member1 = Haribhakt(
                    id=f"hb_akota_{uuid.uuid4().hex[:8]}",
                    member_id=f"MEM_{family_id}_2",
                    person_id=f"PID_AKOTA_{i}_2_{uuid.uuid4().hex[:4]}",
                    form_id=f"FORM_AKOTA_{i}_2_{uuid.uuid4().hex[:4]}",
                    family_id=family_id,
                    full_name=f"MockWife {i}",
                    father_name="MockFather",
                    surname="Patel",
                    mobile=f"99999001{i:02d}",
                    whatsapp=f"99999001{i:02d}",
                    email=f"mockwife{i}@example.com",
                    area="Akota",
                    city="Vadodara",
                    pin_code="390001",
                    dob="1990-01-01",
                    wing="mahila",
                    mandal_id=akota_mandal.id,
                    xetra_id=xetra_id,
                    relation="Wife",
                    gender="Female",
                    kanthi="Yes",
                    daily_pooja=True,
                    ravisabha=True,
                    parasabha=True,
                    daily_vachnamrut="niyamit",
                    daily_swami_vato=True,
                    ghar_mandir="S",
                    arati="Yes",
                    s_grade="A",
                    satsang_grade="S1",
                    status="active"
                )
                haribhakts_to_add.append(member1)
                
            # 1-2 families get an NRI family member
            if i in [5, 6]:
                nri_member = Haribhakt(
                    id=f"hb_akota_{uuid.uuid4().hex[:8]}",
                    member_id=f"MEM_{family_id}_3",
                    person_id=f"PID_AKOTA_{i}_3_{uuid.uuid4().hex[:4]}",
                    form_id=f"FORM_AKOTA_{i}_3_{uuid.uuid4().hex[:4]}",
                    family_id=family_id,
                    full_name=f"MockSon {i}",
                    father_name="MockFather",
                    surname="Patel",
                    mobile=f"99999002{i:02d}",
                    whatsapp=f"99999002{i:02d}",
                    email=f"mockson{i}@example.com",
                    area="Akota",
                    city="Vadodara",
                    pin_code="390001",
                    dob="1990-01-01",
                    wing="yuvak",
                    mandal_id=akota_mandal.id,
                    xetra_id=xetra_id,
                    relation="Son",
                    gender="Male",
                    is_nri=True,
                    kanthi="Yes",
                    daily_pooja=False,
                    ravisabha=False,
                    parasabha=False,
                    daily_vachnamrut="no",
                    daily_swami_vato=False,
                    ghar_mandir="S",
                    arati="No",
                    s_grade="A",
                    satsang_grade="S1",
                    status="active"
                )
                haribhakts_to_add.append(nri_member)
                
        db.add_all(haribhakts_to_add)
        await db.commit()
        print(f"Successfully added {len(haribhakts_to_add)} mock Haribhakts to Akota Mandal.")

if __name__ == "__main__":
    asyncio.run(add_akota_mocks())

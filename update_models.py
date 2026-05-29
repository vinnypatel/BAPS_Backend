import os

haribhakt_model = '''from sqlalchemy import Column, String, Boolean, Text, DateTime, func
from sqlalchemy.orm import Mapped, mapped_column
from db.base import Base

class Haribhakt(Base):
    __tablename__ = "haribhakts"
    
    id: Mapped[str] = mapped_column(String(50), primary_key=True, index=True)
    family_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    member_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    person_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    form_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    full_name: Mapped[str | None] = mapped_column(String(150), nullable=True)
    father_name: Mapped[str | None] = mapped_column(String(150), nullable=True)
    surname: Mapped[str | None] = mapped_column(String(150), nullable=True)
    gender: Mapped[str | None] = mapped_column(String(20), nullable=True)
    dob: Mapped[str | None] = mapped_column(String(50), nullable=True)
    blood_group: Mapped[str | None] = mapped_column(String(20), nullable=True)
    avatar: Mapped[str | None] = mapped_column(String(255), nullable=True)
    mobile: Mapped[str | None] = mapped_column(String(20), nullable=True)
    whatsapp: Mapped[str | None] = mapped_column(String(20), nullable=True)
    email: Mapped[str | None] = mapped_column(String(150), nullable=True)
    ghar_number: Mapped[str | None] = mapped_column(String(50), nullable=True)
    society_name: Mapped[str | None] = mapped_column(String(150), nullable=True)
    area: Mapped[str | None] = mapped_column(String(150), nullable=True)
    landmark: Mapped[str | None] = mapped_column(String(150), nullable=True)
    city: Mapped[str | None] = mapped_column(String(100), nullable=True)
    taluka: Mapped[str | None] = mapped_column(String(100), nullable=True)
    pin_code: Mapped[str | None] = mapped_column(String(20), nullable=True)
    state: Mapped[str | None] = mapped_column(String(100), nullable=True)
    country: Mapped[str | None] = mapped_column(String(100), nullable=True)
    occupation: Mapped[str | None] = mapped_column(String(100), nullable=True)
    education: Mapped[str | None] = mapped_column(String(100), nullable=True)
    talent: Mapped[str | None] = mapped_column(String(255), nullable=True)
    resident: Mapped[str | None] = mapped_column(String(100), nullable=True)
    foreign_address: Mapped[str | None] = mapped_column(Text, nullable=True)
    dharmada_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    dharmada_status: Mapped[str | None] = mapped_column(String(50), nullable=True)
    xetra_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    mandal_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    sampark_karyakar_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    kanthi: Mapped[str | None] = mapped_column(String(20), nullable=True)
    daily_pooja: Mapped[bool | None] = mapped_column(Boolean, default=False)
    daily_arati: Mapped[bool | None] = mapped_column(Boolean, default=False)
    daily_tilak: Mapped[bool | None] = mapped_column(Boolean, default=False)
    ravisabha: Mapped[bool | None] = mapped_column(Boolean, default=False)
    parasabha: Mapped[bool | None] = mapped_column(Boolean, default=False)
    ghar_sabha: Mapped[bool | None] = mapped_column(Boolean, default=False)
    daily_vachnamrut: Mapped[str | None] = mapped_column(String(50), nullable=True)
    daily_swami_vato: Mapped[bool | None] = mapped_column(Boolean, default=False)
    ghar_mandir: Mapped[str | None] = mapped_column(String(50), nullable=True)
    arati_thai: Mapped[str | None] = mapped_column(String(50), nullable=True)
    swaminarayan_prakash: Mapped[bool | None] = mapped_column(Boolean, default=False)
    premvati: Mapped[bool | None] = mapped_column(Boolean, default=False)
    bal_prakash: Mapped[bool | None] = mapped_column(Boolean, default=False)
    bliss: Mapped[bool | None] = mapped_column(Boolean, default=False)
    s_grade: Mapped[str | None] = mapped_column(String(20), nullable=True)
    satsang_grade: Mapped[str | None] = mapped_column(String(20), nullable=True)
    status: Mapped[str | None] = mapped_column(String(50), nullable=True)
    relation: Mapped[str | None] = mapped_column(String(50), nullable=True)
    special_note: Mapped[str | None] = mapped_column(Text, nullable=True)
    last_updated_by: Mapped[str | None] = mapped_column(String(50), nullable=True)
    last_updated_at = mapped_column(DateTime, nullable=True)
    created_at = mapped_column(DateTime, default=func.now())
'''

announcement_model = '''from sqlalchemy import Column, String, Text, DateTime, func
from sqlalchemy.orm import Mapped, mapped_column
from db.base import Base

class Announcement(Base):
    __tablename__ = "announcements"
    
    id: Mapped[str] = mapped_column(String(50), primary_key=True, index=True)
    title: Mapped[str] = mapped_column(String(200), nullable=False)
    content: Mapped[str] = mapped_column(Text, nullable=False)
    created_at = mapped_column(DateTime, default=func.now())
'''

with open('models/haribhakt.py', 'w', encoding='utf-8') as f:
    f.write('"""\\nAuthor: BAPS Atladara Development Team\\n"""\\n\\n' + haribhakt_model)

with open('models/announcement.py', 'w', encoding='utf-8') as f:
    f.write('"""\\nAuthor: BAPS Atladara Development Team\\n"""\\n\\n' + announcement_model)

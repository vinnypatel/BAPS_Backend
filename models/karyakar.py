"""
Author: BAPS Atladara Development Team
"""

from datetime import datetime
from sqlalchemy import Column, String, Table, ForeignKey, TEXT, Boolean, Integer, DateTime
from sqlalchemy.orm import Mapped, mapped_column, relationship
from db.base import Base
from models.xetra import Xetra
from models.mandal import Mandal

karyakar_xetras = Table(
    'karyakar_xetras',
    Base.metadata,
    Column('karyakar_id', String(50), ForeignKey('karyakars.id', ondelete='CASCADE'), primary_key=True),
    Column('xetra_id', String(10), ForeignKey('xetras.id', ondelete='CASCADE'), primary_key=True)
)

karyakar_mandals = Table(
    'karyakar_mandals',
    Base.metadata,
    Column('karyakar_id', String(50), ForeignKey('karyakars.id', ondelete='CASCADE'), primary_key=True),
    Column('mandal_id', String(20), ForeignKey('mandals.id', ondelete='CASCADE'), primary_key=True)
)

class Karyakar(Base):
    __tablename__ = "karyakars"
    
    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    karyakar_number: Mapped[str] = mapped_column(String(20), unique=True, nullable=False)
    name: Mapped[str] = mapped_column(String(150), nullable=False)
    role: Mapped[str] = mapped_column(String(30), nullable=False)
    username: Mapped[str] = mapped_column(String(100), unique=True, nullable=False)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    mfa_enabled: Mapped[bool] = mapped_column(
    Boolean,
    nullable=False,
    default=False,
    server_default="false"
)
    mfa_secret: Mapped[str | None] = mapped_column(
    String(255),
    nullable=True
    )
    
    failed_login_attempts: Mapped[int] = mapped_column(Integer, nullable=False, default=0, server_default="0")
    temporary_login_block_until: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    locked_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    lock_reason: Mapped[str | None] = mapped_column(String(255), nullable=True)
    last_failed_login_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    avatar: Mapped[str | None] = mapped_column(TEXT, nullable=True)
    phone: Mapped[str] = mapped_column(String(20), nullable=False)
    email: Mapped[str] = mapped_column(String(150), nullable=False)
    parent_karyakar_id: Mapped[str | None] = mapped_column(String(50), ForeignKey('karyakars.id'), nullable=True)
    birthday: Mapped[str | None] = mapped_column(String(20), nullable=True)
    joined_at: Mapped[str] = mapped_column(String(20), nullable=False)
    wing: Mapped[str | None] = mapped_column(String(20), nullable=True)
    status: Mapped[str] = mapped_column(String(10), nullable=False, default="active", server_default="active")
    
    xetras = relationship('Xetra', secondary=karyakar_xetras, lazy='selectin')
    mandals = relationship('Mandal', secondary=karyakar_mandals, lazy='selectin')

    @property
    def mandal_ids(self) -> list[str]:
        return [m.id for m in self.mandals]

    @property
    def xetra(self) -> str | None:
        if self.xetras:
            return self.xetras[0].name
        return None

    @property
    def xetra_ids(self) -> list[str]:
        return [x.id for x in self.xetras]


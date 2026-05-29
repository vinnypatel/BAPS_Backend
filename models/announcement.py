from sqlalchemy import Column, String, Text, TIMESTAMP, func
from sqlalchemy.orm import Mapped, mapped_column
from db.base import Base

class Announcement(Base):
    __tablename__ = "announcements"
    
    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    title: Mapped[str] = mapped_column(String(200), nullable=False)
    content: Mapped[str] = mapped_column(Text, nullable=False)
    created_at = mapped_column(TIMESTAMP, server_default=func.now())
    
    # Targeting fields
    target_karyakar_id: Mapped[str | None] = mapped_column(String(50), nullable=True)
    target_mandal_id: Mapped[str | None] = mapped_column(String(20), nullable=True)
    target_wing: Mapped[str | None] = mapped_column(String(20), nullable=True)
    target_roles: Mapped[str | None] = mapped_column(String(100), nullable=True)

"""
Author: BAPS Atladara Development Team
"""

from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from db.base import Base

class Mandal(Base):
    __tablename__ = "mandals"
    
    id: Mapped[str] = mapped_column(String(20), primary_key=True)
    xetra_id: Mapped[str] = mapped_column(String(10), ForeignKey("xetras.id"))
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    wing: Mapped[str] = mapped_column(String(20), nullable=False)

    
    def __repr__(self) -> str:
        return f"<Mandal(id='{self.id}', name='{self.name}')>"

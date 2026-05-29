"""
Author: BAPS Atladara Development Team
"""

from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import Mapped, mapped_column
from db.base import Base

class Xetra(Base):
    __tablename__ = "xetras"
    
    id: Mapped[str] = mapped_column(String(10), primary_key=True)
    name: Mapped[str] = mapped_column(String(50), nullable=False)
    
    def __repr__(self) -> str:
        return f"<Xetra(id='{self.id}', name='{self.name}')>"

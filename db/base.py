"""
Author: BAPS Development Team
Year: 2026
Description: SQLAlchemy ORM base configuration

This module defines the DeclarativeBase that all ORM models inherit from.
It imports all models to ensure Alembic can detect them for migrations.

This layer knows nothing about the business domain - it's purely for ORM setup.
"""

from sqlalchemy.orm import DeclarativeBase


class Base(DeclarativeBase):
    """
    Base class for all SQLAlchemy ORM models.
    
    All model classes should inherit from this Base class. This allows
    SQLAlchemy to track all models and enables Alembic to detect them
    for automatic migration generation.
    
    Example:
        from db.base import Base
        from sqlalchemy import Column, Integer, String
        
        class User(Base):
            __tablename__ = "users"
            id = Column(Integer, primary_key=True)
            email = Column(String, unique=True)
    """
    pass


# Import all models here so Alembic detects them
# This ensures migrations include all model changes
# Removed due to circular imports.
# Import these in alembic/env.py instead.

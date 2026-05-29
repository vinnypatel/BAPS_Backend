"""
Core module for BAPS Backend Server

This module contains the core configuration and utilities shared across
the entire application, including:
- Configuration management
- Security utilities
- Dependency injection
- Custom exceptions
"""

from .config import settings, Settings

__all__ = ["settings", "Settings"]

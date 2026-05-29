"""
Alembic environment script.

This script is run whenever the alembic migration tool is invoked.
It's responsible for:
- Configuring the database connection
- Setting up logging
- Discovering models for automatic migration generation
- Running migrations in offline or online mode
"""

from logging.config import fileConfig
from sqlalchemy import engine_from_config, pool
from alembic import context

# Import SQLAlchemy models and configuration
from db.base import Base
from core.config import settings
from models.xetra import Xetra
from models.mandal import Mandal
from models.karyakar import Karyakar, karyakar_xetras, karyakar_mandals
from models.haribhakt import Haribhakt
from models.announcement import Announcement



# This is the Alembic Config object, which provides access to the values within the .ini file
config = context.config


# Interpret the config file for Python logging.
# This line sets up loggers basically as described in the config file.
# (in this case, the config_file_name defaults to 'alembic.ini')
if config.config_file_name is not None:
    fileConfig(config.config_file_name)


# Add your model's MetaData object for 'autogenerate' support
# from myapp import mymodel
# target_metadata = mymodel.Base.metadata
target_metadata = Base.metadata


def run_migrations_offline() -> None:
    """
    Run migrations in 'offline' mode.

    This configures the context with just a URL
    and not an Engine, though an Engine is acceptable
    here as well.  By skipping the Engine creation
    we don't even need a DBAPI to be available.

    Calls to context.execute() here emit the given string to the
    script output.
    """
    url = settings.postgres.sync_url
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online() -> None:
    """
    Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.
    """
    configuration = config.get_section(config.config_ini_section)
    configuration["sqlalchemy.url"] = settings.postgres.sync_url
    
    connectable = engine_from_config(
        configuration,
        prefix="sqlalchemy.",
        poolclass=pool.StaticPool,
    )

    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()

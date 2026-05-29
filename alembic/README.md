Run migrations from `baps_backend_server`:

1. `alembic init alembic` (if not initialized yet)
2. Configure `sqlalchemy.url` in `alembic.ini`
3. `alembic revision --autogenerate -m "initial schema"`
4. `alembic upgrade head`

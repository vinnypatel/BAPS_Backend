# BAPS Backend Server - Setup & Migration Guide

## Project Structure Overview

```
baps_backend_server/
├── alembic/                    # Database migrations
│   ├── versions/               # Migration files
│   │   └── 001_create_users_table.py
│   ├── env.py                  # Alembic environment configuration
│   ├── script.py.mako          # Migration template
│   └── __init__.py
├── alembic.ini                 # Alembic main configuration
├── api/v1/
│   ├── auth.py                 # Authentication routes
│   ├── users.py                # User management routes
│   └── __init__.py
├── core/
│   ├── config.py               # Configuration management
│   ├── security.py             # Password hashing & JWT tokens
│   ├── dependencies.py         # FastAPI dependency injection
│   └── __init__.py
├── db/
│   ├── base.py                 # SQLAlchemy Base class
│   ├── session.py              # AsyncEngine & AsyncSessionLocal
│   └── __init__.py
├── models/
│   ├── users.py                # User ORM model
│   └── __init__.py
├── repositories/
│   ├── user_repo.py            # Database query layer
│   └── __init__.py
├── schemas/
│   ├── users.py                # User request/response validation
│   ├── token.py                # Authentication request/response
│   └── __init__.py
├── services/
│   ├── auth_service.py         # Authentication business logic
│   ├── user_service.py         # User management business logic
│   └── __init__.py
├── middleware/
│   └── Logging.py              # Request/response logging
├── main.py                     # FastAPI application entry point
├── requirement.txt             # Python dependencies
└── .env                        # Environment variables
```

## Prerequisites

1. Python 3.9+ installed
2. PostgreSQL 12+ running
3. Virtual environment activated (`.venv`)
4. All dependencies installed: `pip install -r requirement.txt`

## Environment Setup

### 1. Configure Database Connection

Edit `.env` file with your PostgreSQL credentials:

```bash
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DATABASE=baps_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_password
POSTGRES_POOL_SIZE=20
POSTGRES_MAX_OVERFLOW=10
POSTGRES_ECHO=false
```

### 2. Create Database

```bash
# Connect to PostgreSQL
psql -U postgres -h localhost

# Create database
CREATE DATABASE baps_db;

# Connect to new database
\c baps_db
```

## Database Migrations

### Run Migrations

```bash
# Navigate to backend server directory
cd baps_backend_server

# Run migrations to create tables
alembic upgrade head

# Check migration status
alembic current
```

### View Migration History

```bash
# Show all applied migrations
alembic history --verbose

# Show pending migrations
alembic current
```

### Create New Migrations

When you modify SQLAlchemy models:

```bash
# Auto-generate migration (detects model changes)
alembic revision --autogenerate -m "Description of changes"

# Review the generated migration file in alembic/versions/

# Apply the migration
alembic upgrade head
```

### Rollback Migrations

```bash
# Downgrade to previous migration
alembic downgrade -1

# Downgrade to specific migration
alembic downgrade 001_create_users_table

# Downgrade to initial state (before any migrations)
alembic downgrade base
```

## Running the Application

### Start the Server

```bash
# Navigate to backend server directory
cd baps_backend_server

# Run the server (development mode)
python main.py

# Or use uvicorn directly
uvicorn main:app --reload --host 127.0.0.1 --port 9000
```

### Access the API

- **API Documentation**: http://127.0.0.1:9000/api/docs (Swagger UI)
- **Alternative Docs**: http://127.0.0.1:9000/api/redoc (ReDoc)
- **OpenAPI Schema**: http://127.0.0.1:9000/api/openapi.json
- **Health Check**: http://127.0.0.1:9000/health

## API Endpoints

### Authentication Routes (`/api/v1/auth`)

| Method | Endpoint | Purpose | Body |
|--------|----------|---------|------|
| POST | `/auth/login` | Login user | `{username, password}` |
| POST | `/auth/refresh` | Refresh access token | `{refresh_token}` |
| POST | `/auth/logout` | Logout user | None (Bearer token required) |

### User Routes (`/api/v1/users`)

| Method | Endpoint | Purpose | Body | Auth |
|--------|----------|---------|------|------|
| POST | `/users` | Create new user (signup) | `{username, email, phone, password}` | No |
| GET | `/users/{user_id}` | Get user by ID | None | No |
| GET | `/users/me` | Get current user profile | None | Yes |
| PATCH | `/users/{user_id}` | Update user info | `{username?, email?, phone?}` | Yes |
| DELETE | `/users/{user_id}` | Delete user account | None | Yes |

### Health Check

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/health` | Check API status |

## Usage Examples

### 1. Sign Up (Create User)

```bash
curl -X POST http://127.0.0.1:9000/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "email": "john@example.com",
    "phone": "+1234567890",
    "password": "SecurePass123!"
  }'

# Response (201 Created):
{
  "id": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "phone": "+1234567890",
  "reset_password": false,
  "created_at": "2026-04-02T10:30:00"
}
```

### 2. Login

```bash
curl -X POST http://127.0.0.1:9000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "password": "SecurePass123!"
  }'

# Response:
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

### 3. Get Current User Profile

```bash
curl -X GET http://127.0.0.1:9000/api/v1/users/me \
  -H "Authorization: Bearer <access_token>"

# Response:
{
  "id": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "phone": "+1234567890",
  "reset_password": false,
  "created_at": "2026-04-02T10:30:00"
}
```

### 4. Refresh Access Token

```bash
curl -X POST http://127.0.0.1:9000/api/v1/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{
    "refresh_token": "<refresh_token>"
  }'

# Response:
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

### 5. Update User

```bash
curl -X PATCH http://127.0.0.1:9000/api/v1/users/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <access_token>" \
  -d '{
    "email": "newemail@example.com",
    "phone": "+0987654321"
  }'

# Response:
{
  "id": 1,
  "username": "john_doe",
  "email": "newemail@example.com",
  "phone": "+0987654321",
  "reset_password": false,
  "created_at": "2026-04-02T10:30:00"
}
```

### 6. Logout

```bash
curl -X POST http://127.0.0.1:9000/api/v1/auth/logout \
  -H "Authorization: Bearer <access_token>"

# Response:
{
  "message": "Logged out successfully"
}
```

## Architecture Layers

### 1. **API Routes** (api/v1/*.py)
   - FastAPI route handlers
   - Request/response validation using Pydantic schemas
   - Route includes in main.py

### 2. **Services** (services/*.py)
   - Business logic layer
   - Implements application rules
   - Calls repositories for data access

### 3. **Repositories** (repositories/*.py)
   - Database query layer
   - Only place that writes SQL (via SQLAlchemy)
   - Called by services, never by routes directly

### 4. **Models** (models/*.py)
   - SQLAlchemy ORM models
   - Map to database tables

### 5. **Schemas** (schemas/*.py)
   - Pydantic models for request/response validation
   - Completely separate from SQLAlchemy models
   - Used for API validation and serialization

### 6. **Core** (core/*.py)
   - Configuration management (config.py)
   - Security utilities (security.py)
   - FastAPI dependencies (dependencies.py)

### 7. **Database** (db/*.py)
   - SQLAlchemy engine and session configuration
   - Base model class

## Database Schema

### Users Table

```sql
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    reset_password BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(email)
);

CREATE INDEX ix_users_id ON users(id);
CREATE INDEX ix_users_username ON users(username);
CREATE INDEX ix_users_email ON users(email);
```

## Security Features

- **Password Hashing**: bcrypt with automatic salting
- **JWT Tokens**: HS256 algorithm
- **Access Token**: 30 minutes expiration (configurable)
- **Refresh Token**: 7 days expiration (configurable)
- **Bearer Token Authentication**: Standard HTTP Bearer scheme
- **CORS**: Configured in main.py

## Configuration Management

All configuration is centralized in `core/config.py`:

```python
from core.config import settings

# Access database configuration
settings.postgres.url  # PostgreSQL async URL
settings.postgres.host
settings.postgres.port
settings.postgres.database

# Access security settings
settings.security.secret_key
settings.security.algorithm
settings.security.access_token_expire_minutes

# Access application settings
settings.app.app_name
settings.app.environment  # development, staging, production
settings.app.debug
```

## Troubleshooting

### Migration Fails

```bash
# Check current migration status
alembic current

# View all applied migrations
alembic history

# Try to downgrade and upgrade again
alembic downgrade base
alembic upgrade head
```

### Database Connection Error

```bash
# Verify PostgreSQL is running
psql -U postgres -h localhost -c "SELECT version();"

# Check environment variables
cat .env | grep POSTGRES

# Verify database exists
psql -U postgres -h localhost -l
```

### JWT Token Errors

- **"Token has expired"**: Use refresh token or login again
- **"Invalid token"**: Check token format (should be `Bearer <token>`)
- **"Invalid token type"**: Ensure you're using correct token type (access vs refresh)

### Port Already in Use

```bash
# Change port in main.py or use command line
uvicorn main:app --port 9001
```

## Next Steps

1. ✅ Create Alembic migration system
2. ✅ Run migrations (`alembic upgrade head`)
3. ✅ Integrate routers into main.py
4. ✅ Start the server (`python main.py`)
5. Test API endpoints using Swagger UI or curl
6. Implement additional features (email verification, password reset, etc.)
7. Add more models and migrations as needed
8. Deploy to production

## Development Tips

- **Auto-reload**: Use `--reload` flag with uvicorn for development
- **Database Debugging**: Set `POSTGRES_ECHO=true` in .env to log SQL queries
- **API Documentation**: Swagger UI is great for testing endpoints
- **Code Structure**: Keep models, services, and routes separate
- **Error Handling**: Services raise HTTPException for proper error responses

## Support & Documentation

- **FastAPI**: https://fastapi.tiangolo.com/
- **SQLAlchemy**: https://docs.sqlalchemy.org/
- **Alembic**: https://alembic.sqlalchemy.org/
- **Pydantic**: https://docs.pydantic.dev/
- **JWT**: https://jwt.io/

---

**Last Updated**: April 2, 2026  
**Version**: 1.0.0  
**Status**: Ready for Development

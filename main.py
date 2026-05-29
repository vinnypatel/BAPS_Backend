"""
Author: BAPS Development Team
Year: 2026
Description: Main entry point for BAPS FastAPI Backend Server
Features:
- FastAPI application initialization
- Lifespan management (startup/shutdown events)
- Logging middleware integration
- Request/response tracking
- Configuration management via core.config settings
"""

from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
import uvicorn

from core.config import settings
from middleware.Logging import LoggingMiddleware, RequestTimingMiddleware, get_logger

# Get logger instance
logger = get_logger()


# ============================================================================
# LIFESPAN CONTEXT MANAGER
# ============================================================================
@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator:
    """
    Lifespan context manager for application startup and shutdown events
    
    Usage:
    - startup code runs before the application starts accepting requests
    - shutdown code runs when the application is shutting down
    
    Args:
        app: FastAPI application instance
    
    Yields:
        Control to the running application
    """
    
    # ========== STARTUP ==========
    logger.info("=" * 80)
    logger.info("BAPS BACKEND SERVER - STARTUP")
    logger.info("=" * 80)
    
    try:
        # Initialize application components
        logger.info(f"Server Host: {settings.app.app_name}")
        logger.info(f"Server Version: {settings.app.app_version}")
        logger.info(f"Environment: {settings.app.environment}")
        logger.info(f"Debug Mode: {settings.app.debug}")
        logger.info(f"Log Level: {settings.app.log_level}")
        
        # Database configuration info
        logger.info(f"Database: {settings.postgres.user}@{settings.postgres.host}:{settings.postgres.port}/{settings.postgres.database}")
        logger.info(f"Redis: {settings.redis.host}:{settings.redis.port}")
        logger.info(f"RabbitMQ: {settings.rabbitmq.host}:{settings.rabbitmq.port}")
        logger.info(f"SMTP: {settings.smtp.host}:{settings.smtp.port}")
        
        # Initialize database connections (if needed)
        logger.info("Initializing database connections...")
        # await init_db()  # Uncomment when database is ready
        
        # Initialize cache (if needed)
        logger.info("Initializing cache layer...")
        # await init_cache()  # Uncomment when cache is ready
        
        # Initialize API services
        logger.info("Initializing API services...")
        # await init_services()  # Uncomment when services are ready
        
        logger.info("All components initialized successfully")
        logger.info("BAPS Backend Server is ready to accept requests")
        logger.info("=" * 80)
        
    except Exception as e:
        logger.error(f"Error during startup: {str(e)}", exc_info=True)
        raise
    
    # Application runs here
    yield
    
    # ========== SHUTDOWN ==========
    logger.info("=" * 80)
    logger.info("BAPS BACKEND SERVER - SHUTDOWN")
    logger.info("=" * 80)
    
    try:
        # Cleanup operations
        logger.info("Cleaning up resources...")
        
        # Close database connections (if needed)
        # await close_db()  # Uncomment when database is ready
        
        # Clear cache (if needed)
        # await clear_cache()  # Uncomment when cache is ready
        
        # Shutdown services
        # await shutdown_services()  # Uncomment when services are ready
        
        logger.info("All resources cleaned up successfully")
        logger.info("BAPS Backend Server shutdown complete")
        logger.info("=" * 80)
        
    except Exception as e:
        logger.error(f"Error during shutdown: {str(e)}", exc_info=True)
        raise


# ============================================================================
# FASTAPI APPLICATION INITIALIZATION
# ============================================================================
app = FastAPI(
    title=settings.app.app_name,
    description=settings.app.app_description,
    version=settings.app.app_version,
    docs_url="/api/docs" if settings.app.docs_enabled else None,
    redoc_url="/api/redoc" if settings.app.docs_enabled else None,
    openapi_url="/api/openapi.json" if settings.app.docs_enabled else None,
    lifespan=lifespan,
    debug=settings.app.debug
)


origins = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
]


# ============================================================================
# MIDDLEWARE CONFIGURATION
# ============================================================================

from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request, exc):
    logger.error(f"Validation error for {request.method} {request.url}: {exc.errors()}")
    return JSONResponse(
        status_code=422,
        content={"detail": exc.errors()},
    )

@app.exception_handler(Exception)
async def global_exception_handler(request, exc):
    logger.error(f"GLOBAL ERROR for {request.method} {request.url}: {str(exc)}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={"detail": "Internal Server Error", "message": str(exc) if settings.app.debug else None},
    )

# Add request timing middleware (must be added before logging middleware)
app.add_middleware(RequestTimingMiddleware)
app.add_middleware(LoggingMiddleware)


# Add CORS middleware LAST
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# Mount static files for uploads
import os
uploads_dir = os.path.join(os.getcwd(), "uploads")
if not os.path.exists(uploads_dir):
    os.makedirs(uploads_dir)
app.mount("/uploads", StaticFiles(directory=uploads_dir), name="uploads")


# ============================================================================
# ROOT ENDPOINT
# ============================================================================

@app.get("/", tags=["General"])
async def root():
    """Root endpoint providing basic API information"""
    return {
        "message": f"Welcome to {settings.app.app_name} API",
        "version": settings.app.app_version,
        "docs_url": "/api/docs",
        "status": "running"
    }


# ============================================================================
# HEALTH CHECK ENDPOINT
# ============================================================================

@app.get(
    "/health",
    tags=["Health"],
    summary="Health Check",
    description="Check if the API is running"
)
async def health_check() -> dict:
    """
    Health check endpoint to verify server is running.
    
    Returns:
        dict: Status and timestamp
        
    Example:
        GET /health
        Response: {"status": "ok", "service": "BAPS Backend", "timestamp": "2026-04-02T10:30:00"}
    """
    from datetime import datetime
    return {
        "status": "ok",
        "service": settings.app.app_name,
        "version": settings.app.app_version,
        "timestamp": datetime.utcnow().isoformat()
    }


# ============================================================================
# ROUTE INCLUDES (Add your API routers here)
# ============================================================================

# Include API v1 routers
from api.v1 import router as api_v1_router

# Dual-mount for compatibility: handle both /api/v1/... and /...
app.include_router(api_v1_router, prefix="/api/v1")
app.include_router(api_v1_router)


# ============================================================================
# CONFIGURATION DISPLAY
# ============================================================================

def display_configuration():
    """Display loaded configuration for debugging"""
    logger.info("=" * 80)
    logger.info("LOADED CONFIGURATION")
    logger.info("=" * 80)
    logger.info(f"App Name: {settings.app.app_name}")
    logger.info(f"App Version: {settings.app.app_version}")
    logger.info(f"Environment: {settings.app.environment}")
    logger.info(f"Debug Mode: {settings.app.debug}")
    logger.info(f"Log Level: {settings.app.log_level}")
    logger.info(f"CORS Origins: {settings.app.cors_origins}")
    logger.info(f"API Docs Enabled: {settings.app.docs_enabled}")
    logger.info("-" * 80)
    logger.info(f"PostgreSQL: {settings.postgres.user}@{settings.postgres.host}:{settings.postgres.port}/{settings.postgres.database}")
    logger.info(f"Redis: {settings.redis.host}:{settings.redis.port} (DB: {settings.redis.database})")
    logger.info(f"RabbitMQ: {settings.rabbitmq.user}@{settings.rabbitmq.host}:{settings.rabbitmq.port}/{settings.rabbitmq.vhost}")
    logger.info(f"SMTP: {settings.smtp.host}:{settings.smtp.port} (TLS: {settings.smtp.use_tls})")
    logger.info(f"JWT Algorithm: {settings.security.algorithm}")
    logger.info(f"Access Token Expiry: {settings.security.access_token_expire_minutes} minutes")
    logger.info("=" * 80)


# ============================================================================
# MAIN ENTRY POINT
# ============================================================================

def main():
    """
    Main function to run the FastAPI server
    Server runs on host:port defined in .env configuration
    """
    logger.info("=" * 80)
    logger.info("Starting BAPS Backend Server...")
    logger.info(f"App: {settings.app.app_name} v{settings.app.app_version}")
    logger.info(f"Environment: {settings.app.environment}")
    logger.info(f"Server: http://127.0.0.1:9000")
    logger.info(f"Docs: http://127.0.0.1:9000/api/docs")
    logger.info("=" * 80)
    
    # Display all loaded configuration
    display_configuration()
    
    import os
    port = int(os.environ.get("PORT", 9000))
    
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=port,
        reload=True,
        log_config=None,  # Disable uvicorn default logging to use our logger
    )


if __name__ == "__main__":
    main()

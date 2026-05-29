# Logging Middleware Integration Guide

## Overview
The `Logging.py` middleware in the `middleware/` folder provides comprehensive HTTP request/response logging for your FastAPI application.

## Features
✅ Logs all incoming HTTP requests (method, path, parameters)
✅ Logs all outgoing HTTP responses (status code, processing time)
✅ Request ID tracking for request lifecycle monitoring
✅ Automatic request/response time measurement
✅ Automatic `Logs/` folder creation at project level
✅ Daily log file rotation (separate logs per day)
✅ Console and file logging for all messages
✅ Sensitive data redaction (passwords, tokens, API keys, etc.)
✅ Exception and error tracking

## Log File Location
Logs are stored at: `baps_backend_server/Logs/api_requests_YYYY_MM_DD.log`

## Integration Steps

### Step 1: Add to main.py

```python
from fastapi import FastAPI
from middleware.Logging import LoggingMiddleware, RequestTimingMiddleware, get_logger

# Initialize FastAPI app
app = FastAPI(
    title="BAPS Backend Server",
    description="Backend API for BAPS",
    version="1.0.0"
)

# Add logging middleware (ORDER MATTERS - add this early)
app.add_middleware(RequestTimingMiddleware)
app.add_middleware(LoggingMiddleware)

# Get logger instance for use in routes
logger = get_logger()

@app.on_event("startup")
async def startup_event():
    logger.info("BAPS Backend Server started successfully")

@app.on_event("shutdown")
async def shutdown_event():
    logger.info("BAPS Backend Server shutdown")

# Your routes here...
```

### Step 2: Using Logger in Routes

```python
from fastapi import APIRouter
from middleware.Logging import get_logger

router = APIRouter()
logger = get_logger()

@router.get("/api/v1/example")
async def example_route():
    logger.info("Processing example route")
    logger.debug("Example debug information")
    
    try:
        # Your logic here
        return {"message": "Success"}
    except Exception as e:
        logger.error(f"Error processing example: {str(e)}", exc_info=True)
        raise
```

### Step 3: Using Logger in Services

```python
from middleware.Logging import get_logger

logger = get_logger()

def my_service_function():
    logger.info("Starting service function")
    # Your service logic
    logger.info("Service function completed")
```

## Log File Format

```
2026-01-15 10:30:45 - BAPS_API_Logger - INFO - [20260115103045-5432] Incoming Request | Method: POST | Path: /api/v1/auth/login | Client: 192.168.1.100
2026-01-15 10:30:45 - BAPS_API_Logger - DEBUG - [20260115103045-5432] Request Details | URL: http://localhost:8000/api/v1/auth/login | Query Params: {}
2026-01-15 10:30:45 - BAPS_API_Logger - INFO - [20260115103045-5432] Outgoing Response | Status: 200 | Process Time: 0.145s
```

## Log Levels

- **DEBUG**: Detailed information for diagnostics (headers, body content)
- **INFO**: General operational messages (requests, responses, status)
- **WARNING**: Warning messages (error responses, suspicious activity)
- **ERROR**: Error messages and exception tracebacks
- **CRITICAL**: Critical system failures

## Request ID Tracking

Every request is assigned a unique Request ID in format: `YYYYMMDDHHMMSS-XXXX`

This ID is:
- Logged in every log message for that request
- Added to response headers as `X-Request-ID`
- Useful for correlating logs across requests

## Performance Monitoring

Processing time is tracked for every request and:
- Logged as part of the response message
- Added to response headers as `X-Process-Time` (in seconds)
- Helps identify slow endpoints

## Security Features

### Sensitive Data Redaction

The following fields are automatically redacted in logs:
- Authorization headers
- Cookies
- API Keys
- Tokens
- Passwords
- Secrets
- Credit card data
- SSN/PIN data

### Example - Redacted Output
```
Request Headers: {
    'authorization': '***REDACTED***',
    'content-type': 'application/json'
}

Request Body: {
    'username': 'john@example.com',
    'password': '***REDACTED***',
    'api_key': '***REDACTED***'
}
```

## Customization

### Change Log Level
Modify the logger level in `middleware/Logging.py`:

```python
logger.setLevel(logging.WARNING)  # or DEBUG, INFO, ERROR, CRITICAL
```

### Add Custom Logging
Add any custom keys to `sensitive_keys` in `_sanitize_headers()` or `_sanitize_body()`:

```python
sensitive_keys = {
    'password', 'token', 'secret', 'api_key',
    'your_custom_sensitive_field'  # Add here
}
```

### Change Log Location
Modify the `log_dir` path in `_setup_logger()`:

```python
log_dir = os.path.join(project_root, "Logs")  # Change "Logs" to desired folder
```

## Troubleshooting

### Logs not appearing?
1. Check that middleware is added in main.py before routes
2. Verify `Logs/` folder was created at project level
3. Ensure `fastapi` and `starlette` are installed

### Too much logging output?
1. Reduce console handler level: `console_handler.setLevel(logging.INFO)`
2. Disable debug logging for specific components
3. Filter request paths using FastAPI middleware exclusions

### File Permission Issues?
Ensure the user running the app has write permissions to the `baps_backend_server/` directory

## Testing the Logger

Run this simple test in your main.py:

```python
from middleware.Logging import get_logger

logger = get_logger()
logger.info("Logger initialized successfully")
logger.debug("Debug message test")
logger.warning("Warning message test")
logger.error("Error message test")
```

You should see logs in:
1. Console output
2. `baps_backend_server/Logs/api_requests_YYYY_MM_DD.log`

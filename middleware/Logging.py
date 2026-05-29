"""
Author: BAPS Development Team
Year: 2026
Description: Logging Middleware for FastAPI - Captures HTTP requests, responses, and performance metrics
"""

import logging
import os
import time
from datetime import datetime
from typing import Callable
from fastapi import Request
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import Response
from starlette.types import ASGIApp
import json


class LoggingMiddleware(BaseHTTPMiddleware):
    """
    FastAPI Middleware for comprehensive request/response logging
    
    Features:
    - Logs all HTTP requests (method, path, headers, body)
    - Logs all HTTP responses (status code, response time)
    - Captures exceptions and errors
    - Performance monitoring
    - Automatic log file rotation by date
    """
    
    def __init__(self, app: ASGIApp):
        """
        Initialize the logging middleware
        
        Args:
            app: FastAPI application instance
        """
        super().__init__(app)
        self.logger = self._setup_logger()
    
    @staticmethod
    def _setup_logger() -> logging.Logger:
        """
        Setup logger with file and console handlers
        
        Returns:
            logging.Logger: Configured logger instance
        """
        logger = logging.getLogger("BAPS_API_Logger")
        
        # Prevent duplicate handlers
        if logger.handlers:
            return logger
        
        logger.setLevel(logging.DEBUG)
        
        # Create Logs directory at project level (baps_backend_server/Logs)
        current_dir = os.path.dirname(os.path.abspath(__file__))
        project_root = os.path.dirname(current_dir)
        log_dir = os.path.join(project_root, "Logs")
        
        # Create logs directory if it doesn't exist
        if not os.path.exists(log_dir):
            os.makedirs(log_dir)
            logger.info(f"Created Logs directory at: {log_dir}")
        
        # Create log filename with date
        log_filename = os.path.join(
            log_dir, 
            f"api_requests_{datetime.now().strftime('%Y_%m_%d')}.log"
        )
        
        # File handler configuration
        file_handler = logging.FileHandler(log_filename, encoding='utf-8')
        file_handler.setLevel(logging.DEBUG)
        
        # Console handler configuration
        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.INFO)
        
        # Formatter with detailed information
        detailed_formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - [%(filename)s:%(lineno)d] - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        
        console_formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        
        file_handler.setFormatter(detailed_formatter)
        console_handler.setFormatter(console_formatter)
        
        # Add handlers to logger
        logger.addHandler(file_handler)
        logger.addHandler(console_handler)
        
        return logger
    
    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        """
        Process the request and log details
        
        Args:
            request: FastAPI Request object
            call_next: Next middleware/route handler
        
        Returns:
            Response: HTTP response
        """
        # Record request start time
        start_time = time.time()
        
        # Extract request information
        request_id = self._generate_request_id()
        method = request.method
        url = str(request.url)
        path = request.url.path
        query_params = dict(request.query_params) if request.query_params else {}
        headers = dict(request.headers)
        
        # Log incoming request
        self.logger.info(
            f"[{request_id}] Incoming Request | "
            f"Method: {method} | Path: {path} | "
            f"Client: {request.client.host if request.client else 'Unknown'}"
        )
        
        self.logger.debug(
            f"[{request_id}] Request Details | "
            f"URL: {url} | Query Params: {query_params}"
        )
        
        # Log headers (excluding sensitive ones)
        safe_headers = self._sanitize_headers(headers)
        self.logger.debug(f"[{request_id}] Request Headers: {safe_headers}")
        
        # Try to log request body for POST/PUT/PATCH requests
        # NOTE: await request.body() in BaseHTTPMiddleware can cause requests to hang in FastAPI
        # if method in ["POST", "PUT", "PATCH"]:
        #     try:
        #         body = await request.body()
        #         if body:
        #             try:
        #                 body_json = json.loads(body)
        #                 # Sanitize sensitive data
        #                 safe_body = self._sanitize_body(body_json)
        #                 self.logger.debug(f"[{request_id}] Request Body: {safe_body}")
        #             except json.JSONDecodeError:
        #                 self.logger.debug(f"[{request_id}] Request Body (non-JSON): {body[:200]}")
        #     except Exception as e:
        #         self.logger.warning(f"[{request_id}] Error reading request body: {str(e)}")
        
        try:
            # Process the request
            response = await call_next(request)
            
        except Exception as e:
            # Log any exceptions that occur
            process_time = time.time() - start_time
            self.logger.error(
                f"[{request_id}] Exception occurred | "
                f"Method: {method} | Path: {path} | "
                f"Error: {str(e)} | Process Time: {process_time:.3f}s",
                exc_info=True
            )
            raise
        
        # Calculate processing time
        process_time = time.time() - start_time
        
        # Log response
        status_code = response.status_code
        self.logger.info(
            f"[{request_id}] Outgoing Response | "
            f"Status: {status_code} | Process Time: {process_time:.3f}s"
        )
        
        # Log warning for error status codes
        if status_code >= 400:
            self.logger.warning(
                f"[{request_id}] Error Response | "
                f"Status: {status_code} | Method: {method} | Path: {path}"
            )
        
        # Add custom headers to response
        response.headers["X-Process-Time"] = str(process_time)
        response.headers["X-Request-ID"] = request_id
        
        self.logger.debug(f"[{request_id}] Response Headers: {dict(response.headers)}")
        
        return response
    
    @staticmethod
    def _generate_request_id() -> str:
        """
        Generate unique request ID for tracking
        
        Returns:
            str: Unique request identifier
        """
        return f"{datetime.now().strftime('%Y%m%d%H%M%S')}-{int(time.time() * 1000) % 10000}"
    
    @staticmethod
    def _sanitize_headers(headers: dict) -> dict:
        """
        Remove sensitive information from headers
        
        Args:
            headers: Request headers dictionary
        
        Returns:
            dict: Sanitized headers
        """
        sensitive_keys = {
            'authorization', 'cookie', 'x-api-key', 'x-auth-token',
            'password', 'token', 'secret', 'api-key'
        }
        
        sanitized = {}
        for key, value in headers.items():
            if key.lower() in sensitive_keys:
                sanitized[key] = "***REDACTED***"
            else:
                sanitized[key] = value
        
        return sanitized
    
    @staticmethod
    def _sanitize_body(body: dict) -> dict:
        """
        Remove sensitive information from request body
        
        Args:
            body: Request body as dictionary
        
        Returns:
            dict: Sanitized body
        """
        sensitive_keys = {
            'password', 'token', 'secret', 'api_key', 'access_token',
            'refresh_token', 'creditcard', 'ssn', 'pin'
        }
        
        sanitized = body.copy() if isinstance(body, dict) else body
        
        for key in sensitive_keys:
            if isinstance(sanitized, dict) and key in sanitized:
                sanitized[key] = "***REDACTED***"
        
        return sanitized


class RequestTimingMiddleware(BaseHTTPMiddleware):
    """
    Middleware for measuring and logging request processing time
    """
    
    def __init__(self, app: ASGIApp):
        """Initialize timing middleware"""
        super().__init__(app)
        self.logger = logging.getLogger("BAPS_API_Logger")
    
    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        """Measure and log request timing"""
        start_time = time.time()
        response = await call_next(request)
        process_time = time.time() - start_time
        
        # Add timing header
        response.headers["X-Process-Time"] = str(process_time)
        
        return response


# Utility function to get logger instance
def get_logger(name: str = "BAPS_API_Logger") -> logging.Logger:
    """
    Get logger instance for use in routes and services
    
    Args:
        name: Logger name
    
    Returns:
        logging.Logger: Logger instance
    """
    return logging.getLogger(name)

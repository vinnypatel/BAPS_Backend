"""
CAPTCHA verification helpers for login protection.
"""

import json
from urllib.error import URLError
from urllib.parse import urlencode
from urllib.request import Request, urlopen

from fastapi import HTTPException, status

from core.config import settings
import requests

CAPTCHA_ERROR_MESSAGE = "CAPTCHA verification failed. Please try again."

TURNSTILE_SECRET_KEY = settings.security.captcha_secret_key

def verify_captcha_token(token: str, remote_ip: str | None = None):
    if not token:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="CAPTCHA token missing.",
        )

    try:
        response = requests.post(
            "https://challenges.cloudflare.com/turnstile/v0/siteverify",
            data={
                "secret": TURNSTILE_SECRET_KEY,
                "response": token,
                "remoteip": remote_ip,
            },
            timeout=10,
        )

        result = response.json()

        print("Turnstile response:", result)

    except requests.RequestException as e:
        print("Turnstile request failed:", str(e))

        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="CAPTCHA verification is temporarily unavailable.",
        )

    if not result.get("success"):
        print("Turnstile validation failed:", result)

        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="CAPTCHA verification failed.",
        )

    return True
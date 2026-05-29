"""
Simple in-process rate limiting helpers.
"""

import json
import os
import tempfile
import time
from dataclasses import dataclass, field
from pathlib import Path

from fastapi import HTTPException, status


@dataclass
class LoginAttemptState:
    attempts: list[float] = field(default_factory=list)
    locked_until: float = 0.0
    locked: bool = False
    failed_count: int = 0


ACCOUNT_LOCKED_MESSAGE = (
    "Your access has been locked due to multiple invalid login attempts. "
    "Please contact admin to unlock the access."
)


class LoginRateLimiter:
    """
    Tracks failed login attempts by client and username.

    This limiter is intentionally in-process. It protects a single running app
    instance; use a shared store such as Redis if the backend runs multiple
    workers or multiple servers.
    """

    def __init__(
        self,
        max_attempts: int,
        window_seconds: int,
        lockout_seconds: int,
        wait_attempts: int = 5,
        storage_path: str | None = None,
    ):
        self.max_attempts = max_attempts
        self.window_seconds = window_seconds
        self.lockout_seconds = lockout_seconds
        self.wait_attempts = wait_attempts
        self.storage_path = Path(storage_path or tempfile.gettempdir()) / "baps_login_rate_limits.json"
        self._attempts: dict[str, LoginAttemptState] = self._load_attempts()

    def _load_attempts(self) -> dict[str, LoginAttemptState]:
        try:
            raw = json.loads(self.storage_path.read_text())
        except (FileNotFoundError, json.JSONDecodeError, OSError):
            return {}

        attempts: dict[str, LoginAttemptState] = {}
        for key, value in raw.items():
            attempts[key] = LoginAttemptState(
                attempts=[float(attempt) for attempt in value.get("attempts", [])],
                locked_until=float(value.get("locked_until", 0.0)),
                locked=bool(value.get("locked", False)),
                failed_count=int(value.get("failed_count", len(value.get("attempts", [])))),
            )
        return attempts

    def _save_attempts(self) -> None:
        self.storage_path.parent.mkdir(parents=True, exist_ok=True)
        payload = {
            key: {
                "attempts": state.attempts,
                "locked_until": state.locked_until,
                "locked": state.locked,
                "failed_count": state.failed_count,
            }
            for key, state in self._attempts.items()
        }
        temp_path = self.storage_path.with_suffix(".tmp")
        temp_path.write_text(json.dumps(payload))
        os.replace(temp_path, self.storage_path)

    def check(self, key: str) -> None:
        self._attempts = self._load_attempts()
        if self.is_locked(key):
            self._raise_account_locked()
        retry_after = self.get_retry_after(key)
        if retry_after:
            self._raise_rate_limit(retry_after)

    def _raise_account_locked(self) -> None:
        raise HTTPException(
            status_code=status.HTTP_423_LOCKED,
            detail=ACCOUNT_LOCKED_MESSAGE,
        )

    def _raise_rate_limit(self, retry_after: int) -> None:
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail="Please wait for 5 minutes before trying again.",
            headers={"Retry-After": str(retry_after)},
        )

    def get_retry_after(self, key: str) -> int | None:
        state = self._attempts.get(key)
        if not state:
            return None
        if state.locked:
            return None

        now = time.time()
        if state.locked_until <= now:
            if state.locked_until:
                self._attempts.pop(key, None)
                self._save_attempts()
            return None

        return max(1, int(state.locked_until - now))

    def is_locked(self, key: str) -> bool:
        state = self._attempts.get(key)
        return bool(state and state.locked)

    def record_failure(self, key: str) -> str | None:
        self._attempts = self._load_attempts()
        now = time.time()
        window_start = now - self.window_seconds
        state = self._attempts.setdefault(key, LoginAttemptState())
        state.attempts = [attempt for attempt in state.attempts if attempt >= window_start]
        state.attempts.append(now)
        state.failed_count += 1

        if state.failed_count >= self.max_attempts:
            state.locked = True
            state.locked_until = 0.0
            state.attempts.clear()
            self._save_attempts()
            return "locked"

        if state.failed_count >= self.wait_attempts:
            state.locked_until = now + self.lockout_seconds
            self._save_attempts()
            return "wait"

        self._save_attempts()
        return None

    def reset(self, key: str) -> None:
        self._attempts = self._load_attempts()
        self._attempts.pop(key, None)
        self._save_attempts()

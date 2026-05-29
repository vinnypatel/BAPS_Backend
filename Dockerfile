# ============================================================
# BAPS Backend Server — Dockerfile
# ============================================================
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies (needed for asyncpg)
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for Docker layer caching)
COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt

# Copy the rest of the application
COPY . .

# Expose the FastAPI port
EXPOSE 9000

# Start the server
CMD ["python", "main.py"]

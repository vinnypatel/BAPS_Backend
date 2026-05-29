import asyncio
import time
from db.session import engine

async def test():
    print("Connecting...")
    start = time.time()
    try:
        async with engine.connect() as conn:
            print(f"Connected in {time.time() - start:.3f}s")
    except Exception as e:
        print(f"Connection failed: {e}")

if __name__ == "__main__":
    asyncio.run(test())

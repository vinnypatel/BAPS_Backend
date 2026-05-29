import urllib.request
import json

URL = "http://localhost:9000/api/v1"
payload = json.dumps({"username": "sanyojak1", "password": "baps123"}).encode('utf-8')

try:
    # 1. Login
    req = urllib.request.Request(f"{URL}/auth/login", data=payload, headers={'Content-Type': 'application/json'}, method='POST')
    with urllib.request.urlopen(req) as f:
        resp = json.loads(f.read().decode('utf-8'))
        token = resp["access_token"]
        print(f"Login success.")
        
        # 2. Get Haribhakts
        headers = {"Authorization": f"Bearer {token}"}
        req_h = urllib.request.Request(f"{URL}/haribhakts", headers=headers, method='GET')
        with urllib.request.urlopen(req_h) as f_h:
            data = json.loads(f_h.read().decode('utf-8'))
            print(f"Haribhakts status: 200")
            print(f"Count: {len(data)}")
            if len(data) > 0:
                print(f"First item: {json.dumps(data[0], indent=2)}")
except Exception as e:
    print(f"Error: {e}")
    if hasattr(e, 'read'):
        print(f"Details: {e.read().decode('utf-8')}")

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
        
        # 2. Get Haribhakts WITH SLASH
        headers = {"Authorization": f"Bearer {token}"}
        req_h = urllib.request.Request(f"{URL}/haribhakts/", headers=headers, method='GET')
        with urllib.request.urlopen(req_h) as f_h:
            print(f"Haribhakts WITH SLASH status: 200")
except Exception as e:
    print(f"Error: {e}")
    if hasattr(e, 'read'):
        print(f"Details: {e.read().decode('utf-8')}")

import urllib.request
import json

URL = "http://localhost:9000/api/v1"
payload = json.dumps({"username": "sanyojak1", "password": "baps123"}).encode('utf-8')

req = urllib.request.Request(f"{URL}/auth/login", data=payload, headers={'Content-Type': 'application/json'}, method='POST')
try:
    with urllib.request.urlopen(req) as f:
        resp = json.loads(f.read().decode('utf-8'))
        token = resp["access_token"]
        print(f"Login success. Token: {token[:10]}...")
        
        req_me = urllib.request.Request(f"{URL}/karyakars/me", headers={"Authorization": f"Bearer {token}"}, method='GET')
        with urllib.request.urlopen(req_me) as f_me:
            profile = json.loads(f_me.read().decode('utf-8'))
            print(f"Profile status: 200")
            print(f"Profile: {json.dumps(profile, indent=2)}")
except Exception as e:
    print(f"Error: {e}")
    if hasattr(e, 'read'):
        print(f"Details: {e.read().decode('utf-8')}")

import http.client
import json

conn = http.client.HTTPConnection("127.0.0.1", 9000)
payload = json.dumps({
    "username": "santnirdeshak",
    "password": "baps123"
})
headers = {
    'Content-Type': "application/json"
}
conn.request("POST", "/api/v1/auth/login", payload, headers)
res = conn.getresponse()
data = res.read()
print(f"Status: {res.status}")
print(f"Data: {data.decode('utf-8')}")

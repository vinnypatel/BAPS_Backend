import http.client
import json

token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrX3NuIiwiZXhwIjoxNzc4MDY4ODY2LCJ0eXBlIjoiYWNjZXNzIn0.Y987c0dYcTeVBZgwyM11cJD1ZUdDI0E7JInuDf7jymQ"
conn = http.client.HTTPConnection("127.0.0.1", 9000)
headers = {
    'Authorization': f"Bearer {token}"
}
conn.request("GET", "/api/v1/karyakars/me", "", headers)
res = conn.getresponse()
data = res.read()
print(f"Status: {res.status}")
print(f"Data: {data.decode('utf-8')}")

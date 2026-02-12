import requests

url = "https://yandex.ru/maps/-/CPQWMYMI"
try:
    response = requests.get(url, allow_redirects=True, timeout=10)
    print(f"Final URL: {response.url}")
except Exception as e:
    print(f"Error: {e}")

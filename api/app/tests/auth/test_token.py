"""Test token endpoint."""
from fastapi.testclient import TestClient

from ...main import app

client = TestClient(app)


def test_get_token():
    """Test getting a token."""
    headers = {
        "accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
    }
    data = {
        "username": "johndoe@email.com",
        "password": "secret",
    }
    response = client.post("/token", headers=headers, data=data)
    token_type = response.json().get("token_type")
    token = response.json().get("access_token")
    assert response.status_code == 200
    assert token_type == "bearer"
    assert token is not None

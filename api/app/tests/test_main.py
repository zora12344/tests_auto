"""Test the main module."""
from fastapi.testclient import TestClient

from ..main import app

client = TestClient(app)


def get_token():
    """Get a token for testing."""
    data = {
        "username": "johndoe@email.com",
        "password": "secret",
    }
    response = client.post("/token", data=data)
    return response.json().get("access_token")


def test_root_url():
    response = client.get("/")
    assert response.status_code == 404
    assert response.json() == {"detail": "Not Found"}

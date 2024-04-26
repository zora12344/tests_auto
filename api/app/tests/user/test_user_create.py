"""Test create user.""" ""
from fastapi.testclient import TestClient

from ...main import app

client = TestClient(app)


def test_create_user():
    """Test creating a user."""
    data = {
        "email": "user@email.com",
        "firstname": "user",
        "lastname": "user",
        "is_botanist": False,
        "password": "password",
    }
    response = client.post("/user/create", json=data)
    assert response.status_code == 200
    assert response.json().get("email") == data.get("email")
    assert response.json().get("firstname") == data.get("firstname")
    assert response.json().get("lastname") == data.get("lastname")
    assert response.json().get("is_botanist") == data.get("is_botanist")
    assert response.json().get("password") is None
    assert response.json().get("id") is not None

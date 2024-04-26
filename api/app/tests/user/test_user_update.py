"""Test update user data.""" ""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_update_token

client = TestClient(app)


def test_update_user_data():
    """Test updating a user."""
    data = {
        "firstname": "Mary",
        "lastname": "Doe",
    }
    headers = {"Authorization": f"Bearer {get_user_update_token()}"}
    response = client.put("/user/update_data", headers=headers, params=data)
    assert response.status_code == 200
    assert response.json() == {
        "email": "panthere@rose.com",
        "firstname": "Mary",
        "lastname": "Doe",
        "is_botanist": True,
        "id": 20,
    }


def test_update_user_password():
    """Test updating a user password."""
    data = {
        "old_password": "password",
        "new_password": "new_password",
    }
    headers = {"Authorization": f"Bearer {get_user_update_token()}"}
    response = client.put(
        "/user/update_password", headers=headers, params=data
    )
    assert response.status_code == 200


def test_update_user_email():
    """Test updating a user email."""
    data = {
        "new_email": "marydoe@email.com",
    }
    headers = {
        "Authorization": f"Bearer {get_user_update_token('new_password')}"
    }
    response = client.put("/user/update_email", headers=headers, params=data)
    assert response.status_code == 200

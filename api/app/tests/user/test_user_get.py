"""Test get user endpoints."""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_token

client = TestClient(app)


def test_get_user():
    """Test getting a user."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.get("/user", headers=headers)
    assert response.status_code == 200
    assert response.json() == {
        "email": "johndoe@email.com",
        "firstname": "John",
        "lastname": "Doe",
        "is_botanist": False,
        "id": 1,
    }


def test_get_user_posts():
    """Test getting user posts."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.get("/user/posts", headers=headers)
    assert response.status_code == 200


def test_get_user_comments():
    """Test getting user comments."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.get("/user/comments", headers=headers)
    assert response.status_code == 200

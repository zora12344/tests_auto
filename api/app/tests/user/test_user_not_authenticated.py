"""Test user endpoints when not authenticated."""
from fastapi.testclient import TestClient

from ...main import app

client = TestClient(app)


def test_get_user_not_authenticated():
    """Test getting user data when not authenticated."""
    routes = ["/user", "/user/posts", "/user/comments"]
    for route in routes:
        response = client.get(route)
        assert response.status_code == 401
        assert response.json() == {"detail": "Not authenticated"}


def test_put_update_data_user_not_authenticated():
    """Test updating user data when not authenticated."""
    response = client.put("/user/update_data", json={})
    assert response.status_code == 401
    assert response.json() == {"detail": "Not authenticated"}


def test_put_update_password_user_not_authenticated():
    """Test updating user password when not authenticated."""
    response = client.put("/user/update_password", json={})
    assert response.status_code == 401
    assert response.json() == {"detail": "Not authenticated"}


def test_put_update_email_user_not_authenticated():
    """Test updating user email when not authenticated."""
    response = client.put("/user/update_email", json={})
    assert response.status_code == 401
    assert response.json() == {"detail": "Not authenticated"}


def test_delete_user_not_authenticated():
    """Test deleting a user when not authenticated."""
    response = client.delete("/user/delete")
    assert response.status_code == 401
    assert response.json() == {"detail": "Not authenticated"}

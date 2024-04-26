"""Test using post endpoints when not authenticated."""
from fastapi.testclient import TestClient

from ...main import app

client = TestClient(app)


def test_get_post_not_authenticated():
    """Test getting posts when not authenticated."""
    routes = ["/posts/feed", "/post/search?q=test&limit=10"]
    for route in routes:
        response = client.get(route)
        assert response.status_code == 401
        assert response.json() == {"detail": "Not authenticated"}


def test_create_post_not_authenticated():
    """Test creating a post when not authenticated."""
    response = client.post("/post/create", json={})
    assert response.status_code == 401
    assert response.json() == {"detail": "Not authenticated"}


def test_update_post_not_authenticated():
    """Test updating a post when not authenticated."""
    response = client.put("/post/update/1", json={})
    assert response.status_code == 401
    assert response.json() == {"detail": "Not authenticated"}


def test_delete_post_not_authenticated():
    """Test deleting a post when not authenticated."""
    response = client.delete("/post/delete/1")
    assert response.status_code == 401
    assert response.json() == {"detail": "Not authenticated"}

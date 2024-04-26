"""Test get post endpoints."""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_token

client = TestClient(app)


def test_get_post_feed():
    """Test getting posts from feed."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.get("/posts/feed", headers=headers)
    assert response.status_code == 200
    assert response.json() != []  # Prevent a bug in the filter


def test_get_post_search():
    """Test searching for posts."""
    query = {"q": "te", "limit": 10}
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.get("/post/search", headers=headers, params=query)
    assert response.status_code == 200


def test_get_post_own_comments():
    """Test getting user's post comments."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.get("/post/1/comments", headers=headers)
    assert response.status_code == 200
    assert response.json() != []  # Prevent a bug in the filter


def test_get_post_others_comments():
    """Test getting others' post comments."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    # Post 2 is not owned by user 1
    response = client.get("/post/2/comments", headers=headers)
    assert response.status_code == 200
    assert response.json() != []  # Prevent a bug in the filter

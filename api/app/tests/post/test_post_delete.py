"""Test delete post."""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_token

client = TestClient(app)


def test_delete_post():
    """Test deleting a post."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.delete("/post/delete/29", headers=headers)
    assert response.status_code == 200

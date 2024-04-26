"""Test delete comment endpoint."""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_token

client = TestClient(app)


def test_delete_comment():
    """Test deleting a comment."""
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.delete("/comment/delete/141", headers=headers)
    assert response.status_code == 200

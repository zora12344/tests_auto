"""Test update comment endpoint."""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_token

client = TestClient(app)


def test_update_comment():
    """Test updating a comment."""
    data = {
        "content": "Pellentesque eget nunc. \
            Donec quis orci eget orci vehicula condimentum.",
    }
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.put("/comment/update/121", headers=headers, json=data)
    assert response.status_code == 200

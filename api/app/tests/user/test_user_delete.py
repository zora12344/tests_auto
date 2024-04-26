"""Test delete user.""" ""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_delete_token

client = TestClient(app)


def test_delete_user():
    """Test deleting a user."""
    headers = {"Authorization": f"Bearer {get_user_delete_token()}"}
    response = client.delete("/user/delete", headers=headers)
    assert response.status_code == 200
    assert response.json() == {
        "email": "thorderj@hatena.ne.jp",
        "firstname": "Toni",
        "lastname": "Horder",
        "is_botanist": False,
        "id": 21,
    }

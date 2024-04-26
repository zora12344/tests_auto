"""Test update post.""" ""
from fastapi.testclient import TestClient

from ...main import app
from ..authentication import get_user_token

client = TestClient(app)


def test_update_post():
    """Test updating a post."""
    data = {
        "care_start": "2023-05-03T14:29:50.657Z",
        "care_end": "2023-05-03T14:29:50.657Z",
        "plant_name": "Leïna-Zarha",
        "description": "Un magnifique spécimen de ficus hybride. \
            J'adore cette plante.",
        "image_url": "https://res.cloudinary.com/dsjttmslm/image/upload/\
            v1683061030/compte_1_flliuj.png",
        "latitude": 48.883081,
        "longitude": 2.339415,
    }
    headers = {"Authorization": f"Bearer {get_user_token()}"}
    response = client.put("/post/update/1", headers=headers, json=data)
    assert response.status_code == 200

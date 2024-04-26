"""Authentication helper functions for tests."""
from fastapi.testclient import TestClient

from ..main import app

client = TestClient(app)


def get_token(username: str, password: str) -> str:
    """Get a token for a user."""
    headers = {
        "accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
    }
    data = {
        "username": username,
        "password": password,
    }
    response = client.post("/token", headers=headers, data=data)
    return response.json().get("access_token")


def get_user_token() -> str:
    """This user is meant to be used in tests
    that don't require a specific user."""
    return get_token("johndoe@email.com", "secret")


def get_user_update_token(password: str = "password") -> str:
    """This user is meant to be updated in test_user_update.py file"""
    return get_token("panthere@rose.com", password)


def get_botanist_token() -> str:
    """This user is meant to be used in tests that require a botanist user."""
    return get_token("micheldude@email.com", "password")


def get_user_delete_token() -> str:
    """This user is meant to be deleted in test_user_delete.py file"""
    return get_token("thorderj@hatena.ne.jp", "password")

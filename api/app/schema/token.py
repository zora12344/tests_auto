"""Token schema used to validate incoming tokens."""
from pydantic import BaseModel


class Token(BaseModel):
    """Token schema used to validate incoming tokens."""

    access_token: str
    token_type: str


class TokenData(BaseModel):
    """Token data schema, used to validate incoming tokens data."""

    username: str | None = None

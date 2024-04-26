"""Post schema, used to validate post data."""
from datetime import datetime

from pydantic import BaseModel

from .user import User


class PostBase(BaseModel):
    """Post base schema, used to validate post data.
    class used as a base for other post schemas."""

    care_start: datetime | None
    care_end: datetime | None
    plant_name: str
    image_url: str
    description: str | None
    latitude: float
    longitude: float


class PostCreate(PostBase):
    """Post create schema, used to validate post data at creation."""

    pass


class Post(PostBase):
    """Post schema, used to validate post data."""

    id: int
    owner_id: int
    keeper_id: int | None = None
    creation_date: datetime
    owner: User

    class Config:
        orm_mode = True

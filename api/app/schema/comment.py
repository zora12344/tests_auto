"""Comment schemas."""
from datetime import datetime

from pydantic import BaseModel


class CommentBase(BaseModel):
    """Comment base schema, used to validate comment data.
    class used as a base for other comment schemas.
    """

    content: str
    # TODO: add picture (path to picture)


class CommentCreate(CommentBase):
    """Comment create schema.
    Used to validate comment data at comment creation."""

    pass


class Comment(CommentBase):
    """Comment schema, used to validate comment data."""

    id: int
    post_id: int
    user_id: int
    posting_date: datetime

    class Config:
        orm_mode = True

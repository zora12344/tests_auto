"""User schemas module."""
from pydantic import BaseModel


class UserBase(BaseModel):
    """User base schema, used to validate user data.
    class used as a base for other user schemas."""

    email: str
    firstname: str
    lastname: str
    is_botanist: bool = False


class UserCreate(UserBase):
    """User create schema, used to validate user data at user creation."""

    password: str


class User(UserBase):
    """User schema, used to validate user data."""

    id: int

    class Config:
        orm_mode = True


class UserInDB(User):
    """User in database schema, used to validate user data in database."""

    hashed_password: str

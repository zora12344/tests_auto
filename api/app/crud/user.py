"""CRUD operations for users."""
from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session

from .. import models
from ..database import util as database
from ..exception import CREDENTIALS_EXCEPTION
from ..schema.user import UserCreate
from ..security import (
    get_password_hash,
    get_token_data,
    oauth2_scheme,
    verify_password,
)


def get_user(username: str, db: Session):
    """Get a user by username."""
    db_user = get_user_by_email(db=db, email=username)
    if db_user:
        return db_user
    else:
        raise HTTPException(status_code=404, detail="User not found")


def authenticate_user(username: str, password: str, db: Session):
    """Authenticate a user."""
    user = get_user(username=username, db=db)
    if not user:
        return False
    if not verify_password(password, user.hashed_password):
        return False
    return user


async def get_current_user(
    token: str = Depends(oauth2_scheme), db: Session = Depends(database.get_db)
):
    """Get the current user.

    Getting the current user via authentication."""
    token_data = get_token_data(token)
    user = get_user(username=token_data.username, db=db)
    if user is None:
        raise CREDENTIALS_EXCEPTION
    return user


def get_user_by_email(db: Session, email: str):
    """Get a user by email.
    rembmer that the oauth2 `username` is the user's `email` in our app."""
    return db.query(models.User).filter(models.User.email == email).first()


def get_user_posts(db: Session, username: str) -> list[models.Post]:
    """Get a user's posts."""
    return (
        db.query(models.Post)
        .join(models.User.posts)
        .filter(models.User.email == username)
        .all()
    )


def get_current_user_posts(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(database.get_db),
) -> list[models.Post]:
    """Get the current user's posts."""
    token_data = get_token_data(token)
    user_posts = get_user_posts(username=token_data.username, db=db)
    if user_posts is None:
        raise CREDENTIALS_EXCEPTION
    return user_posts


def get_user_comments(db: Session, username: str) -> list[models.Comment]:
    """Get a user's comments."""
    return (
        db.query(models.Comment)
        .join(models.User.comments)
        .filter(models.User.email == username)
        .all()
    )


def get_current_user_comments(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(database.get_db),
) -> list[models.Comment]:
    """Get the current user's comments."""
    token_data = get_token_data(token)
    user_comments = get_user_comments(username=token_data.username, db=db)
    if user_comments is None:
        raise CREDENTIALS_EXCEPTION
    return user_comments


def create_user(db: Session, user: UserCreate):
    """Create a new user."""
    hashed_password = get_password_hash(password=user.password)
    db_user = models.User(
        email=user.email,
        hashed_password=hashed_password,
        firstname=user.firstname,
        lastname=user.lastname,
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def update_user_email(db: Session, username: str, new_email: str):
    """Update a user's email."""
    db_user = (
        db.query(models.User).filter(models.User.email == username).first()
    )
    db_user.email = new_email
    db.commit()
    db.refresh(db_user)
    return db_user


def update_user_password(
    db: Session, username: str, old_password: str, new_password: str
):
    """Update a user's password."""
    db_user = (
        db.query(models.User).filter(models.User.email == username).first()
    )
    if not verify_password(
        plain_password=old_password, hashed_password=db_user.hashed_password
    ):
        raise HTTPException(
            status_code=400, detail="Wrong password, nothing was updated"
        )
    db_user.hashed_password = get_password_hash(password=new_password)
    db.commit()
    db.refresh(db_user)
    return db_user


def update_user_data(
    db: Session, username: str, firstname: str, lastname: str
):
    """Update a user's data."""
    db_user = (
        db.query(models.User).filter(models.User.email == username).first()
    )
    db_user.firstname = firstname
    db_user.lastname = lastname
    db.commit()
    db.refresh(db_user)
    return db_user


def update_current_user_email(
    new_email: str,
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(database.get_db),
):
    """Update the current user's email.

    # TODO

    - Check that the email is not already in use
    - Logout the user after updating the email
    """
    token_data = get_token_data(token)
    updated_user = update_user_email(
        new_email=new_email, username=token_data.username, db=db
    )
    if updated_user is None:
        raise CREDENTIALS_EXCEPTION
    return updated_user


def update_current_user_password(
    old_password: str,
    new_password: str,
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(database.get_db),
):
    """Update the current user's password.

    # TODO

    - Logout the user after updating the password
    """
    token_data = get_token_data(token)
    updated_user = update_user_password(
        old_password=old_password,
        new_password=new_password,
        username=token_data.username,
        db=db,
    )
    if updated_user is None:
        raise CREDENTIALS_EXCEPTION
    return updated_user


def update_current_user_data(
    firstname: str,
    lastname: str,
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(database.get_db),
):
    """Update the current user's data."""
    token_data = get_token_data(token)
    updated_user = update_user_data(
        firstname=firstname,
        lastname=lastname,
        username=token_data.username,
        db=db,
    )
    if updated_user is None:
        raise CREDENTIALS_EXCEPTION
    return updated_user


def delete_user(db: Session, username: str):
    """Delete a user."""
    user = db.query(models.User).filter(models.User.email == username).first()
    db.delete(user)
    db.commit()
    return user


async def delete_current_user(
    token: str = Depends(oauth2_scheme), db: Session = Depends(database.get_db)
):
    """Delete the current user.

    # TODO

    - Logout the user after deleting the account
    """
    token_data = get_token_data(token)
    deleted_user = delete_user(username=token_data.username, db=db)
    if deleted_user is None:
        raise CREDENTIALS_EXCEPTION
    return deleted_user

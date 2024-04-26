"""CRUD operations for posts."""
from datetime import datetime

from fastapi import Depends, HTTPException
from sqlalchemy import or_
from sqlalchemy.orm import Session, joinedload

from .. import models
from ..database import util as database
from ..exception import CREDENTIALS_EXCEPTION
from ..schema.post import PostCreate
from ..security import get_token_data, oauth2_scheme


def get_user_feed(
    token: str = Depends(oauth2_scheme), db: Session = Depends(database.get_db)
):
    """Get the posts that do not have a keeper yet."""
    get_token_data(token)
    return (
        db.query(models.Post)
        .options(joinedload(models.Post.owner))
        .filter(
            models.Post.keeper_id == None
        )  # exclude posts that already have a keeper
        .all()
    )


def search_posts(token: str, db: Session, search: str, limit: int = 10):
    """Search posts by description or plant name."""
    get_token_data(token)
    return (
        db.query(models.Post)
        .filter(
            or_(
                models.Post.description.ilike(f"%{search}%"),
                models.Post.plant_name.ilike(f"%{search}%"),
            )
        )
        .limit(limit)
        .all()
    )


def get_post_comments(
    post_id: int,
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(database.get_db),
) -> list[models.Comment]:
    """Get the post's comments."""
    get_token_data(token)
    post = db.query(models.Post).filter(models.Post.id == post_id).first()
    if not post:
        raise HTTPException(status_code=404, detail="Post not found")
    return post.comments


def create_post(db: Session, username: str, post: PostCreate):
    """Create a post."""
    db_user = (
        db.query(models.User).filter(models.User.email == username).first()
    )
    db_post = models.Post(
        creation_date=datetime.now(),
        plant_name=post.plant_name,
        care_start=post.care_start,
        care_end=post.care_end,
        description=post.description,
        owner_id=db_user.id,
        image_url=post.image_url,
        latitude=post.latitude,
        longitude=post.longitude,
    )
    db.add(db_post)
    db.commit()
    db.refresh(db_post)
    return db_post


def create_current_user_post(
    post: PostCreate,
    token: str,
    db: Session,
) -> models.Post:
    """Create a post for the current user."""
    token_data = get_token_data(token)
    created_post = create_post(post=post, username=token_data.username, db=db)
    if created_post is None:
        raise CREDENTIALS_EXCEPTION
    return created_post


def update_post(db: Session, post_id: int, post: PostCreate, username: str):
    """Update a post."""
    db_user = (
        db.query(models.User).filter(models.User.email == username).first()
    )
    db_post = db.query(models.Post).filter(models.Post.id == post_id).first()
    if db_post is None:
        raise HTTPException(status_code=404, detail="Post not found")
    if db_post.owner_id != db_user.id:
        return None
    db_post.creation_date = db_post.creation_date
    db_post.care_start = post.care_start
    db_post.care_end = post.care_end
    db_post.description = post.description
    db.commit()
    db.refresh(db_post)
    return db_post


def update_current_user_post(
    post_id: int,
    post: PostCreate,
    token: str,
    db: Session,
) -> models.Post:
    """Update a post for the current user."""
    token_data = get_token_data(token)
    updated_post = update_post(
        post_id=post_id, post=post, username=token_data.username, db=db
    )
    if updated_post is None:
        raise CREDENTIALS_EXCEPTION
    return updated_post


def delete_post(db: Session, post_id: int, username: str):
    """Delete a post."""
    db_user = (
        db.query(models.User).filter(models.User.email == username).first()
    )
    db_post = db.query(models.Post).filter(models.Post.id == post_id).first()
    if db_post is None:
        raise HTTPException(status_code=404, detail="Post not found")
    if db_post.owner_id != db_user.id:
        return None
    db.delete(db_post)
    db.commit()
    return db_post


def delete_current_user_post(
    post_id: int,
    token: str,
    db: Session,
) -> models.Post:
    """Delete a post for the current user."""
    token_data = get_token_data(token)
    deleted_post = delete_post(
        post_id=post_id, username=token_data.username, db=db
    )
    if deleted_post is None:
        raise CREDENTIALS_EXCEPTION
    return deleted_post

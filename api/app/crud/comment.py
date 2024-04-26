"""CRUD operations on Comment model."""
from datetime import datetime

from fastapi import HTTPException
from sqlalchemy.orm import Session

from .. import models
from ..exception import CREDENTIALS_EXCEPTION
from ..schema.comment import CommentCreate
from ..security import get_token_data


def create_comment(
    db: Session, comment: CommentCreate, username: str, post_id: int
):
    """Create a comment."""
    user = db.query(models.User).filter(models.User.email == username).first()
    post = db.query(models.Post).filter(models.Post.id == post_id).first()
    if post is None:
        raise HTTPException(status_code=404, detail="Post not found")
    if post.owner_id != user.id:
        raise HTTPException(status_code=401, detail="Unauthorized")

    db_comment = models.Comment(
        content=comment.content,
        posting_date=datetime.now(),
        user_id=user.id,
        post_id=post.id,
    )
    db.add(db_comment)
    db.commit()
    db.refresh(db_comment)
    return db_comment


def create_current_user_comment(
    post_id: int,
    comment: CommentCreate,
    token: str,
    db: Session,
) -> models.Comment:
    """Create a comment on a post for the current user."""
    token_data = get_token_data(token)
    created_comment = create_comment(
        post_id=post_id, comment=comment, username=token_data.username, db=db
    )
    if created_comment is None:
        raise CREDENTIALS_EXCEPTION
    return created_comment


def update_comment(
    db: Session, comment_id: int, comment: CommentCreate, username: str
):
    """Update a comment."""
    user = db.query(models.User).filter(models.User.email == username).first()
    comment = (
        db.query(models.Comment)
        .filter(models.Comment.id == comment_id)
        .first()
    )
    if comment is None:
        raise HTTPException(status_code=404, detail="Comment not found")
    if comment.user_id != user.id:
        return None
    comment.content = comment.content
    comment.posting_date = comment.posting_date
    db.commit()
    db.refresh(comment)
    return comment


def update_current_user_comment(
    comment_id: int,
    comment: CommentCreate,
    token: str,
    db: Session,
) -> models.Comment:
    """Update a comment for the current user."""
    token_data = get_token_data(token)
    updated_comment = update_comment(
        comment_id=comment_id,
        comment=comment,
        username=token_data.username,
        db=db,
    )
    if updated_comment is None:
        raise CREDENTIALS_EXCEPTION
    return updated_comment


def delete_comment(db: Session, comment_id: int, username: str):
    """Delete a comment."""
    user = db.query(models.User).filter(models.User.email == username).first()
    comment = (
        db.query(models.Comment)
        .filter(models.Comment.id == comment_id)
        .first()
    )
    if comment is None:
        raise HTTPException(status_code=404, detail="Comment not found")
    if comment.user_id != user.id:
        return None
    db.delete(comment)
    db.commit()
    return comment


def delete_current_user_comment(
    comment_id: int,
    token: str,
    db: Session,
) -> models.Post:
    """Delete a comment for the current user."""
    token_data = get_token_data(token)
    deleted_comment = delete_comment(
        comment_id=comment_id, username=token_data.username, db=db
    )
    if deleted_comment is None:
        raise CREDENTIALS_EXCEPTION
    return deleted_comment

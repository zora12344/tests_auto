"""Routes for comment."""
from fastapi import Depends
from sqlalchemy.orm import Session

from ..crud import comment as commentcrud
from ..database import util as database
from ..schema.comment import Comment, CommentCreate
from ..security import oauth2_scheme


class CommentRoutes:
    def __init__(self, api) -> None:
        @api.post("/comment/create", response_model=Comment, tags=["comment"])
        def create_comment(
            post_id: int,
            comment: CommentCreate,
            token: str = Depends(oauth2_scheme),
            db: Session = Depends(database.get_db),
        ):
            """Create a new comment."""
            return commentcrud.create_current_user_comment(
                post_id=post_id, comment=comment, token=token, db=db
            )

        @api.put(
            "/comment/update/{comment_id}",
            response_model=Comment,
            tags=["comment"],
        )
        def update_comment(
            comment_id: int,
            comment: CommentCreate,
            token: str = Depends(oauth2_scheme),
            db: Session = Depends(database.get_db),
        ):
            """Update the current user's comment."""
            updated_comment = commentcrud.update_current_user_comment(
                token=token, db=db, comment_id=comment_id, comment=comment
            )
            return updated_comment

        @api.delete(
            "/comment/delete/{comment_id}",
            response_model=Comment,
            tags=["comment"],
        )
        def delete_comment(
            comment_id: int,
            token: str = Depends(oauth2_scheme),
            db: Session = Depends(database.get_db),
        ):
            """Delete the current user's comment."""
            deleted_comment = commentcrud.delete_current_user_comment(
                token=token, db=db, comment_id=comment_id
            )
            return deleted_comment

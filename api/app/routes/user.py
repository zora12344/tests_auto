"""Routes for user."""
from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session

from ..crud import user as usercrud
from ..database import util as database
from ..schema.comment import Comment
from ..schema.post import Post
from ..schema.user import User, UserCreate


class UserRoutes:
    def __init__(self, api) -> None:
        @api.get("/user", response_model=User, tags=["user"])
        async def read_users_me(
            current_user: User = Depends(usercrud.get_current_user),
        ):
            """Get the current user."""
            return current_user

        @api.post("/user/create", response_model=User, tags=["user"])
        def create_user(
            user: UserCreate, db: Session = Depends(database.get_db)
        ):
            """Create a new user."""
            db_user = usercrud.get_user_by_email(db, email=user.email)
            if db_user:
                raise HTTPException(
                    status_code=400, detail="Email already registered"
                )
            return usercrud.create_user(db=db, user=user)

        @api.get("/user/posts", response_model=list[Post], tags=["user"])
        def read_current_user_posts(
            user_posts: list[Post] = Depends(usercrud.get_current_user_posts),
        ):
            """Get the current user's posts."""
            return user_posts

        @api.get("/user/comments", response_model=list[Comment], tags=["user"])
        def read_current_user_comments(
            user_comments: list[Comment] = Depends(
                usercrud.get_current_user_comments
            ),
        ):
            """Get the current user's comments."""
            return user_comments

        @api.put("/user/update_data", response_model=User, tags=["user"])
        def update_current_user_data(
            updated_user: User = Depends(usercrud.update_current_user_data),
        ):
            """Update the current user's data."""
            return updated_user

        @api.put("/user/update_password", response_model=User, tags=["user"])
        def update_current_user_password(
            updated_user: User = Depends(
                usercrud.update_current_user_password
            ),
        ):
            """Update the current user's password."""
            return updated_user

        @api.put("/user/update_email", response_model=User, tags=["user"])
        def update_current_user_email(
            updated_user: User = Depends(usercrud.update_current_user_email),
        ):
            """Update the current user's email."""
            return updated_user

        @api.delete("/user/delete", response_model=User, tags=["user"])
        def delete_current_user(
            deleted_user: User = Depends(usercrud.delete_current_user),
        ):
            """Delete the current user."""
            return deleted_user

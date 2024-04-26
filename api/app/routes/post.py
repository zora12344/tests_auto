"""Routes for post."""
from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session

from ..crud import post as postcrud
from ..database import util as database
from ..schema.comment import Comment
from ..schema.post import Post, PostCreate
from ..security import oauth2_scheme


class PostRoutes:
    def __init__(self, api) -> None:
        @api.get("/posts/feed", response_model=list[Post], tags=["post"])
        def read_posts_feed(
            posts_feed: list[Post] = Depends(postcrud.get_user_feed),
        ):
            """Get the current user's posts feed."""
            return posts_feed

        @api.get("/post/search", response_model=list[Post], tags=["post"])
        def search_posts(
            q: str,
            limit: int | None = 10,
            token: str = Depends(oauth2_scheme),
            db: Session = Depends(database.get_db),
        ):
            """Search posts by title."""
            results = []
            if limit < 0:
                raise HTTPException(status_code=400, detail="limit below zero")
            if q:
                results = postcrud.search_posts(
                    token=token, db=db, search=q, limit=limit
                )
            return results

        @api.get(
            "/post/{post_id}/comments",
            response_model=list[Comment],
            tags=["post"],
        )
        def read_post_comments(
            post_comments: list[Comment] = Depends(postcrud.get_post_comments),
        ):
            """Get the post's comments."""
            return post_comments

        @api.post("/post/create", response_model=Post, tags=["post"])
        def create_post(
            post: PostCreate,
            token: str = Depends(oauth2_scheme),
            db: Session = Depends(database.get_db),
        ):
            """Create a new post."""
            return postcrud.create_current_user_post(
                post=post, token=token, db=db
            )

        @api.put("/post/update/{post_id}", response_model=Post, tags=["post"])
        def update_current_user_post(
            post_id: int,
            post: PostCreate,
            token: str = Depends(oauth2_scheme),
            db: Session = Depends(database.get_db),
        ):
            """Update the current user's post."""
            updated_post = postcrud.update_current_user_post(
                post_id=post_id, post=post, token=token, db=db
            )
            return updated_post

        @api.delete(
            "/post/delete/{post_id}", response_model=Post, tags=["post"]
        )
        def delete_current_user_post(
            post_id: int,
            token: str = Depends(oauth2_scheme),
            db: Session = Depends(database.get_db),
        ):
            """Delete the current user's post."""
            deleted_post = postcrud.delete_current_user_post(
                post_id=post_id, token=token, db=db
            )
            return deleted_post

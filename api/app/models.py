"""This module contains the database models."""

from sqlalchemy import (
    DATETIME,
    DECIMAL,
    Boolean,
    Column,
    ForeignKey,
    Integer,
    String,
    Text,
)
from sqlalchemy.orm import relationship

from .database.link import Base


class User(Base):
    """User model used to represent a User in database.

    A user can have multiple posts and comments.
    A post can have only one owner.
    A comment can have only one owner.
    """

    __tablename__ = "user"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(64), unique=True, nullable=False)
    hashed_password = Column(String(64), nullable=False)
    firstname = Column(String(64), nullable=False)
    lastname = Column(String(64), nullable=False)
    is_botanist = Column(Boolean, default=False, nullable=False)

    posts = relationship(
        "Post",
        back_populates="owner",
        foreign_keys="[Post.owner_id]",
        cascade="all, delete, delete-orphan",
    )
    comments = relationship("Comment", cascade="all, delete, delete-orphan")


class Post(Base):
    """Post model used to represent a Post in database.

    A post can have multiple comments.
    A user can have multiple posts.
    """

    __tablename__ = "plant_post"

    id = Column(Integer, primary_key=True, index=True)
    owner_id = Column(
        Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False
    )
    keeper_id = Column(Integer, ForeignKey("user.id"), nullable=True)
    creation_date = Column(DATETIME, nullable=False)
    care_start = Column(DATETIME, nullable=True)
    care_end = Column(DATETIME, nullable=True)
    plant_name = Column(String(64), nullable=False)
    image_url = Column(String(128), nullable=False)
    description = Column(Text, nullable=True)
    latitude = Column(DECIMAL(10, 8), nullable=False)
    longitude = Column(DECIMAL(10, 8), nullable=False)

    comments = relationship(
        "Comment",
        foreign_keys="Comment.post_id",
        cascade="all, delete, delete-orphan",
    )

    owner = relationship(
        "User", foreign_keys=[owner_id], back_populates="posts"
    )


class Comment(Base):
    """Comment model used to represent a Comment in database.

    A comment belongs to one and only one post.
    A post can have multiple comments.
    """

    __tablename__ = "comment"

    id = Column(Integer, primary_key=True, index=True)
    post_id = Column(
        Integer,
        ForeignKey("plant_post.id", ondelete="CASCADE"),
        nullable=False,
    )
    user_id = Column(
        Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False
    )
    posting_date = Column(DATETIME, nullable=False)
    content = Column(String(1024), nullable=True)
    picture = Column(String(255), nullable=True)

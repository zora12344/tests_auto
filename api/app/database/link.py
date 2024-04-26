"""This module is used to connect to the database.

For more details see:
https://fastapi.tiangolo.com/tutorial/sql-databases/?h=sql#install-sqlalchemy
"""

from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

from ..env import SQLALCHEMY_DATABASE_URL

engine = create_engine(SQLALCHEMY_DATABASE_URL)
"""Database engine used to create a session factory."""

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
"""Session factory used to create a session."""

Base = declarative_base()
"""Base class used to create database models."""

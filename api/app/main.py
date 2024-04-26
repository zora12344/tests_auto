"""
This is the main module of the application.
It contains the FastAPI application instance and the routes.
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .database import util
from .env import ORIGINS
from .routes.auth import AuthRoutes
from .routes.comment import CommentRoutes
from .routes.post import PostRoutes
from .routes.user import UserRoutes

util.connect()

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

UserRoutes(app)
PostRoutes(app)
CommentRoutes(app)
AuthRoutes(app)

"""Routes for authentication."""

from datetime import datetime, timedelta

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from jose import jwt
from sqlalchemy.orm import Session

from ..crud.user import authenticate_user
from ..database import util as database
from ..env import (
    ACCESS_TOKEN_EXPIRE_MINUTES,
    JWT_ENCODING_ALGORITHM,
    SECRET_KEY,
)
from ..schema.token import Token


class AuthRoutes:
    def __init__(self, api) -> None:
        def create_access_token(
            data: dict, expires_delta: timedelta | None = None
        ):
            """Create access token and return it."""
            to_encode = data.copy()
            if expires_delta:
                expire = datetime.utcnow() + expires_delta
            else:
                expire = datetime.utcnow() + timedelta(minutes=15)
            to_encode.update({"exp": expire})
            encoded_jwt = jwt.encode(
                to_encode, SECRET_KEY, algorithm=JWT_ENCODING_ALGORITHM
            )
            return encoded_jwt

        @api.post("/token", response_model=Token, tags=["auth"])
        async def login_for_access_token(
            form_data: OAuth2PasswordRequestForm = Depends(),
            db: Session = Depends(database.get_db),
        ):
            """Login and return current user access token and token type."""
            user = authenticate_user(
                form_data.username, form_data.password, db=db
            )
            if not user:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="Incorrect username or password",
                    headers={"WWW-Authenticate": "Bearer"},
                )
            access_token_expires = timedelta(
                minutes=ACCESS_TOKEN_EXPIRE_MINUTES
            )
            access_token = create_access_token(
                data={"sub": user.email}, expires_delta=access_token_expires
            )
            return {"access_token": access_token, "token_type": "bearer"}

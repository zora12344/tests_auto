"""This module contains functions for authentication and authorization."""

from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from passlib.context import CryptContext

from .env import JWT_ENCODING_ALGORITHM, SECRET_KEY
from .exception import CREDENTIALS_EXCEPTION
from .schema.token import TokenData

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
pwd_context = CryptContext(schemes=["argon2"], deprecated="auto")


def verify_password(plain_password, hashed_password):
    """Verify a password against a hash."""
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    """Get a hash of a password."""
    return pwd_context.hash(password)


def get_token_data(token: str):
    """Get the data from a JWT token."""
    try:
        payload = jwt.decode(
            token, SECRET_KEY, algorithms=[JWT_ENCODING_ALGORITHM]
        )
        username: str = payload.get("sub")
        if username is None:
            raise CREDENTIALS_EXCEPTION
        token_data = TokenData(username=username)
    except JWTError as exception:
        raise CREDENTIALS_EXCEPTION from exception
    return token_data

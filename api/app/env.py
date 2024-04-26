"""This module contains the environment variables for the application."""

SECRET_KEY = "ad938e8363f3f46075853612c802020ec5ce25af7fa4c4131a17b36029c1b1c1"
"""Secret key used for authentication and authorization.

This key should be kept secret in production.

To generate a new secret key, run the following command: `openssl rand -hex 32`
"""

JWT_ENCODING_ALGORITHM = "HS256"
"""Algorithm used to encode JWT tokens.

For a list of supported algorithms see:
https://pyjwt.readthedocs.io/en/stable/algorithms.html.
"""

ACCESS_TOKEN_EXPIRE_MINUTES = 30
"""Expiration time of access tokens in minutes."""

SQLALCHEMY_DATABASE_URL = "mysql+mysqldb://user:password@mysqldb:3306/db"
"""URL used to connect to the database.

The URL is in the form `dialect+driver://username:password@host:port/database`.
For more information see:
https://docs.sqlalchemy.org/en/14/core/engines.html#database-urls.

The URL is passed to SQLAlchemy to create the database engine.
The database engine is used to create a session factory.
The session factory is used to create a session.
The session is used to query the database.
"""

ORIGINS = ["http://localhost:4200", "https://localhost:4200"]
"""
Allow CORS origin requests for frontend apps.

This is a security measure to prevent cross-site scripting attacks.
The frontend app will run on port 4200 during development.
See https://fastapi.tiangolo.com/tutorial/cors/ for more information.

## NOTE

In order to improve security, we should do the following:

    - Change the origins to the frontend app's URL in production.
"""

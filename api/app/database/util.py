"""This module contains functions to connect to the database.

For more details see:
https://fastapi.tiangolo.com/tutorial/sql-databases/?h=sql#install-sqlalchemy
"""

import time

from .. import models
from .link import SessionLocal, engine


def connect():
    """Try to connect to the database.

    If the connection fails, wait 5 seconds before trying again.
    Try 10 times.

    This is used to tolerate nework problems and database startup.

    # TODO

    In order to improve this, we should do the following:

        - Use an environment variable to configure the number of attempts.
        - Use an environment variable to configure the delay between attempts.
    """

    for attempt in range(0, 10):
        success = False
        try:
            models.Base.metadata.create_all(bind=engine)
            success = True
        except Exception:
            print(
                f"Fail to connect to the database (attempt {attempt})",
                flush=True,
            )
            time.sleep(5)

        if success:
            print("Connection to the database established", flush=True)
            break


def get_db():
    """Create a new session to the database.

    The session is used to query the database.
    The session is closed after the request is finished.
    For more information see:
    https://fastapi.tiangolo.com/tutorial/sql-databases/?h=sql#create-a-dependency.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

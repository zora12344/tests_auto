"""This module is used to handle database shutdown after tests."""
from os import environ

import pymysql

from ..database.link import engine


def pytest_sessionfinish(session, exitstatus):
    """This funciton is used to handle database shutdown after tests.
    Used to avoid infinite running in CI."""
    stop_database = environ.get("STOP_DATABASE_AFTER_TESTS") == "true"
    if not stop_database:
        return
    engine.dispose()

    try:
        conn = pymysql.connect(
            host="mysqldb", port=3306, user="root", passwd="password", db="db"
        )
        cursor = conn.cursor()
        cursor.execute("SHUTDOWN")
        conn.commit()
        conn.close()
    except pymysql.err.OperationalError as e:
        print(f"{e}: Database shutdown")

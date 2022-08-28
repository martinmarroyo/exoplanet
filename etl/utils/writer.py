"""Functions used to write data to the database"""
import logging
import pandas as pd
import sqlalchemy as sql
import psycopg2
from psycopg2 import OperationalError
from psycopg2.extensions import AsIs

logging.basicConfig(level=logging.NOTSET)
logger = logging.getLogger("writer")
filehandler = logging.FileHandler("logs/etl.log")
formatter = logging.Formatter("%(asctime)s: %(levelname)s|%(name)s: %(message)s")
filehandler.setFormatter(formatter)
logger = logging.getLogger("writer")
logger.addHandler(filehandler)
logger.setLevel(logging.INFO)

def db_connection(
    user: str, password: str, host: str, port: int, dbname: str
    ) -> psycopg2.connect:
    """
    Returns a Connection object for the
    specified server
    """
    try:
        connection = psycopg2.connect(
            user=user, password=password, host=host, port=port, dbname=dbname
        )
        return connection
    except (KeyError, OperationalError):
        logging.exception("Error occurred while connecting to database...")
        raise


def start_engine(config:dict) -> sql.engine:
    """Returns a SQLAlchemy engine based on the provided config"""
    # If we're testing, then use SQLite as DB Engine
    if config["TEST_DB"]:
        connection_str = "sqlite://"
    else:
        connection_str = (
            f"{config['DIALECT']}+{config['DRIVER']}://{config['USER']}"
            + f":{config['PASS']}@{config['HOST']}"
            + f":{config['PORT']}/{config['DB_NAME']}"
        )
    engine = sql.create_engine(connection_str)
    return engine


def table_exists(engine:sql.engine, table:str) -> bool:
    """Checks if the given table exists based on the given engine"""
    try:
        inspector = sql.inspect(engine)
        return inspector.has_table(table)
    except Exception as e:
        logging.exception("Error occurred while inspecting database...")


def source_is_empty(config:dict, engine:sql.engine) -> bool:
    """Checks if the source table is empty and returns True if so, False otherwise"""
    source_df = pd.read_sql(
        "SELECT COUNT(*) AS ct FROM %s", engine, params=(AsIs(config['SOURCE_NAME']),)
    )
    return source_df["ct"][0] <= 0


def write_to_db(
    engine:sql.engine, 
    data:pd.DataFrame, 
    table_name:str
    ) -> int:
    """
    Writes the given data to the database configured by the engine. Optionally, 
    you can set this to be an update to just append records rather than overwrite 
    the entire table
    """
    try:
        data.to_sql(
            table_name,
            engine,
            index=False,
            if_exists="append"
        )
        return 0
    except Exception as e:
        logging.exception("An error occurred while writing to the database...")        
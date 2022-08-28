"""A script to initialize the Extrasolar Planet Encyclopedia Analysis data warehouse"""
import sys
import logging
import yaml
import psycopg2
from psycopg2 import OperationalError
from yaml.loader import SafeLoader
from glob import glob

logging.basicConfig(
    handlers=[
        logging.FileHandler("logs/warehouse.log"),
        logging.StreamHandler(sys.stdout),
    ],
    level=logging.INFO,
    format="%(asctime)s  - %(levelname)s: %(message)s",
    encoding="UTF-8"
)
with open("config.yml", "r", encoding="UTF-8") as file:
    CONFIG = yaml.load(file, Loader=SafeLoader)

def get_queries(path:str) -> str:
    """Gets files at given path and stitches them together into a single query string"""
    func_paths = glob(path)
    files = []
    for file in func_paths:
        with open(file, "r", encoding="UTF-8") as f:
            files.append(f.read())
    query = "\n".join(files)
    return query


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


def initialize_db(config:dict):
    """Runs DDL queries to initialize database tables, functions, and metadata"""
    try:
        # Get database connection from config
        with db_connection(
            user=config["USER"],
            password=config["PASS"],
            host=config["HOST"],
            port=config["PORT"],
            dbname=config["DB_NAME"]
        ) as conn:
            with conn.cursor() as cur:
                # Create tables
                logging.info("Creating tables...")
                table_query = get_queries("table/*.sql")
                cur.execute(table_query)
                # Create functions
                logging.info("Creating functions...")
                func_query = get_queries("function/*.sql")
                cur.execute(func_query)
                # Add metadata
                logging.info("Adding metadata...")
                cur.execute("SELECT write_metadata();")
        return 0
    except (KeyError, OperationalError):
        logging.exception("An error occurred while initializing the database...")
        raise


def main():
    """Driver function to initalize the database"""
    initialize_db(CONFIG)


if __name__ == '__main__':
    logging.info("Initializing database...")
    main()
    logging.info("Database initialized!")  
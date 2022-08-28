"""Functions that support data warehouse transformations for Exoplanet data"""
import logging
import psycopg2
from utils import writer

logging.basicConfig(level=logging.NOTSET)
logger = logging.getLogger("transform")
filehandler = logging.FileHandler("logs/etl.log")
formatter = logging.Formatter("%(asctime)s: %(levelname)s|%(name)s: %(message)s")
filehandler.setFormatter(formatter)
logger = logging.getLogger("transform")
logger.addHandler(filehandler)
logger.setLevel(logging.INFO)

def create_or_update_dimensions(connection:psycopg2.connect) -> int:
    """Runs functions that update the dimension tables"""
    try:
        logger.info("Updating dimension tables...")
        with connection.cursor() as cur:
            cur.execute("SELECT update_dim_exoplanet();")
            cur.execute("SELECT update_dim_star();")
        logger.info("Dimension tables have been updated!")
        return 0
    except Exception as e:
        logger.exception("An error occurred while updating the dimensions...")
        raise


def create_or_insert_facts(connection:psycopg2.connect) -> int:
    """Runs functions that insert facts into fact tables"""
    try:
        logger.info("Adding facts to fact table(s)...")
        with connection.cursor() as cur:
            cur.execute("SELECT insert_fact_observation();")
        logger.info("Facts have been added to fact table(s)!")
        return 0
    except Exception as e:
        logger.exception("An error occurred while adding facts...")
        raise


def transform(config:dict) -> int:
    """Updates or creates dimension tables and adds facts to fact tables"""
    try:
        with writer.db_connection(
            user=config["USER"],
            password=config["PASS"],
            host=config["HOST"],
            port=config["PORT"],
            dbname=config["DB_NAME"]
        ) as conn:
            # Update dimensions
            create_or_update_dimensions(conn)
            # Add facts
            create_or_insert_facts(conn)
            return 0
    except Exception as e:
        logger.exception("An error occurred during data transformations...")
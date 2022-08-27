"""Functions used to write data to the database"""
import sys
import logging
import pandas as pd
import sqlalchemy as sql

logging.basicConfig(
    handlers=[logging.StreamHandler(sys.stdout)]
)
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
        
        
def write_to_db(
    engine:sql.engine, 
    data:pd.DataFrame, 
    table_name:str, 
    update:bool=False
    ) -> int:
    """
    Writes the given data to the database configured by the engine. Optionally, 
    you can set this to be an update to just append records rather than overwrite 
    the entire table
    """
    write_mode = "append" if update else "replace"
    try:
        data.to_sql(
            table_name,
            engine,
            index=False,
            if_exists=write_mode
        )
        return 0
    except Exception as e:
        logging.exception("An error occurred while writing to the database...")        
"""Functions that ingest data from the Extrasolar Planets Encyclopedia API"""
import pyvo
import pandas as pd
import sqlalchemy as sql
from hashlib import md5
from utils import writer
from datetime import datetime

def get_data(url:str, query:str) -> pd.DataFrame:
    """
    Downloads exoplanet data from the Extrasolar Planets Encyclopedia API 
    and returns it as a DataFrame
    """
    # Download the data
    service = pyvo.dal.TAPService(url)
    raw_data = service.search(query)
    # Convert to DataFrame and add change hash
    data = raw_data.to_table().to_pandas()
    data["uuid"] = data.apply(generate_uuid, axis=1)
    # Add load date
    data["load_date"] = datetime.today()
    data["load_date"] = pd.to_datetime(data["load_date"]).dt.date
    # Drop duplicates
    data.drop_duplicates(subset="uuid", keep="last", inplace=True)
    return data


def generate_uuid(row):
    """
    Generates a unique user id (uuid) comprised 
    of metadata columns to uniquely identify records
    """
    uid = row["granule_uid"]
    gid = row["granule_gid"]
    oid = str(row["obs_id"])
    pid = row["dataproduct_type"]
    uuid = ("".join([uid, gid, oid, pid])).encode("utf-8")
    return md5(uuid).hexdigest()


def get_source_uuids(engine:sql.engine, source_name:str) -> pd.DataFrame:
    """Gets the uuids from the source table and returns them as a Pandas Series"""
    query = f"SELECT uuid FROM {source_name}"
    uuids = pd.read_sql(query, engine)
    return uuids["uuid"]
    

def extract_updates(raw_data:pd.DataFrame, source_uuids:pd.Series) -> pd.DataFrame:
    """Identifies new records from raw data based on uuid and returns them in a DataFrame"""
    updates = raw_data.copy()
    updates["in_source"] = updates["uuid"].isin(source_uuids)
    updates = updates[updates["in_source"] == False]
    updates.drop(columns="in_source")
    return updates


def ingest(config:dict, engine:sql.engine) -> int:
    """Loads raw data into Exoplanet database table"""
    # Start the database engine & set up raw data
    raw_data = get_data(config["API_ENDPOINT"], config["API_QUERY"])
    destination = config["SOURCE_NAME"]
    # Check whether we are updating or doing an initial load
    is_update = writer.table_exists(engine, destination)
    # If we have an update, then extract the new records (if any)
    inserts = raw_data.copy()
    if is_update:
        # Get uuids from source data
        source_uuids = get_source_uuids(engine, destination)
        # Extract new records only
        inserts = extract_updates(inserts, source_uuids)
    # Write to database
    result = writer.write_to_db(
        engine, inserts, destination, is_update
    )
    return result

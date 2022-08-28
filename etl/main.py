"""A pipeline to extract, process, store, and visualize Exoplanet data from the Extrasolar Planet Encyclopedia"""
import sys
import logging
import yaml
from yaml.loader import SafeLoader
from utils import ingestion as ig
from utils import writer
from utils import transform as tf

# Set up logging and config file
logging.basicConfig()
filehandler = logging.FileHandler("logs/etl.log")
formatter = logging.Formatter("%(asctime)s: %(levelname)s|%(name)s: %(message)s")
filehandler.setFormatter(formatter)
logger = logging.getLogger("main")
logger.addHandler(filehandler)
logger.setLevel(logging.INFO)
with open("config.yml", "r", encoding="utf-8") as file:
    CONFIG = yaml.load(file, Loader=SafeLoader)

def main():
    # Start the database engine & ingest the data
    engine = writer.start_engine(CONFIG)
    ig.ingest(CONFIG, engine)
    tf.transform(CONFIG)
    # Return the engine if we're testing to inspect database
    if CONFIG["TEST_DB"]:
        return engine


if __name__ == '__main__':
    logger.info("Beginning data ingestion from Extrasolar Planet Encyclopedia API")
    main()
    logger.info("Ingestion complete!")


"""A pipeline to extract, process, store, and visualize Exoplanet data from the Extrasolar Planet Encyclopedia"""
import sys
import logging
import yaml
from yaml.loader import SafeLoader
from etl import ingestion as ig
from etl import writer

def main():
    # Set up loggin and config file
    logging.basicConfig(
        handlers=[logging.StreamHandler(sys.stdout)],
        level=logging.INFO,
        format="%(asctime)s - %(level)s: %(message)s",
        encoding="UTF-8"
    )
    with open("config.yml", "r", encoding="utf-8") as file:
        config = yaml.load(file, Loader=SafeLoader)
    # Start the database engine & ingest the data
    engine = writer.start_engine(config)
    ig.ingest(config, engine)
    # Return the engine if we're testing to inspect database
    if config["TEST_DB"]:
        return engine


if __name__ == '__main__':
    main()

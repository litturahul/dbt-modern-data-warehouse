import os
import pandas as pd
from sqlalchemy import create_engine

db_url = "postgresql+psycopg2://username:password@localhost:5432/database_name"

def load_parquet_to_postgres(db_url, table_name, parquet_file_path):
    """    Load a parquet file from the specified root directory into a PostgreSQL database.
    Args:
        db_url (str): The database URL for the PostgreSQL database.
        table_name (str): The name of the table to load the data into.
        parquet_file_path (str): The file path where the parquet file is located.
    """
    try:    
        parquet_data = pd.read_parquet(parquet_file_path)
        engine = create_engine(db_url)
        parquet_data.to_sql(table_name, engine, if_exists='append', index=False)
        print(f"Loaded parquet: {parquet_file_path} into {table_name} table.")
    except Exception as e:
        print(f"Error loading parquet file {parquet_file_path} into {table_name}: {e}")

def find_and_load_parquet_files(root_dir):
    """
    Prints the parent-parent folder name and parquet file path for each .parquet file found.
    Args:
        root_dir (str): The root directory to search for parquet files.
    """
    for subdir, _, files in os.walk(root_dir):
        # Only consider folders named 'data'
        if os.path.basename(subdir) == "data":
            for file in files:
                if file.endswith('.parquet'):
                    file_path = os.path.join(subdir, file)
                    # Get parent-parent folder name
                    parent_parent = os.path.basename(os.path.dirname(os.path.dirname(file_path)))
                    print("-" * 50)
                    print(f"table_name: {parent_parent}, parquet_data: {file_path}")
                    load_parquet_to_postgres(db_url, parent_parent, file_path)
                    print("-" * 50)

def main():
    print("Hello from dbt-modern-data-warehouse!")
    find_and_load_parquet_files('marketing_data/fivetran_data/')

if __name__ == "__main__":
    main()
    

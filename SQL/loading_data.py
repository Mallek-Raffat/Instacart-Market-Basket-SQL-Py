import pandas as pd
from sqlalchemy import create_engine
import urllib

# ==========================
# SQL Server Connection
# ==========================

params = urllib.parse.quote_plus(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=localhost\\SQLEXPRESS;"
    "DATABASE=Instacart;"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)

engine = create_engine(
    f"mssql+pyodbc:///?odbc_connect={params}",
    fast_executemany=True
)

# ==========================
# Dataset Path
# ==========================

DATA_PATH = r"D:\data science\Project\Instacart Market Basket Analysis\Datasets"

# ==========================
# Small Tables
# ==========================

small_tables = {
    "departments": "departments.csv",
    "aisles": "aisles.csv",
    "products": "products.csv",
    "orders": "orders.csv"
}

for table, file in small_tables.items():

    print(f"Importing {table}...")

    df = pd.read_csv(f"{DATA_PATH}\\{file}")

    df.to_sql(
        name=table,
        con=engine,
        if_exists="append",   # الجدول موجود بالفعل
        index=False
    )

    print(f"{table} imported successfully.")

# ==========================
# Large Tables
# ==========================

large_tables = {
    "order_products_prior": "order_products__prior.csv",
    "order_products_train": "order_products__train.csv"
}

for table, file in large_tables.items():

    print(f"Importing {table}...")

    for chunk in pd.read_csv(
        f"{DATA_PATH}\\{file}",
        chunksize=100000
    ):

        chunk.to_sql(
            name=table,
            con=engine,
            if_exists="append",
            index=False
        )

    print(f"{table} imported successfully.")

print("\nAll tables imported successfully!")
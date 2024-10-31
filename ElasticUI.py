import mysql.connector
from elasticsearch import Elasticsearch
import time

# MySQL connection details
mysql_config = {
    'user': 'root',
    'password': 'siddis',
    'host': 'localhost',
    'database': 'mybasket'
}

# Elasticsearch connection details
es = Elasticsearch(['https://localhost:9200'], http_auth=('elastic', 'L6PMd7exD+J14oPCY7H3'), verify_certs=False)

def fetch_products_mysql():
    # Connect to MySQL
    connection = mysql.connector.connect(**mysql_config)
    cursor = connection.cursor(dictionary=True)

    # Query to fetch all products
    cursor.execute("SELECT * FROM Product where catid=3")
    products = cursor.fetchall()

    # Close MySQL connection
    cursor.close()
    connection.close()
    
    return products

def fetch_products_elasticsearch():
    # Query to fetch all products from Elasticsearch
    response = es.search(index='mybasket_product', body={
        "query": {
            "match": {
                "catid":3
            }
        },
        "size": 6000  # Adjust this if you expect more than 10,000 products
    })

    return [hit['_source'] for hit in response['hits']['hits']]

# Measure time taken to retrieve products from MySQL
start_time_mysql = time.time()
mysql_products = fetch_products_mysql()
end_time_mysql = time.time()
mysql_time = end_time_mysql - start_time_mysql

# Measure time taken to retrieve products from Elasticsearch
start_time_es = time.time()
es_products = fetch_products_elasticsearch()
end_time_es = time.time()
es_time = end_time_es - start_time_es

# Print the results
print(f"Time taken to retrieve products from MySQL: {mysql_time:.4f} seconds")
print(f"Number of products retrieved from MySQL: {len(mysql_products)}")

print(f"Time taken to retrieve products from Elasticsearch: {es_time:.4f} seconds")
print(f"Number of products retrieved from Elasticsearch: {len(es_products)}")

# Optionally compare the two products
if len(mysql_products) == len(es_products):
    print("The number of products retrieved from both sources is the same.")
else:
    print("The number of products retrieved from both sources is different.")

import mysql.connector
import time
from elasticsearch import Elasticsearch

# MySQL configuration and connection
mysql_config = {
    'user': 'root',
    'password': 'siddis',
    'host': 'localhost',
    'database': 'mybasket'
}
mysql_conn = mysql.connector.connect(**mysql_config)
mysql_cursor = mysql_conn.cursor()

# Elasticsearch connection configuration
es = Elasticsearch(['https://localhost:9200'], http_auth=('elastic', 'L6PMd7exD+J14oPCY7H3'), verify_certs=False)

# Function to measure MySQL query time
def time_mysql_query(query):
    start_time = time.time()
    mysql_cursor.execute(query)
    results = mysql_cursor.fetchall()
    end_time = time.time()
    return end_time - start_time, len(results)

# Function to measure Elasticsearch query time
def time_es_query(index, es_query):
    start_time = time.time()
    results = es.search(index=index, body=es_query)
    end_time = time.time()
    return end_time - start_time, results['hits']['total']['value']

# Query examples
queries = {
    "customer_by_fname": {
        "mysql": "SELECT * FROM customer WHERE fname = 'John'",
        "es_index": "mybasket_customer",
        "es_query": {
            "query": {
                "term": {
                    "fname.keyword": "John"
                }
            }
        }
    },
    "product_price_range": {
        "mysql": "SELECT * FROM product WHERE price BETWEEN 100 AND 500",
        "es_index": "mybasket_product",
        "es_query": {
            "query": {
                "range": {
                    "price": {
                        "gte": 100,
                        "lte": 500
                    }
                }
            }
        }
    },
    "product_quantity_range": {
        "mysql": "SELECT * FROM product WHERE quantity BETWEEN 10000 AND 13000",
        "es_index": "mybasket_product",
        "es_query": {
            "query": {
                "range": {
                    "quantity": {
                        "gte": 10000,
                        "lte": 13000
                    }
                }
            }
        }
    },
    "product_quantity_int": {
        "mysql": "SELECT * FROM product WHERE quantity =14842",
        "es_index": "mybasket_product",
        "es_query": {
            "query": {
                "term": {
                "quantity": {
                    "value": 14842
                }
                }
            }
        }
    },
    
}

# Run and compare queries
for name, query in queries.items():
    
    # MySQL
    mysql_time, mysql_len = time_mysql_query(query["mysql"])
    # Elasticsearch
    es_time, es_len = time_es_query(query["es_index"], query["es_query"])
    
    print(f'Running ---------------------------------{query["mysql"]}\n{query["es_index"]}\n{query["es_query"]} ')
    print(f"  MySQL: {mysql_time:.4f} seconds, Result length: {mysql_len}")
    print(f"  Elasticsearch: {es_time:.4f} seconds, Result length: {es_len}\n")

# Close MySQL connection
mysql_cursor.close()
mysql_conn.close()

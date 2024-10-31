import mysql.connector
import time

# Database configuration
db_config = {
    'user': 'root',
    'password': 'siddis',
    'host': 'localhost',
    'database': 'mybasket'
}

# Connect to MySQL database
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

def time_query(query, params=()):
    start_time = time.time()
    cursor.execute(query, params)
    results = cursor.fetchall()
    end_time = time.time()
    execution_time = end_time - start_time
    result_length = len(results)
    return execution_time, result_length

# List of queries and indexes to create for optimization
queries = [
    ("SELECT * FROM Product WHERE price = 500", "CREATE INDEX idx_price ON Product(price)", "DROP INDEX idx_price ON Product"),
    ("SELECT * FROM Product WHERE pid = 90000", "CREATE INDEX idx_pid ON Product(pid)", "DROP INDEX idx_pid ON Product"),
    ("SELECT * FROM Product WHERE quantity = 4000 or quantity =5000", "CREATE INDEX idx_quantity ON Product(quantity)", "DROP INDEX idx_quantity ON Product"),
    ("SELECT * FROM Customer WHERE fname =  or quantity =5000", "CREATE INDEX idx_quantity ON Product(quantity)", "DROP INDEX idx_quantity ON Product"),
    ("SELECT * FROM deliveryboy WHERE rating = 5", "CREATE INDEX idx_db_rating ON deliveryboy(rating)", "DROP INDEX idx_db_rating ON deliveryboy"),
    ("SELECT * FROM cart WHERE status = 'not delivered'", "CREATE INDEX idx_cart_status ON cart(status)", "DROP INDEX idx_cart_status ON cart"),
    ("SELECT * FROM Product WHERE quantity > 10", "CREATE INDEX idx_quantity ON Product(quantity)", "DROP INDEX idx_quantity ON Product"),
]

# Run each query without and with index, and print the times and result lengths
for query, create_index, drop_index in queries:
    # Drop the index if it already exists (to reset the state)
    try:
        cursor.execute(drop_index)
        conn.commit()
    except mysql.connector.Error:
        pass  # Ignore errors if index doesn't exist
    print(query)
    # Measure query time and result length without index
    no_index_time, no_index_length = time_query(query)
    print(f"time without index : {no_index_time:.4f} seconds, Result length: {no_index_length}")

    # Add the index and measure query time with index
    cursor.execute(create_index)
    conn.commit()

    with_index_time, with_index_length = time_query(query)
    print(f"time with index ': {with_index_time:.4f} seconds, Result length: {with_index_length}\n")

    # Drop the index after testing
    cursor.execute(drop_index)
    conn.commit()
cursor.close()
conn.close()

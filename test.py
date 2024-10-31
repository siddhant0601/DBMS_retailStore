import mysql.connector
import time

# Database configuration
db_config = {
    'user': 'root',
    'password': 'siddis',
    'host': 'localhost',
    'database': 'mybasketindexdemo'
}

# Connect to MySQL database
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

# Check if the index exists, and drop it if it does
cursor.execute("""
    SELECT COUNT(1) 
    FROM information_schema.STATISTICS 
    WHERE table_schema = 'mybasketindexdemo' 
    AND table_name = 'products' 
    AND index_name = 'idx_price'
""")
index_exists = cursor.fetchone()[0]

if index_exists:
    cursor.execute("DROP INDEX idx_price ON products")
    conn.commit()
    print("Index 'idx_price' dropped.")

# Define a function to measure query time
def time_query(query, params=()):
    start_time = time.time()
    cursor.execute(query, params)
    cursor.fetchall()
    end_time = time.time()
    return end_time - start_time

# Query to run
query = "SELECT * FROM products WHERE price = 500"

# Test query time without index
no_index_time = time_query(query)
print(f"Query time without index: {no_index_time:.4f} seconds")

# Add an index on the price column
cursor.execute("CREATE INDEX idx_price ON products(price)")
conn.commit()
print("Index 'idx_price' created.")

# Test query time with index
with_index_time = time_query(query)
print(f"Query time with index: {with_index_time:.4f} seconds")

# Clean up: Remove the index after testing if desired
# cursor.execute("DROP INDEX idx_price ON products")
# conn.commit()

# Close connection
cursor.close()
conn.close()

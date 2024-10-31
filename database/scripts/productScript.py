import random
import csv
from faker import Faker

# Initialize Faker
fake = Faker()

# Define the number of entries
num_entries = 100000

# Prepare the output CSV file for products
with open('products.csv', 'w', newline='') as csvfile:
    fieldnames = ['name', 'catid', 'rid', 'manufacturingDate', 'rating', 'quantity', 'price']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # Write the header
    writer.writeheader()

    for _ in range(num_entries):
        # Generate random data for the Product table
        name = fake.word() 
        catid = random.randint(1, 16)  # Assuming categories are numbered from 1 to 10
        rid = random.randint(1, 29999)  # Assuming retailer IDs are from 1 to 1000
        manufacturingDate = fake.date_this_decade().strftime("%Y-%m-%d")  # Format date as YYYY-MM-DD
        rating = random.randint(0, 5)  # Rating from 0 to 5
        quantity = random.randint(5000, 50000)  # Random quantity
        price = random.randint(100, 30000)  # Random price between 10 and 1000

        # Write to CSV
        writer.writerow({
            'name': name,
            'catid': catid,
            'rid': rid,
            'manufacturingDate': manufacturingDate,
            'rating': rating,
            'quantity': quantity,
            'price': price
        })

print(f"Generated {num_entries} entries in 'products.csv'.")

# Prepare SQL Insert statements
with open('products.csv', 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    sql_statements = []
    for row in reader:
        sql = f"INSERT INTO Product (name, catid, rid, manufacturingDate, rating, quantity, price) VALUES ('{row['name']}', {row['catid']}, {row['rid']}, '{row['manufacturingDate']}', {row['rating']}, {row['quantity']}, {row['price']});"
        sql_statements.append(sql)

# Write SQL insert statements to a file
with open('insert_products.sql', 'w') as f:
    for statement in sql_statements:
        f.write(statement + '\n')

print("SQL insert statements generated in 'insert_products.sql'.")

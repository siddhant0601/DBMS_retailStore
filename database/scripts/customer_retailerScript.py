import random
import csv
from faker import Faker

# Initialize Faker
fake = Faker()

# Define the number of entries
num_entries = 50000

# Prepare the output CSV file
with open('customers.csv', 'w', newline='') as csvfile:
    fieldnames = ['fname', 'mname', 'email', 'password', 'number']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # Write the header
    writer.writeheader()

    for _ in range(num_entries):
        # Generate random data
        fname = fake.first_name()  # First name
        mname = fake.first_name()  # Generate a random middle name
        email = fake.unique.email()
        password = fake.password()
        number = fake.unique.phone_number()
        
        # Write to CSV
        writer.writerow({'fname': fname, 'mname': mname, 'email': email, 'password': password, 'number': number})

print(f"Generated {num_entries} entries in 'customers.csv'.")

# Prepare SQL Insert statements
with open('customers.csv', 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    sql_statements = []
    for row in reader:
        sql = f"INSERT INTO Customer (fname, mname, email, password, number) VALUES ('{row['fname']}', '{row['mname']}', '{row['email']}', '{row['password']}', '{row['number']}');"
        sql_statements.append(sql)

with open('insert_customers.sql', 'w') as f:
    for statement in sql_statements:
        f.write(statement + '\n')

print("SQL insert statements generated in 'insert_customers.sql'.")

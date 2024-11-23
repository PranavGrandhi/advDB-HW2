import csv
import random

# File names
uniform_file = 'uniform_data_thumb2.csv'
skewed_file = 'skewed_data_thumb2.csv'

# Total records
num_records = 10_000_000

# Generate uniform distribution CSV
print("Generating uniform distribution data...")
with open(uniform_file, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow(['id', 'user_id'])  # Header
    for i in range(1, num_records + 1):
        user_id = random.randint(1, 1_000_000)  # Uniform distribution
        writer.writerow([i, user_id])

print("Uniform data generation completed.")

# Generate skewed distribution CSV
print("Generating skewed distribution data...")
with open(skewed_file, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow(['id', 'category_id'])  # Header
    for i in range(1, num_records + 1):
        rand = random.random()
        if rand < 0.7:
            category_id = random.randint(1, 5)  # 70% in 1-5
        elif rand < 0.9:
            category_id = random.randint(6, 15)  # 20% in 6-15
        else:
            category_id = random.randint(16, 1_000)  # 10% in 16-1000
        writer.writerow([i, category_id])

print("Skewed data generation completed.")
import csv
import random
from tqdm import tqdm
import time

input_file = "./fractal_distribution.txt"
with open(input_file, "r") as file:
    lines = file.readlines()
    fractal_distribution = list(map(int, lines[0].split()))

num_trades = 10000000
quantity_range = (100, 10000)
price_range = (50, 500)

last_prices = {}  # Keep track of the last price of each stock
trades = []

start_time = time.time()

for time_stamp in tqdm(range(1, num_trades + 1)):
    stock_symbol = f"s{random.choice(fractal_distribution)}" # Randomly select a stock symbol and add s prefix
    quantity = random.randint(*quantity_range)

    last_price = last_prices.get(stock_symbol, random.randint(*price_range))
    price_change = random.randint(1, 5)
    new_price = min(max(last_price + random.choice([-1, 1]) * price_change, price_range[0]), price_range[1])
    last_prices[stock_symbol] = new_price
    
    trades.append((stock_symbol, time_stamp, quantity, new_price))

end_time = time.time()
elapsed_time = end_time - start_time
print(f"Time taken to generate {num_trades} trades: {elapsed_time:.2f} seconds")

output_file = "./trades.csv"
with open(output_file, "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["stocksymbol", "time", "quantity", "price"])  # Header
    writer.writerows(trades)

print(f"Trade table with {num_trades} rows has been written to {output_file}.")

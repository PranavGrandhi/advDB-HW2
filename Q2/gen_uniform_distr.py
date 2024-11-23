import csv
import random
from tqdm import tqdm
import time

num_stocks = 70000 
uniform_distribution = [f"s{i}" for i in range(1, num_stocks + 1)] 

num_trades = 10000000
quantity_range = (100, 10000)
price_range = (50, 500)

last_prices = {} 
trades = []

start_time = time.time()

for time_stamp in tqdm(range(1, num_trades + 1)):
    stock_symbol = random.choice(uniform_distribution)  
    quantity = random.randint(*quantity_range)

    last_price = last_prices.get(stock_symbol, random.randint(*price_range))
    price_change = random.randint(1, 5)
    new_price = min(max(last_price + random.choice([-1, 1]) * price_change, price_range[0]), price_range[1])
    last_prices[stock_symbol] = new_price
    
    trades.append((stock_symbol, time_stamp, quantity, new_price))

end_time = time.time()
elapsed_time = end_time - start_time
print(f"Time taken to generate {num_trades} trades: {elapsed_time:.2f} seconds")

# Write to CSV
output_file = "./uniform_trades.csv"
with open(output_file, "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["stocksymbol", "time", "quantity", "price"])  # Header
    writer.writerows(trades)

print(f"Trade table with {num_trades} rows has been written to {output_file}.")

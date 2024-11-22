import pandas as pd
import time
import csv

#Load Data
start_time = time.time()
trade = pd.read_csv('trades.csv')
end_time = time.time()
elapsed_time = end_time - start_time
print(f"Time taken to load trades csv {elapsed_time:.2f} seconds")

#Query A
start_time = time.time()

query_a = (
    trade
    .groupby('stocksymbol')
    .apply(lambda x: (x["quantity"] * x["price"]).sum() / x["quantity"].sum())
    .reset_index(name="weighted_average")
)

end_time = time.time()
elapsed_time = end_time - start_time
print(f"Time taken for Query A {elapsed_time:.2f} seconds")
print("Saved to query_a.csv")
query_a.to_csv('query_a.csv', index=False)

#Query B
start_time = time.time()

trade_sorted = trade.sort_values(by=['stocksymbol', 'time'])
window_size = 10
trade_sorted["unweighted_moving_average"] = (
    trade_sorted.groupby("stocksymbol")["price"]
    .transform(lambda x: x.rolling(window=window_size, min_periods=1).mean())
)

query_b = (
    trade_sorted.groupby("stocksymbol")["unweighted_moving_average"]
    .apply(lambda x: " ".join(map(lambda y: f"{y:.2f}", x)))
    .reset_index(name="unweighted_moving_averages")
)

end_time = time.time()
elapsed_time = end_time - start_time
print(f"Time taken for Query B {elapsed_time:.2f} seconds")
print("Saved to query_b.csv")
query_b.to_csv("query_b.csv", index=False)

#Query C
start_time = time.time()

def weighted_moving_average(price, quantity, window):
    weighted_sum = (price * quantity).rolling(window=window, min_periods=1).sum()
    weight_sum = quantity.rolling(window=window, min_periods=1).sum()
    return weighted_sum / weight_sum

trade_sorted["weighted_moving_average"] = (
    trade_sorted.groupby("stocksymbol")
    .apply(lambda x: weighted_moving_average(x["price"], x["quantity"], window_size))
    .reset_index(level=0, drop=True)
)

query_c = (
    trade_sorted.groupby("stocksymbol")["weighted_moving_average"]
    .apply(lambda x: " ".join(map(lambda y: f"{y:.2f}", x)))
    .reset_index(name="weighted_moving_averages")
)

end_time = time.time()
elapsed_time = end_time - start_time
print(f"Time taken for Query C {elapsed_time:.2f} seconds")
print("Saved to query_c.csv")
query_c.to_csv("query_c.csv", index=False)

#Query D
start_time = time.time()

def best_profit(prices):
    min_price = float("inf")
    max_profit = 0

    for price in prices:
        min_price = min(min_price, price)  
        max_profit = max(max_profit, price - min_price) 

    return max_profit

query_d = (
    trade_sorted.groupby("stocksymbol")["price"]
    .apply(best_profit)
    .reset_index(name="best_profit")
)

end_time = time.time()
elapsed_time = end_time - start_time
print(f"Time taken for Query D {elapsed_time:.2f} seconds")
print("Saved to query_d.csv")
query_d.to_csv("query_d.csv", index=False)

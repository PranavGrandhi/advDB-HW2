import csv
import random

input_file = "./fractal_distribution.txt"
with open(input_file, "r") as file:
    lines = file.readlines()
    fractal_distribution = list(map(int, lines[1].split()))

num_trades = 10000000
quantity_range = (100, 10000)
price_range = (50, 500)
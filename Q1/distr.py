import random

def gen(frac, N):
    p = random.sample(range(1, N + 1), N)
    outvec = p[:]

    while len(p) > 1:
        new_size = int(len(p) * frac)  # Round down
        p = p[:new_size]
        outvec = p + outvec

    return random.sample(outvec, len(outvec))


frac = 0.3  
N = 70000       
result = gen(frac, N)

file_path = "./fractal_distribution.txt"
with open(file_path, "w") as file:
    file.write(" ".join(map(str, result)))
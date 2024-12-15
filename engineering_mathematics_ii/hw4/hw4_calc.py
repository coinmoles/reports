import math

n = 1000 # The number of coin flips
k = 550 # The amount of heads to get
cases = 0

for i in range(k, n + 1):
    cases += math.comb(n, i)

# Dividing at the end to avoid floating point problems
print(cases / (2 ** n)) 
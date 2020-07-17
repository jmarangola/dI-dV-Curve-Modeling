import concurrent.futures
import requests
import threading
import time
import numpy as np
from cmath import exp
import cmath
import matplotlib.pyplot as plt
import matplotlib


thread_local = threading.local()
DX = 1
output = []
t_ = np.arange(-20, 20, DX)
Omega_ = np.arange(0.001, 20, DX)



def compute(x):
    position = x[0]
    o_1 = []
    o_2 = []
    print(x[1])
    current = []
    
    for E in x[1]:
        print(f"P(E): {E}")
        for t in t_:
            for w in Omega_:
                o_1.append((((1)/(w**3 + w))* (( (exp(-1*1j*w*t)) - 1) / (1 - exp(-1*w)) ).real)*DX)
            o_2.append(exp(sum(o_1) + 1j*E*t).real*DX)
            o_1 = []
        current.append(sum(o_2))
        o_2 = []
    output.append([position, current])


def delegate(subdomains):
    with concurrent.futures.ThreadPoolExecutor(max_workers=divisions) as executor:
        executor.map(compute, subdomains)


if __name__ == "__main__":
    LOWER = -200
    UPPER = 200
    domain = list(np.arange(LOWER, UPPER, DX))
    #print(f"domain: {domain}")
    subdomains = []
    divisions = 20
    displacement = int(abs(LOWER-UPPER)/divisions)
    pos, index = 0, 0
    while pos < len(domain): # delegate to subdomains
        subdomains.append(domain[pos:pos+displacement])
        pos += (displacement)
        index += 1
    q = delegate(list(enumerate(subdomains)))
    
#print(f"sauce: {list(enumerate(subdomains))}")
output = output.sort(key=lambda x:x[0], reverse=False) # lambda sort nested array
print(output)
#output = [x[1] for x in output] # list comprehension to concat and joing
#list(join(output))

total = []
print(output)
for el in output:
    total.append(el[1])
print(total)
plt.plot(domain, output)
plt.ylabel('P(E)')
plt.show()

    
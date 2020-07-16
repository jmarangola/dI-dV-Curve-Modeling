import concurrent.futures
import requests
import threading
import time
import numpy as np


thread_local = threading.local()
DX = 0.1
output = []




def compute(x):
    values[x[0]] = x[1]


def download_all_sites(sites):
    LOWER = -200
    UPPER = 200
    domain = list(range(LOWER, UPPER, DX))
    subdomains = []
    divisions = 20
    displacement = abs(LOWER-UPPER)/divisions
    index = 0
    while index < len(domain): # delegate to subdomains
        subdomain = domain[index:index+displacement]
        index += displacement
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=divisions) as executor:
        executor.map(compute, subdomains)


if __name__ == "__main__":
    
    print(list(enumerate(x)))
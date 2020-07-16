import cmath
from cmath import exp
import numpy as np
import matplotlib as m
import math

x = 5
y = 10
w = 5
t = 5

Omega_ = [0.001, 20]
t_ = [-200, 200]
for x in range(0, 200):
    outputs.append(((1)/(w**3 + w))* (( (exp(-1*1j*w*t)) - 1) / (1 - exp(-1*w)) ))
    print(outputs[-1])


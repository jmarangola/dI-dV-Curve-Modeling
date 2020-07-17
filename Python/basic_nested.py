import cmath
from cmath import exp
import numpy as np
import matplotlib as m
import math
import matplotlib.pyplot as plt

x = 5
y = 10


dx = .1
Omega_ = np.arange(0.001, 20, dx)
t_ = np.arange(-20, 20, dx)
E_ = np.arange(-200, 200, 1)
outputs = []

sum_ = 0
sum_2 = 0
o_1 = []
o_2 = []
o_3 = []
for E in E_:
    for t in t_:
        for w in Omega_:
            sum_ += ((((1)/(w**3 + w))* (( (exp(-1*1j*w*t)) - 1) / (1 - exp(-1*w)) ).real)*dx)
        sum_2 += (exp(sum_ + 1j*E*t)*dx)
        sum_ = 0
    print(f"E: {E}")
    outputs.append(sum_2)
    sum_2 = 0
    

plt.plot(E_, outputs)
plt.ylabel('P(E)')
plt.show()


from numpy.fft import fft, fftfreq
from scipy.integrate import romberg
from pylab import *
import pickle

def integral(x):
	return 0.5*(x[0]+x[len(x)-1])+sum(x[1:len(x)-1])

def coth(x):
	return (exp(x)+exp(-x))/(exp(x)-exp(-x))

def R(x, t):
	if x>0.01:
		return 1/(x+x**3)*coth(g/(2*pi*kT)*x)*(cos(x*t)-1)
	else:
		return 1/(1+x**2)*(1+0.5*(g/(2*pi*kT)*x)**2)/(g/(2*pi*kT)+(g/(2*pi*kT))**3*x**2/6)*(-t**2/2+t**4*x**2/24)

def I(x, t):
	if x>0.01:
		return 1/(x+x**3)*sin(x*t)
	else:
		return (t-t**3*x**2/6)/(1+x**2)

def J(y):
	return 2/g*(romberg(R, 0.0, 10.0, args=([y]))-1j*romberg(I, 0.0, 10.0, args=([y])))

kT = 0.1
print 'temperature:', kT, 'E_C'

r = 0.14
g = 1.0

Par = array([g, kT])
Filename = 'P(E).txt'

T = 100.0
N = 2**10
t, dt = linspace(0.0, T, N, retstep=True)
f = zeros(N, dtype=complex)

for n in arange(N):
	#print n
	f[n] = 1/g*exp(J(t[n]))

print 'J(t) calculated'

F = fft(f)
E = fftfreq(t.shape[-1])

ind = argsort(E)
E = -N/T*sort(E)*2*g
F = (F[ind])*T/N
P = (F-F[0]).real
dE = (max(E)-min(E))/len(E)

print 'P(E) available'

File = open(Filename, 'w')
pickle.dump(Par, File)
pickle.dump(E, File)
pickle.dump(P, File)
File.close()

figure(1)
plot(t, zeros(len(t)), c='k')
plot(t, f.real)
plot(t, f.imag)

figure(2)
plot(E[P>=10E-9], P[P>=10E-9], label='kT=%.2f' %(kT))
print sum(P[P>=10E-9])*dE
#print dE

show()


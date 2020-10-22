from pylab import *
#from functions import f, integral
import pickle as pk

def cot(x):
	return cos(x)/sin(x)

def f_mod(x):
	return sqrt(V_m**2-x**2)/(V_m**2)

def integral(x):
	return 0.5*(x[0]+x[len(x)-1])+sum(x[1:len(x)-1])

def df(E):
	if kT==0:
		if type(E)==float:
			"""Input is a number"""
			return 0.5*(sign(E)-1)
		elif type(E)==np.ndarray:
			"""Input is an array"""
			Out = zeros(len(E))
			Out[0:len(E[E<0])] = -ones(len(E[E<0]))
			return Out

	else:
		if type(E)==float:
				"""Input is a number"""
				if abs(E/kT)<0.001:
					return -0.5+(E/kT)/6-(E/kT)**3/180
				elif abs(E/kT)>300.0:
					return 0.5*(sign(E)-1)				
				else:
					return ((1-E/kT)*exp(E/kT)-1)/(exp(E/kT)-1)**2

		elif type(E)==np.ndarray:
			"""Input is an array"""
			Out = zeros(len(E))		
			for i in arange(len(E)):
				Out[i] = df(float(E[i]))

			return Out

def f(E):
	if kT==0:
		"""E over Bose-factor for zero temperature"""
		if type(E)==float:
			"""Input is a number"""
			return -E*float(E<0)
		elif type(E)==np.ndarray:
			"""Input is an array"""
			Out = zeros(len(E))
			Out[0:len(E[E<0])] = -E[E<0]
			return Out
			
	else:
		"""E over Bose-factor for finite temperature"""	
		if type(E)==float:
			"""Input is a number"""
			if abs(E/kT)<0.001:
				return kT-E/2+E**2/(12*kT)
			elif abs(E/kT)>700.:
				return 0.5*E*(sign(E)-1)
			else:
				return E/(exp(E/kT)-1)
			
	
		elif type(E)==np.ndarray:
			"""Input is an array"""
			Out = zeros(len(E))		
			for i in arange(len(E)):
				Out[i] = f(float(E[i]))
				
			return Out

def a(n, t):
	return (1-exp(-n*pi*abs(t)*b))/(n*pi*(1-(n*pi*b)**2))

Filename = 'DCB-5.txt'

kT = 0.01	
r = 100.0
V_max, V_m = 10., 0

Ind = (['r', 'kT'])
Par = ([r, kT])

"""Calculation of P(E)"""

T = 50.0/r#+5/(r*kT)

if r<0.3: N = 2**14
elif r<1: N= 2**13
else: N= 2**12

t, dt = linspace(0.0, T, N, retstep=True)

b = 2*pi*r*kT

a_1 = a(1, max(t))
n_max = 2
while abs(a(n_max, max(t))/a_1)>1E-6: n_max +=1
print n_max, a(n_max, max(t))	

n = arange(1, 20)

n = arange(1, n_max)[:, newaxis]
J_ana = pi*r*((cot(1/b)-1j*sign(t))*(1-exp(-abs(t)))-t*b-2*sum(a(n,t), axis=0))

F = fft(r*exp(J_ana))
E = fftfreq(t.shape[-1])

ind = argsort(E)
E = -N/T*sort(E)*2/r
F = (F[ind])*T/N
P = (F-F[0]).real
dE = (max(E)-min(E))/len(E)
#P = F.real

E = E[P>=10E-9]
P = P[P>=10E-9]

print 'P(E) available'
print sum(P[P>=10E-9])*dE

"""Calculation dI/dV"""

#V_max = 20.0	# upper limit of the voltage window in meV
V, dV = linspace(-V_max-V_m, V_max+V_m, 501, retstep='True')

E_C = 1.	#80.10885/C	#charging energy in meV	
print 'Charging energy:', E_C, 'mV'

#delta = Delta/E_C	#supercoducting gap-parameter in units of E_C
#eta = 0.05*delta	#Dynes parameter

eV, deV = V/E_C, dV/E_C	#voltage in units of E_C

I, dI = zeros(len(eV)), zeros(len(eV))

for i in arange(len(V)):
	if V[i]<=0:
		dI[i] = -integral((df(E-eV[i])+df(E+eV[i]))*P)*dE
		I[i] = integral((f(E-eV[i])-f(E+eV[i]))*P)*dE
	else:
		I[i] = -I[len(I)-i-1]
		dI[i] = dI[len(dI)-i-1]
		
if V_m>0:
	"""Convolution with half-circle function"""
	dI_con = zeros(len(V))
	ind = arange(len(V))

	for i in ind[abs(V)<=V_max]:
		dI_con[i] = 2/pi*sum(dI[abs(V[i]-V)<=V_m]*f_mod(V[abs(V[i]-V)<=V_m]-V[i]))*dV

	V = V[dI_con>0]
	dI = dI_con[dI_con>0]

Data = (['eV', 'I', 'dI'])

File = open(Filename, 'w')
pk.dump(Ind, File)
pk.dump(Par, File)
pk.dump(Data, File)
pk.dump(eV, File)
pk.dump(I, File)
pk.dump(dI, File)
File.close()

"""Graphical Output"""

figure()
plot(t, zeros(len(t)), c='k')
plot(t, r*exp(J_ana).real, label='Re exp(J(t))', c='b')
plot(t, r*exp(J_ana).imag, label='Im exp(J(t))', c='r')
legend(loc='best')

figure()
plot(E, P)

figure(figsize=(7,5))
xlabel('$V(mV)$', fontsize=15)
ylabel('$(dI/dV)R_T$', fontsize=15)
plot(eV, dI, lw=1.5)
#axis([-V_max, V_max, 0.0, 2.0])
#legend(loc='best')

figure()
plot(eV, I, lw=1.5)

show()

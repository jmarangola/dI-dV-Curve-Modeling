from pylab import *
from functions import f, integral
import pickle

g = 1.0	#alpha=2/g
C = 1.0
T = 4.6

"""Calculation of P(E)"""
E_max = 10.0
E, dE = linspace(0.0, E_max, 1000.0*E_max, retstep=True)
P = E*exp(-E)/(1+E**2)	#starting function for the iteration
P = P/(integral(P)*dE)

k=1
while k<=10:
	j=1
	while j<len(E):
		P[j] = 2/g/E[j]*integral(P[0:j+1]/(1+(pi/g)**2*(E[j]-E[0:j+1])**2))*dE
		j+=1
	if g>=2:
		P[0] = P[1]
	P = P/(integral(P)*dE)
	k+=1

File = open('P(E)_g=1,0.txt', 'w')
pickle.dump(E, File)
pickle.dump(P, File)
File.close()

"""Calculation of I(V) and dI/dV curves"""
show_PL = True		#show power law around zero
eV_Bias, deV = linspace(-2.0, 2.0, 201, retstep='True')

kT = 7.2256E-4*C*T	
print 'temperature:', kT, 'E_C' 

E_V = 0.0801/C		
print 'Coulomb gap:', E_V, 'V'

alpha = 2/g	#exponent of power law
print 'alpha =', alpha

I = zeros(len(eV_Bias))
dI = zeros(len(eV_Bias))

for i in arange(len(eV_Bias)):
	#print i
	I[i] = integral((f(eV_Bias[i]-E, kT)-f(-eV_Bias[i]-E, kT))*P)*dE
		
	if i>0 and i<len(eV_Bias)+1:
		dI[i-1] = (I[i]-I[i-2])/(2*deV)

dI[0]=(I[1]-I[0])/deV
dI[i]=(I[i]-I[i-1])/deV

figure(1)
title('$I(V),\; T=%1.1fK,\;g=%1.1f$' %(T, g))
xlabel('$V_{Bias}(V)$')
ylabel('$I(a.u.)$')
plot(E_V*eV_Bias, E_V*I, c='k', lw=2, label = '$P(E)$-theory')
if show_PL:
	plot(E_V*eV_Bias, E_V*e**(-alpha*0.577217)/gamma(2+alpha)*eV_Bias*abs(pi*eV_Bias/g)**(alpha), label='power law, $\sim |V\,|^{\,2/g}/V$')
	legend(loc='best')
grid('True')


figure(2)
title('$dI/dV,\;g=%1.1f$' %g)
xlabel('$eV/E_C$')
ylabel('$dI/dV\,(a.u.)$')
plot(E_V*eV_Bias, dI, c='k', lw=2, label = '$P(E)$-theory')
if show_PL:
	plot(E_V*eV_Bias, 0.5*(alpha+1)*e**(-alpha*0.577217)/gamma(2+alpha)*abs(pi*eV_Bias/g)**(alpha), label='power law $\sim |V\,|^{\,2/g}$')
	legend(loc='best')
grid('True')
legend(loc='best')

show()


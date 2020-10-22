import numpy as np
from pylab import *

def integral(x):
	return 0.5*(x[0]+x[len(x)-1])+sum(x[1:len(x)-1])

def Theta(x):
	if type(x)==float:
		"""Input is a number"""
		return x*float(x>0)
	elif type(x)==np.ndarray:
		"""Input is an array"""
		Out = zeros(len(x))
		Out[len(x[x<=0]):len(x)] = x[x>0]
		return Out

def f(E, kT):
	if kT==0:
		"""E over Bose-factor for zero temperature"""
		if type(E)==float:
			"""Input is a number"""
			return E*float(E>0)
		elif type(E)==np.ndarray:
			"""Input is an array"""
			Out = zeros(len(E))
			Out[len(E[E<=0]):len(E)] = E[E>0]
			return Out
			
	else:
		"""E over Bose-factor for finite temperature"""	
		if type(E)==float:
			"""Input is a number"""
			if abs(E)>0.011:
				return E/(1-exp(-E/kT))
			else:
				return kT/(1-E/kT/2+(E/kT)**2/6-(E/kT)**3/24+(E/kT)**4/96)
	
		elif type(E)==np.ndarray:
			"""Input is an array"""
			Out = zeros(len(E))		
			for i in arange(len(E)):
				if abs(E[i])>0.011:
					Out[i] = E[i]/(1-exp(-E[i]/kT))
				else:
					Out[i] = kT/(1-(E[i]/kT)/2+(E[i]/kT)**2/6-(E[i]/kT)**3/24+(E[i]/kT)**4/96)
			return Out

def coth(x):
	return (exp(x)+exp(-x))/(exp(x)-exp(-x))

def rund(x):
	return int(x+sign(x)*0.5)
	
	

from pylab import *
import pickle as pk

Files = (['P(E)-1.txt', 'P(E)-2.txt', 'P(E)-3.txt', 'P(E)-4.txt', 'P(E)-5.txt', 'P(E)-6.txt', 'P(E)-7.txt'])
colors = (['b', 'r', 'g', 'brown', 'purple', 'orange', 'k'])

f, l = 18, 1.5

figure(1, figsize=(7,5))

for i in arange(len(Files)):
	File = open(Files[i], 'r')
	print pk.load(File)
	r, kT = pk.load(File)
	print r, kT
	pk.load(File)
	E = pk.load(File)
	P = pk.load(File)
	File.close()

	plot(E, P, label='$R/R_K=%.1f$' %r, lw=l, c=colors[i])

#plot(E[E>0], 0.142/E[E>0])
figure(1)
title('$kT=%.2fE_c$' %kT, fontsize=f)
xlabel('$E/E_C$', fontsize=f)
ylabel('$P(E)$', fontsize=f)
legend(loc='best')
axis([-.2, 2.5, 0., 1.8])

show()

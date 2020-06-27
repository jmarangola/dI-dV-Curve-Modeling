% int function instead
syms A x
assume(x, 'real');
assume(A, 'real');

g = (((1)./(x.^3 + x)).*(((exp(-1.*i.*x.*A)) - 1)./(1 - exp(-1.*x))));
% found a way to reliably and properly substitute variables in for symbolic
% variables so that int function can work over a range of variables in a
% loop or matrix
g_alt = subs(g, A, 1)

g_ = int(g_alt,x,0.001,inf)






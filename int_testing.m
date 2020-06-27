% int function instead
syms A x y
assume(x, 'real');
assume(A, 'real');

g_gen = (((1)./(x.^3 + x)).* (((exp(-1.*i.*x.*A)) - 1)./(1 - exp(-1.*x))));
% found a way to reliably and properly substitute variables in for symbolic
% variables so that int function can work over a range of variables in a
% loop or matrix

%Arange = -2000:1:2000
g_part = subs(g_gen, A, 5) % arbitrary value for now trying to get it to work for matrix of values for A
g = vpaintegral(g_part, x, 0.0001, inf) + y.*i

P = vpaintegral(g, y, 0.0001, 200)












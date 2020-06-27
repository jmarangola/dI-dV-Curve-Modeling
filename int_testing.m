% vpaintegral docs:
% https://www.mathworks.com/help/symbolic/vpaintegral.html
syms A x y
assume(x, 'real');
assume(A, 'real');

g_gen = (((1)./(x.^3 + x)).* (((exp(-1.*i.*x.*A)) - 1)./(1 - exp(-1.*x))));
% found a way to reliably and properly substitute variables in for symbolic
% variables so that int function can work over a range of variables in a
% loop or matrix

%Arange = -2000:1:2000
g_part = subs(g_gen, A, -0.3423) % arbitrary value for now trying to get it to work for matrix of values for A
g = vpaintegral(g_part, x, 0.0001, inf) + y.*i

format long
P = vpaintegral(g, y, 0.0001, 2000000000000) + vpaintegral(g, y, -0.0001, -2000000000000) 
% defining first integral from a->(b-delta) and second from (b+delta) to c where delta is arbitrarily small and b is a region of infinite discontinuity where the function is not differentiable
% in the integral above, a and c are made arbitrarily large to approximate
% right/left hand behavior as infinite bounds in vpa integral would make
% later computations impossible by using the maximum possible number of function
% calls in the stack frame
% ie. error Failed precision goal. Try using 'MaxFunctionCalls












syms a x y b
assume(x, 'real');

g0 = ((1)./(x.^3 + (x))).*((exp(-x.*1.*i) - 1)./(1 - exp(-x.*1)));
g00 = subs(g0,0.001);
g1 = diff(g0);
g11 = subs(g1,0.001);
g2 = diff(g1);
g22 = subs(g2,0.001);
g3 = diff(g2);
g33 = subs(g3,0.001);
g4 = diff(g3);
g44 = subs(g4,0.001);

g_exp = @(x) g00 + g11.*(x - 0.001) + ((g22.*((x - 0.001).^2))./2) + ((g33.*((x - 0.001).^3))./6) + ((g44.*((x - 0.001).^4))./24)

sol = int(g_exp,x,0,x)

sol2 = real(sol)
figure

fplot(sol2,[-1 1])
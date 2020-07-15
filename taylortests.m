syms a x y t E
assume(x, 'real');
assume(t, 'real');

g0 = ((1)./(x.^3 + (x))).*((exp(-x.*t*i) - 1)./(1 - exp(-x.*1)));
g00 = subs(g0,0.001);
g1 = diff(g0);
g11 = subs(g1,0.001);
g2 = diff(g1);
g22 = subs(g2,0.001);
g3 = diff(g2);
g33 = subs(g3,0.001);
g4 = diff(g3);
g44 = subs(g4,0.001);

g_exp = @(x, t) g00 + g11.*(x - 0.001) + ((g22.*((x - 0.001).^2))./2) + ((g33.*((x - 0.001).^3))./6) + ((g44.*((x - 0.001).^4))./24)


sol = real(vpaintegral(g_exp(x, t),x,0.001,10000000))
s2 = vpaintegral((1 + (sol + 1i.*E.*t) + (sol + 1i.*E.*t).^2)./2 + ((sol + 1i.*E.*t).^3)./(factorial(3)) + ((sol + 1i.*E.*t).^4)./factorial(4) + ((sol + 1i.*E.*t).^5)./factorial(5), t, 0.001, 1000000)




syms w t x
assume(w, "real");
assume(t, "real");
assume(x, "real");


J_exp = -1i*t/x + (-1i*t/2 - t^2/2) + 1/12*1i*(11*t + 3*1i*t^2+2*t^3)*x + 1/24*(12*1i*t+11*t^2+2*1i*t^3+t^4)*x^2 - 1/720*1i*(659*t+180*1i*t^2+110*t^3+15*1i*t^4+6*t^5)*x^3 + (1i*t/2-659*t^2/1440-1i*t^3/12-11*t^4/288-1i*t^5/240-t^6/720)*x^4 + (27677*1i*t/30240-t^2/4 + 659*1i*t^3/4320-t^4/48+11*1i*t^5/1440-t^6/1440+1i*t^7/5040)*x^5
j_at = subs(J_exp, t, 10)
f = real(int(j_at, x, 0, x))
figure
fplot(real(f), [-10 10])

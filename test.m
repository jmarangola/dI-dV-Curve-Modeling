syms A x
assume(x, 'real');
assume(A, 'real');
%assume(A > 0);

% g = (((1)./(x.^3 + x)).*(((exp(-1.*i.*x.*A)) - 1)./(1 - exp(-1.*x))))
% ans = int(f,x,0,inf)

%g = @(x) ((1)./(x.^3 + (x))).*((exp(-i.*x) - 1)./(1 - exp(-x)))
g = @(x) ((1)./(x.^3 + (A.*x))).*((exp(-x) - 1)./(1 - exp(-x)));

%g = @(x) (1)./(x.^3 + x)

%g = @(x) exp(-x.*2)

%g21 = integral(g,0.001,200)
g22 = int(g,x,0.001,x)
g22 = int(g, x, 0.001, x)

%g3 = real(g2)

%g3 = int(g,x,x,-0.00001) 
%g4 = real(g3) %plots int of g
%fplot(g4,[-6 -0.001])
%hold on
%fplot(g22,[-6 6])
%hold off
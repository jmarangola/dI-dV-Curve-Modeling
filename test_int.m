
% first function
%f = @(x,y) (x.^2-y.^2).*cos(x./(1+y.^2));
format long
g = @(x, A) A*((1)./(x.^3 + (x))).*((exp(-x) - 1)./(1 - exp(-x)));

% Some limits of integration
lower_limit = 0;
upper_limit = 3;

% Define g as the integral of f(x,y) dy from a to b

g = @(A) (integral(@(x) g(x,A) , -inf, inf))
g(1)
g(2)


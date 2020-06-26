
% first function
%f = @(x,y) (x.^2-y.^2).*cos(x./(1+y.^2));
format long
g = @(x, y) ((1)./(x.^3 + (x))).*((exp(-x.*y) - 1)./(1 - exp(-x)));

% Some limits of integration
lower_limit = 0;
upper_limit = 3;

% Define g as the integral of f(x,y) dy from a to b
x = -20:20
g = @(y) (integral(@(x) g(x,y) , -inf, inf))

input = -20:0.1:20
output = zeros(size(input))
w = 1;
for x = input
    output(w) = g(x)
    w = w +1;
end



    


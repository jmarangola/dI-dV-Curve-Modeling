
% first function
%f = @(x,y) (x.^2-y.^2).*cos(x./(1+y.^2));

g = @(x, y) ((1)./(x.^3 + (x))).*((exp(-x.*y*i) - 1)./(1 - exp(-x)));

% Define g as the integral of f(x,y) dy from a to b

gx = @(y) (integral(@(x) g(x,y) , -100000, 100000))

x = -20:.1:20
input = 0:200
output = zeros(size(input));
w = 1;
for x = input
    output(w) = real(gx(x));
    w = w +1;
end




    


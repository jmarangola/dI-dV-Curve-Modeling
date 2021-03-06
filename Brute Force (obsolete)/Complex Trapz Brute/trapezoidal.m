% Determining the speed of trapz within nested riemann sum


% two functions (no integration)
j = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));

p = @(E, t) (exp(j(w, t) + 1i.*E.*t))

% constants
kb=1.381e-23;

% differential step variables
dx_t = .1;
dx_w = .1;
dx_E = 1;

% Bounds of integration
tbounds = -20:dx_t:20;
tvals = -20:dx_t:20;
wbounds = 0.001:dx_w:20; % cannot do zero or there is infinite singularity div by 0
wvals = 0.001:dx_w:20; % same size as ^

% Domain/output must be dimensionally consistent for plot
clear output
domain = -200:1:200
domE = -200:1:200
output = -200:1:200

% loop vars
sum = 0;
sum2 = 0;

% � iteration vars: matlab is 1 indexed not zero
k = 1;
i = 1;
% attempt to use an array-based function to compute J(t) faster 
% trapezoidal approximation
for t=tbounds
        t_0 = arrayfun(@(w) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w)))),wbounds);
        tvals(i) = trapz(t_0); %  J(t)
        i = i + 1;
 end


plot(tbounds, tvals);



%figure
%plot(domain, output)


    


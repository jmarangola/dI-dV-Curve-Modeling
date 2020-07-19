
% two functions (no integration)
j = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
p = @(E, t) (exp(j(w, t) + 1i.*E.*t))

% constants
kb=1.381e-23;

% differential step variables
dx_t = .001;
dx_w = .01;
dx_E = 1;

% Bounds of integration
tbounds1 = -20:dx_t:20;
wbounds = 0.001:dx_w:20; % cannot do zero or there is infinite singularity div by 0

% arrays to hold information from functions for easy trapezoidal
% approximation
w_ = 0.001:dx_w:20;
t_ = -20:dx_t:20;

% Domain/output must be dimensionally consistent for plot
clear output
domain = -200:1:200
output = -200:1:200

% loop vars
sum = 0;
sum2 = 0;

% Just using trapz instead of rieman sum
k = 1;
i = 1;
x = 1;

for E=domain
    
    for t=tbounds1
        
        for w=wbounds
            
            w_(i) = j(w, t);
            i = i + 1;
            
        end
        
        i = 1;
        sum = trapz(wbounds, w_);
        t_(x) = (exp(sum + 1i.*E.*t));
        x = x + 1;
        
    end
    x = 1;
    output(k) = trapz(t_);
    k = k + 1
    
end

figure
plot(domain, output)


    


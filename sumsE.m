
% two functions (no integration)
j = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
p = @(E, t) (exp(j(w, t) + 1i.*E.*t))

kb=1.381e-23;

% Bounds of integration
tbounds1 = 0.001:dx:20;
tbounds2 = -0.001:dx:-20
wbounds = 0.001:dx:20;

% Domain/output must be dimensionally consistent for plot
clear output
domain = -20:1:20
output = -20:1:20

% Differential step
dx = .1;

% loop vars
sum = 0;
sum2 = 0;

%iteration vars: matlab is 1 indexed not zero
k = 1;


for E=domain
    for t=tbounds1
        for w=wbounds
            sum = sum + (j(w, t)*dx);
        end
        
        sum2 = sum2 + (exp(sum + 1i.*E.*t));
        sum = 0;
    end
    output(k) = sum2;
    sum2 = 0; % set sum2 back to zero
    k = k + 1
end
 


figure
plot(domain, output)


    


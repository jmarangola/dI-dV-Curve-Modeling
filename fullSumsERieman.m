
% two functions (no integration)
j = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
p = @(E, t) (exp(j(w, t) + 1i.*E.*t))

kb=1.381e-23;

% differential step variables
dx_t = 0.1;
dx_w = 0.1;
dx_E = 0.1;

% Bounds of integration
tbounds1 = -20:dx_t:20;

wbounds = 0.001:dx_w:20; % cannot do zero or there is infinite singularity div/==============i

% Domain/output must be dimensionally consistent for plot
clear output
domain = -200:1:200
output = -200:1:200

% Differential step


% loop vars
sum = 0;
sum2 = 0;

%iteration vars: matlab is 1 indexed not zero
k = 1;
for E=domain
    
    for t=tbounds1
        
        for w=wbounds
            
            sum = sum + (j(w, t)*dx_w);
            
        end
        sum2 = sum2 + (exp(sum + 1i.*E.*t)*dx_t);
        sum = 0;
    end
    output(k) = sum2;
    sum2 = 0; % set sum2 back to zero
    k = k + 1
end

figure
plot(domain, output)


    


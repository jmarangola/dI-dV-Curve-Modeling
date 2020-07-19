% Physical constants
kb=1.381e-23; % K_b
hbar = 1.0545718e-34; % reduced planck constant 
h = 6.62607015e-34; % planck constant
e = 1.602e-19 % elementary charge
R_k = h/(e^2); % R_k


% Physical Parameters
T = 7; % in K
C = 8e-18;
C_T = 8e-18;
R = 0.3*R_k;

% ReZ(w):
ReZw = @(w) ( (R.^-1)./(R_k).*((w.^2.*(C_T + C).^2 ) + R.^(-2) ) )

% two functions J(t) and P(E)

j = @(w, t) 2 .* ReZw(w) .* (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp((-1.*h.*w)./(kb*T)))));
p = @(E, t) (exp(j(w, t) + 1i.*E.*t))

% differential step variables
dx_t = 0.1;
dx_w = 0.1;
dx_E = 1;

% Bounds of integration
tbounds1 = -20:dx_t:20;
wbounds = 0.001:dx_w:20; % cannot do zero or there is infinite singularity div by 0

% Domain/output must be dimensionally consistent for plot
clear output
domain = -200:1:200
output = -200:1:200

% loop vars
sum = 0;
sum2 = 0;

% ßiteration vars: matlab is 1 indexed not zero
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


    


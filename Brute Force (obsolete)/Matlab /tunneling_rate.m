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

% End constants ------

% store values:
dx_E = 0.1
p_sum = 0;
Vvals = -200:1:200
Vstep = 1:1:length(Vvals);
op = -200:1:200;
Evals = -50:dx_E:50

for k=Vstep
    V = Vvals(k); % define V for iteration
    k
    for E=Evals
        p = int_Ppar(e*V + E);
    end
    op(k) = p; % assign to output
    
end

figure
plot(Vvals, op);
        




    
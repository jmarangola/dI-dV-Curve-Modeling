% adaptive quadrature attempt 

% Generating plot:

STARTING_VAL = -200*10^-3; % in mv
ENDING_VAL = 200*10^3;
NUM_INTERVALS = 401;

% Computational constants
C = 5.05*10^-18;
e_ = 1.60*10^-19;
h =  6.62607015*10^-34
%R_K = (h/(e_^2));
R_K = 25.8*10^3; %25.8 kohms
R_T =1.24 * 10^4 * R_K;
REF_CONST = 1/(e_^2)*(R_T);
K_B = 1.38064852 * (10^-23);
T = 4.6;
C_T = 0.85 * 10^-18;
R = 122.0 * R_K;
P_CONST = 1/(2*pi*h);

ReZ = @(w) (1/R)./ (R^(-2) + (w.^2).*(C_T + C)^2)

J_func = @(w, t) ((1)./(w.*R_K)) .* (ReZ(w)) .* (exp((-1).*i.*w.*t) - 1)./(1 - exp((h.*w)./(K_B.*T))); % General function handle first integral
J_eq = @(t) (2.*integral(@(w) J_func(w,t),0,inf)); % fFunction handle of J as a function of t integrated with respect to w 

P_func = @(t, E) (P_CONST).*(exp(J_eq(E) + i.*E.*t./h)); % General function handle of P as a function of E, t
P_eval = @(E) (integral(@(t) P_func(t,E),-inf,inf)); % handle of P as a function of E integrated with respect to t

vTun_rate_func = @(E, V) (REF_CONST .* E .* P_eval(e_.*V + E))./(exp(E./K_B.*T)); % General function handle for Tunelling rate as  a function of E, v
T_R = @(V) ( integral(@(E) P_func(E,V),-inf,inf)); % Tunneling rate as a function of v (integrates with respect to E for some parameter V)

I = @(V) (-e_)*(T_R(V)) - (T_R(-V)); % Current as a function of V using two tunnelling rates from Tip to island and island to tip

v = linspace(STARTING_VAL, ENDING_VAL, NUM_INTERVALS); 

out = zeros(401);
x = 1;
 %while x<=length(v) % iterate through v and plot I(v)
  %  out(x) = I(v(x));
   % x = x+1;
    %disp(x)
    %disp(length(v))
 %end
I(0)
%x = linspace(-.2, .2, 401);

%T_R(2)
%I(.2)

% plot controls
%figure
%plot(v, out)
%grid
%disp(x)

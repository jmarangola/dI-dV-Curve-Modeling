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
j = @(w, t) 2 .* ReZw(w) .* (((1)./(w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp((-1.*h.*w)./(kb*T)))));
p = @(E, t) 1/2*pi*hbar*(exp(j(w, t) + 1i.*E.*t))

% differential step variables
dx_t = 0.1;
dx_w = 0.1;
dx_E = 0.1;

% Bounds of integration
tbounds1 = -20:dx_t:20;
wbounds = 0.001:dx_w:20; % cannot do zero or there is infinite singularity div by 0
Ebounds = -200:dx_E:200

%Domain/output must be dimensionally consistent for plot
Vbounds = -50e-3:1e-3:50e-3
clear output
output = -0.001:1:50


% loop vars
% sum = 0;
% sum2 = 0;
% sum3 = 0;
% 
% % iteration vars: matlab is 1 indexed not zero
% k = 1;
% 
% for V=Vbounds
%     
%     for E=Ebounds
%         
%         for t=tbounds1 % P(eV + E):
%             
%             for w=wbounds % J(t) for particular t, integrated with respect to w
%                 sum = sum + (j(w, t)*dx_w);
%             
%             end
%             % P(eV + E) for particular E integrated with respect to t:
%             sum2 = sum2 + 1/2*pi*hbar*(exp(sum + 1i.*(e.*V + E)*t))*dx_t;
%             sum = 0;
%         
%         end
%         % sum2 = P(ev + E)
%         sum3 = sum3 + (E.*sum2/exp(E./kb.*T)).*dx_E;
%         sum2 = 0; % reset sum2 to ensure accurate data
%     
%    
%     end
%     % pulled out constants from T integral
%     output(k) = 1./(e^2.*R).*sum3;
%     sum3 = 0; % after it is used to compute Tunneling rate for a given V
%     k = k + 1; % iterate loop counter
%     
% end



figure
plot(bounds, output)


    
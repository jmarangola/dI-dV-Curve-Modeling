% Function plots P(E) using local parallel pooling to optimize efficiency
% Requires latest version of Matlab parallel computing toolbox
function res = parallel_P() 
    kb=1.381e-23; % K_b
    hbar = 1.0545718e-34; % reduced planck constant 
    h = 6.62607015e-34; % planck constant
    e_ = 1.602e-19; % elementary charge
    R_k = h/(e_^2); % R_k


    % Physical Parameters
    T = 7; % in K
    C = 8e-18;
    C_T = 0.84e-18;
    R = 0.3*R_k;
    Ebounds = -200:1:200;
    vec0 = 1:length(Ebounds)

    for n=vec0 % kick off computations without pooling
        output(n) = integrate_p(Ebounds(n));
        disp(n);
    end
    % Plot results
    figure
    plot(Ebounds, output);
    %res = output;

function out = integrate_p(E) % Function takes parameter of E and returns P(E) 
    hbar = 1.0545718e-34; % constants redeclared because of scope issues
    h = 6.62607015e-34;
    dx_t = .01;
    tbounds = -20:dx_t:20;
    vec1 = 1:length(tbounds);
    sum2 = 0;
  
    parfor x=vec1 % Single step vector to iterate parfor and avoid runtime errors
        t = tbounds(x);
        omega = integrate_j(t);
        sum2 = sum2 + (1/(2*pi*hbar))*(exp(omega + 1i.*E.*t/hbar))*dx_t;
    end
    
    out = sum2; % returns P(E)


function result = integrate_j(t)
    % Redefining constants b/c of scope
    kb=1.381e-23; 
    hbar = 1.0545718e-34; 
    h = 6.62607015e-34; 
    e_ = 1.602e-19;
    R_k = h/(e_^2); 
    T = 7;
    C = 8e-18;
    C_T = 0.84e-18;
    R = 0.3*R_k;
    
    dx_w = 0.1; % differential omega element
    wbounds = 0.001:dx_w:20;
    vec2 = 1:length(wbounds); % step vector
    
    ReZw = @(w) ( (R.^-1)./(R_k).*((w.^2.*(C_T + C).^2 ) + R.^(-2) ) ); % Real(Z(w))
    j = @(w, t) -2 .* ReZw(w) .* (((1)./(w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp((-1.*h.*w)./(kb*T)))));
    sum_ = 0;
    
    for k=vec2
         w = wbounds(k);
         sum_ = sum_ + (j(w, t)*dx_w);
    end
    
result = sum_; % Function returns numeric value for J(t)

function parallel_P() % no return value
    dx_E = 1; % this is currently not actually a differential x but a step variable but it will be later so for consistent convention it is defined dx_E
    Ebounds = -200:dx_E:200; % the plotted domain of P(E)
    output = -200:dx_E:200;
    vec0 = 1:length(Ebounds); 
    C = Constants;
    for n=vec0
        output(n) = parallel_j(Ebounds(n), C);
        
    end
    
    figure
    plot(Ebounds, output);
end
function out = parallel_j(E, C)
    dx_t = 0.1;
    tbounds = -20:dx_t:20;
    
    vec1 = 1:length(tbounds);
    sum2 = 0;
  
    parfor x=vec1
        t = tbounds(x);
        omega = function_testing(t);
        sum2 = sum2 + (1/(2*pi*C.hbar))*(exp(omega + 1i.*E.*t/C.hbar))*dx_t;
    end
    out = sum2;
end

function result = function_testing(t)
    sum_ = 0; 
    dx_w = 0.1;
    wbounds = 0.001:dx_w:20;
    vec2 = 1:length(wbounds);
    ReZw = @(w) ( (C.R.^-1)./(C.R_k).*((w.^2.*(C_T + C).^2 ) + C.R.^(-2) ) );
    j = @(w, t) -2 .* ReZw(w) .* (((1)./(w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp((-1.*h.*w)./(kb*T)))));
    
    parfor k=vec2
         w = wbounds(k);
         sum_ = sum_ + (j(w, t)*dx_w);
    end
    
result = sum_;
end
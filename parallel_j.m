
function result = parallel_j(p)
    dx_w = 0.1;
    dx_t = 0.1;
    tbounds = -50:dx_t:50
     j = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
   
    
    vec = 1:length(tbounds); % parfor can only iterate through consecutive elements
    sum2 = 0;
    
    parfor i=vec % single step index iteration vector for parfor
        sum = integrate_omega(0.01:1:20, tbounds(i)) % i th element of vtbounds is current t
        sum2 = sum2 + (1/(2*pi*hbar))*(exp(sum + 1i.*E.*t/hbar))*dx_t;
    end
    
    result = sum2

function  sub = integrate_omega(wbounds, t)

    sum_ = 0; % scope issue -> subfunction must be sum_
    parfor w=wbounds
         sum_ = sum_ + (j(w, t)*dx_w);
    end
 sub = sum_;
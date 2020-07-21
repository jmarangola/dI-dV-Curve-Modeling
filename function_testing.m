
function result = function_testing(t)
    sum_ = 0; 
    dx_w = 0.1;
    wbounds = 0.001:dx_w:20
    vec2 = 1:length(wbounds)
    j = @(w, t) (((1)./(w.^3 + w)) .* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
    parfor k=vec2
         w = wbounds(k);
         sum_ = sum_ + (j(w, t)*dx_w);
    end
    
result = sum_
end

j = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
dx = .1;
sum = 0;
vals = 0.001:dx:20;
kb=1.381e-23;
levels = 0.001:dx:20;
k = 1;
E = 1
    %for t = 0.001:dx:2000
    t = -0.01
        for w=vals
            sum = sum + (j(w, t) * dx);
        end
        
        %levels(k) = sum;
        %sum = 0;
        %k = k + 1
        %sum2 = (sum2 + exp(jint + 1i*E*t))*dx; % sum P(E) for a single value of int(e)_-inf i
        disp(sum)
    %end
 


%figure
%plot(0.001:dx:2000, levels)


    


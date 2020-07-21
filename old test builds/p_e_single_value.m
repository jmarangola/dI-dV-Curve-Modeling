
% two functions (no integration)
j = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
p = @(E, t) (exp(j(w, t) + 1i.*E.*t))

kb=1.381e-23;

% Bounds of integration
tbounds = 0.001:dx:200;
wbounds = 0.001:dx:200;

% Differential step
dx = .1;

% loop vars
sum = 0;
sum2 = 0;

%iteration vars: matlab is 1 indexed not zero
k = 1;

% instance constants:
E = 1;

 for t=tbounds
        for w=wbounds
            sum = sum + (j(w, t)*dx);
        end
        k = k + 1;
        sum2 = sum2 + (exp(sum + 1i.*E.*t));
        sum = 0;
 end
 
disp(sum2);

%figure
%plot(0.001:dx:2000, levels)


    


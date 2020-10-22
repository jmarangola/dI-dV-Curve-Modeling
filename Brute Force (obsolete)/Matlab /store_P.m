kb=1.381e-23; 
hbar = 1.0545718e-34; 
h = 6.62607015e-34; 
e_ = 1.602e-19;
R_k = h/(e_^2); 
T = 7;
C = 8e-18;
C_T = 0.84e-18;
R = 0.3*R_k;


Ebounds = -20:.1:20
dom = -10:1:10
range = -10:1:10
dlen = 1:length(dom)
sum = 0;
k = 1;
for V=dom
    parfor xv = dlen
        E = (e_*V + Ebounds(xv));
        sum = sum + int_Ppar(E);
    end
    range(k) = sum
    sum = 0;
    k = k + 1
end

    
    
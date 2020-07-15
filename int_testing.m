% vpaintegral docs:
% https://www.mathworks.com/help/symbolic/vpaintegral.html

syms w t E q
assume(t, 'real');
assume(w, 'real');
assume(E, 'real');

% general form (using symbolic vars) 
j_gen = (((1)./(w.^3 + w)).* (((exp(-1.*i.*w.*t)) - 1)./(1 - exp(-1.*w))));






%j_part = subs(j_gen, t, 0.0)
%j = vpaintegral(j_part, w, 0.0001, inf)

% a b c approach breaking up integral with a spacing constant (would be
% nested for /nested while)
%upperbound = 20000
%spacing = 25;
%iteration = 1;
%current_value = 0
%start =0.001
%j_part = subs(j_gen, t, -1000)
%while (iteration * spacing < upperbound)
%current_value = current_value + vpaintegral(j_part, w, start + spacing*(iteration-1), spacing*iteration + start);
%disp("lower bound");
%disp(0.0001 + spacing*(iteration-1))
%disp("upper bound")
%disp(spacing*iteration + 0.0001)
%iteration = iteration+1;
%end

%begin J(t) plotting (j integrated with respect to w as a function of
%t-----------------------------------------------------
allt = -100:1:100
output = []
index = 1
s = size(allt)
while index <= s(2) % upper bound set by all t value vector
    j_particular = subs(j_gen, t, allt(index));
    inta = vpaintegral(j_particular, w, 0.001, inf);
    output(index) = inta;
    index = index + 1
end


%J(t) plotting (int with respect to w)------------------------

% for first and second integral later
%j = vpaintegral(j_part, w, 0.0001, inf) + y.*i


%P = vpaintegral(exp(g), A, 0.0001, 20000) + vpaintegral(exp(g), A, -0.0001, -20000)
%P = vpaintegral(exp(g), A, 0.0001, 20000) 
%P = vpaintegral(exp(g), A, -inf, -0.0001) +  vpaintegral(exp(g), A, 0.0001, inf)

%T = vpaintegral(P*y/(exp(y)-1), y, 0.0001, 20000) + vpaintegral(P*y/(exp(y)-1), y%, -0.0001, -inf)


%P = vpaintegral(exp(g), A, -9999999, -0.0001) +  vpaintegral(exp(g), A, 0.0001, 9999999)

%T = vpaintegral(P*y/(exp(y)-1), y, 0.0001, 9999999) + vpaintegral(P*y/(exp(y)-1), y, -0.0001, -9999999)











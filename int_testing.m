% vpaintegral docs:
% https://www.mathworks.com/help/symbolic/vpaintegral.html

syms w t y
assume(t, 'real');
assume(w, 'real');
assume(y, 'real');

% general form (using symbolic vars) 
j_gen = (((1)./(w.^3 + w)).* (((exp(-1.*i.*w.*t)) - 1)./(1 - exp(-1.*w))));

result = zeros(401);
dom = -200:1:200;



%for j=dom
%    j_part = subs(j_gen, t, dom(n)); % substitute the nth element of dom into j_gen for symbolic var t
%    result(n) = vpaintegral(j_part, w, 0.0001, inf);
%    n = n+1 ; %increment n
%end
%disp(result)

%j_part = subs(j_gen, t, 0.0)
%j = vpaintegral(j_part, w, 0.0001, inf)
upperbound = 20000
spacing = 5;
iteration = 1;
current_value = 0
start =900
j_part = subs(j_gen, t, -1000)
while (iteration * spacing < upperbound)
current_value = current_value + vpaintegral(j_part, w, start + spacing*(iteration-1), spacing*iteration + start)
%disp("lower bound");
%disp(0.0001 + spacing*(iteration-1))
%disp("upper bound")
%disp(spacing*iteration + 0.0001)
iteration = iteration+1;
end
disp(current_value)


% for first and second integral later
%j = vpaintegral(j_part, w, 0.0001, inf) + y.*i


%P = vpaintegral(exp(g), A, 0.0001, 20000) + vpaintegral(exp(g), A, -0.0001, -20000)
%P = vpaintegral(exp(g), A, 0.0001, 20000) 
%P = vpaintegral(exp(g), A, -inf, -0.0001) +  vpaintegral(exp(g), A, 0.0001, inf)

%T = vpaintegral(P*y/(exp(y)-1), y, 0.0001, 20000) + vpaintegral(P*y/(exp(y)-1), y%, -0.0001, -inf)


%P = vpaintegral(exp(g), A, -9999999, -0.0001) +  vpaintegral(exp(g), A, 0.0001, 9999999)

%T = vpaintegral(P*y/(exp(y)-1), y, 0.0001, 9999999) + vpaintegral(P*y/(exp(y)-1), y, -0.0001, -9999999)











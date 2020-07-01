% plots what general form of j(t) NOT J(t) should look like for a variety
% of t
j_t = @(w, t) (((1)./(w.^3 + w)).* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
dom = -100:0.01:100;




%total_t = various_t_down + various_t_up;


% plots what general form of j(t) NOT J(t) should look like for a variety
% of t
%various_t_down = [-999999 -50000 -40000 -30000 -20000 -10000 -5000 -4000 -3000 -2000 -1000 -900 -800 -600 -500 -400 -100 -150 -90 -80 -70 -60 -50 -40 -30 -20 -10];
%s = size(various_t_down)
%various_t_up = -1.*flip(various_t_down);
%total_t = various_t_down + various_t_up;
total_t = linspace(-50000, 50000, 100)

hold on
for splot=total_t
    plot(dom, j_t(dom, splot));
end
hold off
    


    
    
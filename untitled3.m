y = @(x) sin(x);
x = -2*pi:0.01:2*pi;
figure
hold on
plot(x, y(x))

plot(x, y(-x))

plot(x, y(x.^2))
hold off
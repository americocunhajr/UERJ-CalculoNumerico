
clc; clear; close all

xdata = [8.025 10.170 11.202 10.736  9.092];
ydata = [8.310  6.355  3.212  0.375 -2.267];

A = [xdata.^2; xdata.*ydata; ydata.^2; xdata; ydata]'
b = - ones(size(xdata))';

x = A\b

A1 = x(1); B1 = x(2); C1 = x(3); D1 = x(4); E1 = x(5);

figure(1)
ezplot(@(x, y) A1*x.^2 + B1*x.*y + C1*y.^2 + D1*x + E1*y + 1,[-15 15 -10 10])
hold on
plot(xdata,ydata,'om')
hold off
xlabel('x')
ylabel('y')
set(gca,'FontSize',18)

A = [xdata(2:4).^2; xdata(2:4).*ydata(2:4); ydata(2:4).^2; xdata(2:4); ydata(2:4)]';
b = - ones(size(xdata(2:4)))';

x = A\b

A2 = x(1); B2 = x(2); C2 = x(3); D2 = x(4); E2 = x(5);

figure(2)
ezplot(@(x, y) A1*x.^2 + B1*x.*y + C1*y.^2 + D1*x + E1*y + 1,[-15 15 -12 12])
hold on
ezplot(@(x, y) A2*x.^2 + B2*x.*y + C2*y.^2 + D2*x + E2*y + 1,[-15 15 -12 12])
plot(xdata,ydata,'om')
hold off
xlabel('x')
ylabel('y')
set(gca,'FontSize',18)
clc
clear

m = 10;
xdata = randn(m,1);
ydata = -2*xdata + 1 + randn(size(xdata));

A = [sum(xdata.^2) sum(xdata); sum(xdata) m];
b = [sum(xdata.*ydata); sum(ydata)];
x = A\b;

xfit = min(xdata):0.01:max(xdata);
yfit = x(1)*xfit + x(2);

plot(xdata,ydata,'om',xfit,yfit,'-b','LineWidth',2);
xlabel('x')
ylabel('y')
set(gca,'FontSize',18);
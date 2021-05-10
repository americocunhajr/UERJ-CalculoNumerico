clc; clear; close all

m     = 10;
xdata = [1 2 3 4 5 6 7 8 9 10];
ydata = [0.2 0.5 0.3 3.5 1.0 1.5 1.8 2.0 2.3 2.2];

E_2   = @(p) sqrt(sum(abs(p(1)*xdata + p(2) - ydata).^2)/m);
E_1   = @(p)      sum(abs(p(1)*xdata + p(2) - ydata)   )/m;
E_inf = @(p) max(abs(p(1)*xdata + p(2) - ydata));

p2   = fminsearch(E_2  ,[1 1]);
p1   = fminsearch(E_1  ,[1 1]);
pinf = fminsearch(E_inf,[1 1]);

xfit = 1:0.01:11;
y_2   = polyval(  p2,xfit);
y_1   = polyval(  p1,xfit);
y_inf = polyval(pinf,xfit);

plot(xdata,ydata,'om',xdata(4),ydata(4),'or','LineWidth',2);
hold on
plot(xfit,y_2  ,'-b','LineWidth',2);
plot(xfit,y_1  ,'--k','LineWidth',2);
plot(xfit,y_inf,'-.c','LineWidth',2);
hold off
xlabel('x')
ylabel('y')
set(gca,'FontSize',18);
legend('dados','outlier','E_2','E_1','E_{inf}')


clc
clear

  time = [0.1 0.2 0.3 0.4 0.5];
height = [5.49 -9.45 -31.39 -75.59 -113.69]*1e-2;

A = [0.5*time.^2; time; ones(size(time))]';
b = height';
x = A\b;

xfit = 0:0.01:0.5; 
yfit = 0.5*x(1)*xfit.^2 + x(2)*xfit + x(3);

plot(time,height,'om',xfit,yfit,'-b','LineWidth',2);
xlabel('tempo')
ylabel('altura')
set(gca,'FontSize',18);
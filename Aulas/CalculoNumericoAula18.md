## Cálculo Numérico (Aula 18) - Ajuste de Curvas

**MainRegressionExample1.m**
```
clc; clear;

m  = 10;
xd = randn(m,1);
yd = -2*xd + 1 + randn(size(xd));
A  = [sum(xd.^2) sum(xd); sum(xd) m];
b  = [sum(xd.*yd); sum(yd)];
x  = A\b;

xfit = min(xd):0.01:max(xd);
yfit = x(1)*xfit + x(2);

plot(xd,yd,'om','LineWidth',2);
hold on;
plot(xfit,yfit,'-b','LineWidth',2);
hold off; 
xlabel('x'); ylabel('y'); 
set(gca,'FontSize',18);
```

**MainRegressionExample2.m**
```
clc; clear;

t = [0.1 0.2 0.3 0.4 0.5];
h = [5.49 -9.45 -31.39 -75.59 -113.69]*1e-2;
A = [0.5*t.^2; t; ones(size(t))]';
b = h';
x = A\b;

xfit = 0:0.01:0.5; 
yfit = 0.5*x(1)*xfit.^2 + x(2)*xfit + x(3);

plot(t,h,'om','LineWidth',2);
hold on; 
plot(xfit,yfit,'-b','LineWidth',2);
hold off; 
xlabel('tempo'); ylabel('altura'); 
set(gca,'FontSize',18);
```

**MainRegressionExample3.m**
```
clc; clear; close all; 

m = 10; 
xd = [1 2 3 4 5 6 7 8 9 10];
yd = [0.2 0.5 0.3 3.5 1.0 1.5 1.8 2.0 2.3 2.2];

E_2   = @(p) sqrt(sum(abs(p(1)*xd+p(2)-yd).^2)/m);
E_1   = @(p)      sum(abs(p(1)*xd+p(2)-yd)   )/m;
E_inf = @(p)  max(abs(p(1)*xd+p(2)-yd));
p_2   = fminsearch(E_2  ,[1 1]);
p_1   = fminsearch(E_1  ,[1 1]);
p_inf = fminsearch(E_inf,[1 1]);

xfit  = 1:0.01:11;
y_2   = polyval(p_2  ,xfit);
y_1   = polyval(p_1  ,xfit);
y_inf = polyval(p_inf,xfit);

plot(xd,yd,'om',xd(4),yd(4),'or','LineWidth',2);
hold on
plot(xfit,y_2  ,'-b' ,'LineWidth',2);
plot(xfit,y_1  ,'--k','LineWidth',2);
plot(xfit,y_inf,'-.c','LineWidth',2);
hold off
xlabel('x'); ylabel('y'); 
set(gca,'FontSize',18);
legend('dados','outlier','E_2','E_1','E_{inf}')
```

**MainRegressionExample4.m**
```
clc; clear; close all;

dados = load('covid19_casos_rio_2020_2021.csv');

mm7 = dados;
for j=7:length(dados)
    mm7(j) = sum(dados(j-6:j))/7;
end

xdata = 1:21; ydata = mm7(xdata)';
A     = [xdata; ones(size(xdata))]';
b     = log(ydata)';
x     = A\b;
yfit  = @(z) exp(x(2))*exp(x(1)*z);

stem(dados(1:31),'oc','LineWidth',0.5);
hold on
plot(1:31,  mm7(1:31),'-.r','LineWidth',1);
plot(yfit(1:31),'-y','LineWidth',3);
plot(yfit(1:21),'-k','LineWidth',3);
hold off
xlabel('dias decorridos'); ylabel('novos casos por dia');
set(gca,'FontSize',18);
```

**MainRegressionExample5.m**
```
clc; clear; close all;

dados = load('covid19_casos_rio_2020_2021.csv');

mm7 = dados;
for j=7:length(dados)
    mm7(j) = sum(dados(j-6:j))/7;
end

xdata = 1:100; ydata = mm7(xdata)';
N     = @(x,p) p(1)*p(2)*exp(-p(1)*(x-p(3)));
D     = @(x,p) (1+exp(-p(1)*(x-p(3)))).^2;
I     = @(x,p) N(x,p)./D(x,p);
E_2   = @(p) sqrt(sum(I(xdata,p) - ydata).^2/length(ydata));
p_2   = fminsearch(E_2,[0.1 8e4 55]);
yfit  = I(0:0.1:100,p_2);

stem(dados(1:100),'oc','LineWidth',0.5);
hold on
plot(1:100    ,mm7(1:100),'-.r','LineWidth',1);
plot(0:0.1:100,yfit      ,'-k' ,'LineWidth',3);
hold off
xlabel('dias decorridos'); ylabel('novos casos por dia'); 
set(gca,'FontSize',18);
```

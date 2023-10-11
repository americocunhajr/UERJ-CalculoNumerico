## Cálculo Numérico (Aula 20) - Interpolação Polinomial

**MainInterpExamples1.m**
```
clc; clear; close all;

f     = @(x) log(x).*exp(sqrt(x))./(log(1+exp(x))+x.^3);
xd  = [1.3 2.1 4.0 5.8 8.1]; yd = f(xd);
xg = 0.1:0.01:10; yg = f(xg);

A    = [xd.^4; xd.^3; xd.^2; xd; ones(1,5)]';
xsol = A\yd';
p1   = xsol(1)*xg.^4 + xsol(2)*xg.^3 + ...
       xsol(3)*xg.^2 + xsol(4)*xg + xsol(5);
A    = [exp(-xd.^2); exp(-xd); xd.^2; xd; ones(1,5)]';
xsol = A\yd';
p2   = xsol(1)*exp(-xg.^2) + xsol(2)*exp(-xg) + ...
       xsol(3)*xg.^2 + xsol(4)*xg + xsol(5);
 
plot(xd,yd,'om','LineWidth',2);
hold on
plot(xg,yg, '--k','LineWidth',2);
plot(xg,p1,'-.r','LineWidth',2);
plot(xg,p2, '-b','LineWidth',2);
hold off
xlabel('x'); ylabel('y'); 
set(gca,'FontSize',18);
legend('dados','f(x)','p1(x)','p2(x)'); 
xlim([0 10]); ylim([0 0.5]);
```

**MainInterpExamples2.m**
```
clc; clear; close all;

xd = [1;2;4]; 
yd = [1;3;3];

A    = vander(xd)
xsol = A\yd

p = @(x) polyval(xsol, x);
xg = 0:0.01:5; 
yg = p(xg);

plot(xd,yd,'om','LineWidth',2);
plot(xg,yg,'-b','LineWidth',2);
xlabel('x'); ylabel('y'); 
set(gca,'FontSize',18);
legend('dados','p(x)','Location','south');
```

**MainInterpExampleSIR.m**
```
clc; clear; close all;

  beta   = [1/3 1/4 1/5 1/6];
  T_beta = [60 96 147 142];
coef_T   = polyfit(beta,T_beta,3);
coef_dT  = polyder(coef_T);
beta_ast = roots(coef_dT)
      p  = @(x) polyval(coef_T,x);
      x1 = 1/6:0.001:1/3;
      y1 = p(x1);

plot(beta,T_beta,'om',x1,y1,'-b');
hold on
plot([beta_ast(1) beta_ast(1)],[40 160],'--k');
plot([beta_ast(2) beta_ast(2)],[40 160],'--k');
hold off
```

**MainInterpExamples3.m**
```
clc; clear; close all;

xd = [1;2;4]; yd = [1;3;3];

L0 = @(x)  (1/3)*(x-2).*(x-4);
L1 = @(x) -(1/2)*(x-1).*(x-4);
L2 = @(x)  (1/6)*(x-1).*(x-2);
p  = @(x) yd(3)*L2(x) + yd(2)*L1(x) + yd(1)*L0(x);

xg = 0:0.01:5; yg = p(xg);

plot(xd,yd,'om','LineWidth',2);
hold on
plot(xg,L2(xg),'--r','LineWidth',1);
plot(xg,L1(xg),'-.c','LineWidth',1);
plot(xg,L0(xg), ':g','LineWidth',1);
plot(xg,yg,'-b','LineWidth',2);
plot([xd(1),xd(1)],[-3,4],'--k','LineWidth',0.5);
plot([xd(2),xd(2)],[-3,4],'--k','LineWidth',0.5);
plot([xd(3),xd(3)],[-3,4],'--k','LineWidth',0.5);
hold off
xlabel('x'); ylabel('y'); 
set(gca,'FontSize',18);
legend('dados','L2','L1','L0','p(x)','Location','south');
```

**InterpLagrange.m**
```
function y = InterpLagrange(xd,yd,x)
  n = length(xd);
  L = ones(n,length(x));
  for i = 1:n
   for j = 1:n
    if i ~= j
     L(i,:) = L(i,:).*(x-xd(j))./(xd(i)-xd(j));
    end
   end
  end
  y = yd'*L;
end
```

**MainInterpExamples3Rev.m**
```
clc; clear; close all

xd = [1; 2; 4]; 
yd = [1; 3; 3];

xg = 0:0.01:5;
yg = InterpLagrange(xd,yd,xg);

plot(xg,yg,'b',xd,yd,'or');
```

**MainInterpExamples4.m**
```
clc; clear; close all;

xd = [1;2;4]; yd = [1;3;3];
p0 = @(x)  1*ones(size(x));
p1 = @(x) p0(x) + 2*(x-1);
p2 = @(x) p1(x) - (2/3)*(x-1).*(x-2);
xg = 0:0.01:5;

plot(xd,yd,'om','LineWidth',2);
hold on
plot(xg,p0(xg),'--r','LineWidth',2);
plot(xg,p1(xg),'-.c','LineWidth',2);
plot(xg,p2(xg), '-b','LineWidth',2);
plot([xd(1),xd(1)],[-4,10],'--k','LineWidth',0.5);
plot([xd(2),xd(2)],[-4,10],'--k','LineWidth',0.5);
plot([xd(3),xd(3)],[-4,10],'--k','LineWidth',0.5);
hold off
xlabel('x'); ylabel('y'); 
set(gca,'FontSize',18);
xlim([0 5]); ylim([-4 10]);
legend('dados','p_0(x)','p_1(x)','p_2(x)','Location','south')
```

**InterpNewton.m**
```
function y = InterpNewton(x,xd,coef)
  n = length(xd);
  y = coef(n)*ones(size(x));
  for j=n-1:-1:1
    y = y.*(x - xd(j)) + coef(j);
  end
end
```

**MainInterpExamples5.m**
```

```

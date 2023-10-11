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

```

**MainInterpExamples3.m**
```

```

**MainInterpExamples4.m**
```

```

**MainInterpExamples5.m**
```

```

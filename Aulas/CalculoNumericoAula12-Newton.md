## Cálculo Numérico (Aula 12) - Método de Newton

**newton.m**
```
function [xn,iter] = newton(f,df,x0,tol,maxiter)
    iter  = 0;
    Error = inf;
    while Error > tol && iter < maxiter
         iter = iter + 1;
           dx = - f(x0)/df(x0);
         xn = x0 + dx;
        Error = abs(xn-x0);
           x0 = xn;
        printf([' iter = %3d   ',...
                ' root = %.16f ',...
                'Error = %.16f \n'],...
                iter,xn,Error);
    end
    if Error > tol
        xn = NaN;
    end
end
```

**fixedpoint.m**
```
function [xn,iter] = fixedpoint(g,x0,tol,maxiter)
     iter = 0;
    Error = inf;
    while Error > tol && iter < maxiter
        iter = iter + 1;
          xn = g(x0);
        Error = abs(xn-x0);
        x0 = xn;
        printf([' iter = %3d   ',...
                ' root = %.16f ',...
                'Error = %.16f \n'],...
                 iter,xn,Error);
    end
    if Error > tol
        xn = NaN;
    end
end
```

**bisection.m**
```
function [xm,iter] = bisection(f,a,b,tol)
    iter = 1;
      xm = 0.5*(a+b);
   Error = 0.5*abs(b-a);
   while Error > tol
      printf([' iter = %3d   ',...
              ' root = %.16f ',...
              'Error = %.16f \n'],...
              iter,xm,Error);
      if f(a)*f(xm) < 0
         b = xm;
      else
         a = xm;
      end
         xm = 0.5*(a+b);
      Error = 0.5*abs(b-a);
       iter = iter + 1;
   end
end
```

**MainNewtonExample1.m**
```
clc; clear;

x0 = 0.5; tol = 1.0e-9; maxiter = 100;
 f = @(x) x*exp(x)-1;
df = @(x) exp(x)*(1+x);
disp('Newton:')
root1 = newton(f,df,x0,tol,maxiter);

disp('Fixed Point:')
g = @(x) exp(-x);
root2 = fixedpoint(g,x0,tol,maxiter);

disp('Bisection:')
a = 0.0; b = 1.0;
root3 = bisection(f,a,b,tol);

disp('fzero do Octave:')
root4 = fzero(f,x0)
```

**MainNewtonExample2.m**
```
clc; clear;

tol = 1.0e-9; maxiter = 100;
 f = @(x) x^2 - 2;
df = @(x) 2*x;
x0 = 2.0;
disp(['Initial guess x0 = ',num2str(x0)])
root1 = newton(f,df,x0,tol,maxiter);

x0 = -2.0;
disp(['Initial guess x0 = ',num2str(x0)])
root2 = newton(f,df,x0,tol,maxiter);
```

**MainNewtonPathology1.m**
```
clc; clear;

x0 = 1.0; tol = 1.0e-6; maxiter = 20;
 f = @(x) x*exp(-x^2);
df = @(x) exp(-x^2) - 2*(x^2)*exp(-x^2);
root = newton(f,df,x0,tol,maxiter)
```

**MainNewtonPathology2.m**
```
clc; clear;

x0 = 0.5; tol = 1.0e-6; maxiter = 20;
 f = @(x) x*(1-x);
df = @(x) 1 - 2*x;
root = newton(f,df,x0,tol,maxiter)
```

**MainNewtonPathology3.m**
```
clc; clear;

x0 = 5/9; tol = 1.0e-6; maxiter = 20;
 f = @(x) - 0.74 + 0.765*x + 1.1*x^2 - 3.55*x^3;
df = @(x) 0.765 + 2.2*x - 3*3.55*x^2;
root = newton(f,df,x0,tol,maxiter)
```

**newton_plot.m**
```
function [xn,iter] = newton_plot(f,df,x0,tol,maxiter,xmin,xmax,ymin,ymax,N)
	iter = 0;
    error = inf;
    
    x = linspace(xmin,xmax,N);
    
    figure()
    plot([xmin xmax],[0 0],'k',[0 0],[ymin ymax],'k','linewidth',3);
    hold on
    plot(x,f(x),'b','linewidth',3);
    
    while error > tol && iter < maxiter
        iter = iter + 1;
        dx = - f(x0)/df(x0);
        xn = x0 + dx;
        
        pause
        plot(x0,0,'om','MarkerSize',12);
        pause
        plot([x0 x0],[0 f(x0)],'r--','linewidth',2);
        plot(x0,f(x0),'ob','MarkerSize',12);
        pause
        plot([x0 xn],[f(x0) 0],'g-','linewidth',2);
        
        error = abs(xn-x0);
        x0 = xn;
    end
    if error > tol
        xn = NaN;
    end
end
```

**MainNewtonPlot.m**
```
clc; clear; close all;

 f = @(x) x.^3-30*x.^2+2552;
df = @(x) 3*x.^2-60*x;
x0 = 3.0; tol=1.0e-3; maxiter = 4;

xmin = 0.0; xmax = 20.0; ymin = -1500; ymax =  3000;
N = 1000;

newton_plot(f,df,x0,tol,maxiter,xmin,xmax,ymin,ymax,N)
```

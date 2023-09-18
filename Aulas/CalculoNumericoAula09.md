## Cálculo Numérico (Aula 09) - Método da Bisseção

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

**MainBisectionExample1.m**
```
clc; clear;

a = 0.0; b = 2.0; tol = 1.0e-9;
f = @(x) x^2-2;
root = bisection(f,a,b,tol);
```

**MainBisectionExample2.m**
```
clc; clear;

a = 0.0; b = 20.0; tol = 1.0e-9;
f = @(x)x.^3-30*x.^2+2552;
root = bisection(f,a,b,tol);
```

**MainBisectionExample3.m**
```
clc; clear;

a = 0.0; b = 10.0; tol = 1.0e-6;
f = @(x) cos(x)*cosh(x)+1;
root = bisection(f,a,b,tol);
```

**bisection_plot.m**
```
function [xm,iter] = bisection_plot(f,a,b,tol,xmin,xmax,ymin,ymax,N)
     iter = 0;
    Error = inf;
       xm = 0.5*(a+b);
    xmesh = linspace(xmin,xmax,N);
    idx = 0;
    
    while Error > tol  
      figure(1)
      hax = axes;
      hold on
      plot([xmin xmax],[0 0],'k',[0 0],[ymin ymax],'k','linewidth',3);
      plot(xmesh,f(xmesh),'b','linewidth',3);
      saveas(gcf,['bisection_plot',num2str(idx),'.png'])
      idx = idx + 1;
      pause(1)
      line([a a],get(hax,'YLim'),'Color','r','linewidth',1,'LineStyle','--')
      line([b b],get(hax,'YLim'),'Color','r','linewidth',1,'LineStyle','--')
      plot(a,0,'om','MarkerSize',12);
      plot(b,0,'om','MarkerSize',12);
      saveas(gcf,['bisection_plot',num2str(idx),'.png'])
      idx = idx + 1;
      pause(1)
      line([xm xm],get(hax,'YLim'),'Color','g','linewidth',2)
      saveas(gcf,['bisection_plot',num2str(idx),'.png'])
      idx = idx + 1;
      hold off
        
      if f(a)*f(xm) < 0
         b = xm;
      else
         a = xm;
      end
      x0 = xm;
      xm = 0.5*(a+b);
      Error = abs(xm-x0);
      iter = iter + 1;
      pause(0.5)
    end
end
```

**MainBisectionPlot.m**
```
clc; clear; close all;

a = 0.0; b = 20.0; tol = 1.0e-1;
f = @(x) x.^3-30*x.^2+2552;

xmin = 0.0; xmax = 30.0; ymin = -1500; ymax =  3000;
N = 1000;

bisection_plot(f,a,b,tol,xmin,xmax,ymin,ymax,N)
```

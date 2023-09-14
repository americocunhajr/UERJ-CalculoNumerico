## Cálculo Numérico (Aula 10) - Iteração de Ponto Fixo

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

**MainFixedpointExample1.m**
```
clc; clear;

x0 = 0.5; tol = 1.0e-9; maxiter = 100;
g1 = @(x) exp(-x);
root1 = fixedpoint(g1,x0,tol,maxiter);
```

**MainFixedpointExample2.m**
```
clc; clear;

x0 = 0.5; tol = 1.0e-9; maxiter = 100;
g2 = @(x) (1+x)/(1+exp(x));
root2 = fixedpoint(g2,x0,tol,maxiter);
```

**MainFixedpointExample3.m**
```
clc; clear;

x0 = 0.5; tol = 1.0e-9; maxiter = 100;
g3 = @(x) x+1-x*exp(x);
root3 = fixedpoint(g3,x0,tol,maxiter);
```

**fixedpoint_plot.m**
```
function xn = fixedpoint_plot(g,x0,tol,maxiter,xmin,xmax,ymin,ymax,N)
    
    xmesh = linspace(xmin,xmax,N);
      idx = 0;
    
    figure()
    plot([xmin xmax],[0 0],'k',[0 0],[ymin ymax],'k','linewidth',3);
    hold on
    plot(xmesh,xmesh   ,'g','linewidth',3);
    plot(xmesh,g(xmesh),'b','linewidth',3);
    saveas(gcf,['fixedpoint_plot',num2str(idx),'.png'])
    idx = idx + 1;
    
    pause(1)
    plot(x0,0,'om','MarkerSize',12);
    saveas(gcf,['fixedpoint_plot',num2str(idx),'.png'])
    idx = idx + 1;
    
    pause(1)
    plot([x0 x0],[0 g(x0)],'r--','linewidth',2);
    plot(x0,g(x0)         ,'om' ,'MarkerSize',12);
    saveas(gcf,['fixedpoint_plot',num2str(idx),'.png'])
    idx = idx + 1;
    
     iter = 0;
    Error = inf;
    while Error > tol && iter < maxiter
        
        iter = iter + 1;
          xn = g(x0);
        
        pause(1)
        plot([x0 xn],[g(x0) xn],'r--','linewidth',2);
        plot(xn,xn,'om','MarkerSize',12);
        saveas(gcf,['fixedpoint_plot',num2str(idx),'.png'])
        idx = idx + 1;
        
        pause(1)
        plot([xn xn],[xn g(xn)],'r--','linewidth',2);
        plot(xn,g(xn),'om','MarkerSize',12);
        saveas(gcf,['fixedpoint_plot',num2str(idx),'.png'])
        idx = idx + 1;
        
        Error = abs(xn-x0);
        x0 = xn;
    end
    if Error > tol
        xn = NaN;
    end
end
```

**MainBisectionPlot.m**
```
clc; clear; close all;

g = @(x) exp(-x);
x0 = 0.5; tol=1.0e-1; maxiter = 5;
xmin = 0.0; xmax = 1.0; ymin = 0.0; ymax = 1.0;
N = 1000;

fixedpoint_plot(g,x0,tol,maxiter,xmin,xmax,ymin,ymax,N)
```

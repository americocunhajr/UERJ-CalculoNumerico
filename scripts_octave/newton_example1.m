
clc
clear

% Example 1
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

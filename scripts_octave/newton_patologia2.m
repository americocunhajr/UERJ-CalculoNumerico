
clc
clear

% Patologia 2
x0 = 0.5; tol = 1.0e-6; maxiter = 20;
 f = @(x) x*(1-x);
df = @(x) 1 - 2*x;
root = newton(f,df,x0,tol,maxiter);


clc
clear

% Patologia 1
x0 = 2.0; tol = 1.0e-6; maxiter = 20;
 f = @(x) x*exp(-x^2);
df = @(x) exp(-x^2) - 2*(x^2)*exp(-x^2);
root = newton(f,df,x0,tol,maxiter);

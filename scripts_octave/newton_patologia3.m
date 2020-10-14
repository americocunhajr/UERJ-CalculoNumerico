
clc
clear

% Patologia 3
x0 = 5/9; tol = 1.0e-6; maxiter = 20;
 f = @(x) - 0.74 + 0.765*x + 1.1*x^2 - 3.55*x^3;
df = @(x) 0.765 + 2.2*x - 3*3.55*x^2;
root = newton(f,df,x0,tol,maxiter);


clc
clear

% Example 2
tol = 1.0e-9; maxiter = 10;
 f = @(x) x^2 - 2;
df = @(x) 2*x;
x0 = 2.0;
root1 = newton(f,df,x0,tol,maxiter);
x0 = -2.0;
root2 = newton(f,df,x0,tol,maxiter);

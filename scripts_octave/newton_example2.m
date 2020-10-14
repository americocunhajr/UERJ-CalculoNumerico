
clc
clear

% Example 2
tol = 1.0e-9; maxiter = 100;
 f = @(x) x^2 - 2;
df = @(x) 2*x;
x0 = 2.0;
disp(['Initial guess x0 = ',num2str(x0)])
root1 = newton(f,df,x0,tol,maxiter);

x0 = -2.0;
disp(['Initial guess x0 = ',num2str(x0)])
root2 = newton(f,df,x0,tol,maxiter);


clc
clear

% Example 2
x0 = 0.5; tol = 1.0e-9; maxiter = 100;
g2 = @(x) (1+x)/(1+exp(x));
root2 = fixedpoint(g2,x0,tol,maxiter);
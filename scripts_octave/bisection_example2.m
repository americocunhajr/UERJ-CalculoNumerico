
clc
clear

% example 2
a = 21.0; b = 29.0; tol = 1.0e-9;
f = @(x)x.^3-30*x.^2+2552;
root = bisection(f,a,b,tol);

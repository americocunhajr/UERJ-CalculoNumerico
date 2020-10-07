
clc
clear

% example 1
a = 0.0; b = 1.0; tol = 1.0e-9;
f = @(x) x^2-2;
root = bisection(f,a,b,tol);


clc
clear

% example 3
a = 0.0; b = 10.0; tol = 1.0e-6;
f = @(x) cos(x)*cosh(x)+1; 
root = bisection(f,a,b,tol);

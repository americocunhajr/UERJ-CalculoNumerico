
clc
clear
close all

% Example 3
x0 = 0.5; tol = 1.0e-3; maxiter = 100;
g3 = @(x) x+1-x*exp(x);
root3 = fixedpoint(g3,x0,tol,maxiter);

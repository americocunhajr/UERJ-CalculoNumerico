## Cálculo Numérico (Aula 09) - Métodos Iterativos para Equações Escalares

**MainIterativeMethod.m**
```
clc; clear;

g = @(x) exp(-x)*(x + 1)/(exp(-x) + 1);
x0 = 0.5; tol = 1.0e-9; maxiter = 10;
iter = 0; Error = Inf;

while Error > tol && iter < maxiter
   iter = iter + 1;
   xnew = g(x0);
   Error = abs(xnew-x0);
   x0 = xnew;
   printf([' iter = %3d   ',...
           ' root = %.16f ',...
           'Error = %.16f \n'],...
           iter,xnew,Error);
end
```

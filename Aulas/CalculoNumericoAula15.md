## Cálculo Numérico (Aula 15) - Eliminação gaussiana com pivotamento

**backwardsub.m**
```
function x = backwardsub(A,b)
   n = length(b);
   x = zeros(n,1);
   for i = n:-1:1
      x(i) = b(i);
      for j = i+1:n
         x(i) = x(i) - A(i,j)*x(j);
      end
      x(i) = x(i)/A(i,i);
   end
end
```

**gauss.m**
```
function [x,A,b] = gauss(A,b)
   n = length(b);
   for k=1:n-1
      for i=k+1:n
         Lik = -A(i,k)/A(k,k);
         for j=1:n
            A(i,j) = A(i,j) + Lik*A(k,j);
         end
         b(i) = b(i) + Lik*b(k);
      end
   end
   x = backwardsub(A,b);
end
```

**PivotingP.m**
```
function [A,b] = PivotingP(A,b,n,k)
      pivot = abs(A(k,k));
      row   = k;
      for i=k+1:n
        if abs(A(i,k)) > pivot
            pivot = abs(A(i,k));
            row   = i;
        end
      end
      for j=k:n
         swap     = A(row,j);
         A(row,j) = A(k,j);
         A(k,j)   = swap;
      end
      swap   = b(row);
      b(row) = b(k);
      b(k)   = swap;
end
```

**gaussPivotingP.m**
```
function [x,A,b] = gaussPivotingP(A,b)
   n = length(b);
   for k=1:n-1
      [A,b] = PivotingP(A,b,n,k);
      for i=k+1:n
         Lik = -A(i,k)/A(k,k);
         for j=1:n
            A(i,j) = A(i,j) + Lik*A(k,j);
         end
         b(i) = b(i) + Lik*b(k);
      end
   end
   x = backwardsub(A,b);
end
```

**MainGaussPivotingExample1.m**
```
clc; clear;

A = [1e-16 10; 5 -6]
b = [10+1e-16; -1]

x = gauss(A,b)
```

**MainGaussPivotingExample2.m**
```
clc; clear;

A = [5 -6; 1e-16 10;]
b = [-1; 10+1e-16]

x = gauss(A,b)
```

**MainGaussPivotingExample3.m**
```
clc; clear;

A = [1e-16 10; 5 -6]
b = [10+1e-16; -1]

x = gaussPivotingP(A,b)
```

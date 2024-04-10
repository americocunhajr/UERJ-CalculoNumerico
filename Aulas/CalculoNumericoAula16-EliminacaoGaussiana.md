## Cálculo Numérico (Aula 16) - Eliminação gaussiana

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

**MainFullExample1.m**
```
clc; clear;

A = [2 1 -1; -3 -1 2; -2 1 2]
b = [8; -11; -3]

[x,A,b] = gauss(A,b)
```

**MainFullExample2.m**
```
clc; clear;

format long

A = [1 2 3 4; 2 1 4 3; 3 2 1 4; 4 3 2 1]
b = [10; 10; 10; 10]

[x,A,b] = gauss(A,b)
```

**MainFullExample3.m**
```
clc; clear;

format short

A = [1 1 1; 1 1 2; 1 2 2]
b = [1; 2; 1]

[x,A,b] = gauss(A,b)
```

**MainFlopsGauss.m**
```
clc; clear;

% FLOPS
FLOPS2011 = 12e9;
FLOPS2021 = 52e9;

% prefix
min  = 60;
hour = 60*min;
day  = 24*hour;
year = 365*day;


% matrix dimension
n = 10^8;

disp('matrix dimension')
disp(n)
disp('')
disp('Gaussian Elimination')
flops_gauss = 2/3*n^3 + n^2
disp('')
time_gauss_2011_seg_ = flops_gauss/FLOPS2011
time_gauss_2011_min_ = flops_gauss/FLOPS2011/min
time_gauss_2011_hour = flops_gauss/FLOPS2011/hour
time_gauss_2011_day_ = flops_gauss/FLOPS2011/day
time_gauss_2011_year = flops_gauss/FLOPS2011/year
disp('')    
time_gauss_2021_seg_ = flops_gauss/FLOPS2021
time_gauss_2021_min_ = flops_gauss/FLOPS2021/min
time_gauss_2021_hour = flops_gauss/FLOPS2021/hour
time_gauss_2021_day_ = flops_gauss/FLOPS2021/day
time_gauss_2021_year = flops_gauss/FLOPS2021/year
```

**MainMemoryFull.m**
```
clc; clear;

% prefix
k = 1024;
M = 1024*k;
G = 1024*M;
T = 1024*G;
P = 1024*T;

% memory of a double (8 bytes)
MEM_DBL = 8;

% matrix dimension
n = 10^8;

disp('matrix dimension')
disp(n)
disp('')
disp('full system')
full = n^2 + 2*n
disp('')
mem_full_bytes_ = full*MEM_DBL
mem_full_kbytes = full*MEM_DBL/k
mem_full_Mbytes = full*MEM_DBL/M
mem_full_Gbytes = full*MEM_DBL/G
mem_full_Tbytes = full*MEM_DBL/T
mem_full_Pbytes = full*MEM_DBL/P
```

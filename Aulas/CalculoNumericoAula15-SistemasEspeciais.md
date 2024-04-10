## Cálculo Numérico (Aula 15) - Alguns sistemas lineares especiais

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

**forwardsub.m**
```
function x = forwardsub(A,b)
   n = length(b);
   x = zeros(n,1);
   for i = 1:n
      x(i) = b(i);
      for j = 1:i-1
         x(i) = x(i) - A(i,j)*x(j);
      end
      x(i) = x(i)/A(i,i);
   end
end
```

**MainTriangularExample1.m**
```
clc; clear;

n = 5;

A = triu(ones(n,n));
b = A*ones(n,1);
tic; x = backwardsub(A,b); toc;
disp(x)

A = tril(ones(n,n)); 
b = A*ones(n,1);
tic; x = forwardsub(A,b); toc;
disp(x)
```

**MainTriangularFlops.m**
```
clc; clear ;

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
disp('trinagular system')
flops_triangular = n^2
disp('')
time_trinagular_2011_seg_ = flops_triangular/FLOPS2011
time_trinagular_2011_min_ = flops_triangular/FLOPS2011/min
time_trinagular_2011_hour = flops_triangular/FLOPS2011/min
time_trinagular_2011_day_ = flops_triangular/FLOPS2011/day
time_trinagular_2011_year = flops_triangular/FLOPS2011/year
disp('')    
time_trinagular_2021_seg_ = flops_triangular/FLOPS2021
time_trinagular_2021_min_ = flops_triangular/FLOPS2021/min
time_trinagular_2021_hour = flops_triangular/FLOPS2021/min
time_trinagular_2021_day_ = flops_triangular/FLOPS2021/day
time_trinagular_2021_year = flops_triangular/FLOPS2021/year
disp('')
disp('diagonal system')
flops_diagonal = n
disp('')
time_diagonal_2011_seg_ = flops_diagonal/FLOPS2011
time_diagonal_2011_min_ = flops_diagonal/FLOPS2011/min
time_diagonal_2011_hour = flops_diagonal/FLOPS2011/min
time_diagonal_2011_day_ = flops_diagonal/FLOPS2011/day
time_diagonal_2011_year = flops_diagonal/FLOPS2011/year
disp('')    
time_diagonal_2021_seg_ = flops_diagonal/FLOPS2021
time_diagonal_2021_min_ = flops_diagonal/FLOPS2021/min
time_diagonal_2021_hour = flops_diagonal/FLOPS2021/min
time_diagonal_2021_day_ = flops_diagonal/FLOPS2021/day
time_diagonal_2021_year = flops_diagonal/FLOPS2021/year
```

**MainTriangularMemory.m**
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
disp('trinagular system')
triangular = n*(n+1)/2 + 2*n
disp('')
mem_trinagular_bytes_ = triangular*MEM_DBL
mem_trinagular_kbytes = triangular*MEM_DBL/k
mem_trinagular_Mbytes = triangular*MEM_DBL/M
mem_trinagular_Gbytes = triangular*MEM_DBL/G
mem_trinagular_Tbytes = triangular*MEM_DBL/T
mem_trinagular_Pbytes = triangular*MEM_DBL/P
disp('')
disp('diagonal system')
diagonal   = 3*n
disp('')
mem_diagonal_bytes_ = diagonal*MEM_DBL
mem_diagonal_kbytes = diagonal*MEM_DBL/k
mem_diagonal_Mbytes = diagonal*MEM_DBL/M
mem_diagonal_Gbytes = diagonal*MEM_DBL/G
mem_diagonal_Tbytes = diagonal*MEM_DBL/T
mem_diagonal_Pbytes = diagonal*MEM_DBL/P
```

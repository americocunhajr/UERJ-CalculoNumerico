## Cálculo Numérico (Aula 16) - Decomposição LU

**MainLU_Example1.m**
```
clc; clear;

A = [-2 0 1; 1 3 1; 1 2 0]

[L,U] = lu(A)
A-L*U
```

**MainLU_Example2.m**
```
clc; clear;

A = [10 -7 0; -3 2 6; 5 -1 5]

[L,U,P] = lu(A)
P*A-L*U
```

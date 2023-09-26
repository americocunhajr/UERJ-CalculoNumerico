## Cálculo Numérico (Aula 12) - Como resolver sistemas lineares?

**cramer.m**
```
function x = cramer(A,b)
    n    = length(b);
    x    = zeros(n,1);
    detA = myDet(A);
    if detA == 0.0
        error('matriz singular')
    end
    for j = 1:n
        Aj      = A;
        Aj(:,j) = b;
        x(j)    = myDet(Aj)/detA;
    end
end
```

**MyDet.m**
```
function detA = myDet(A)
    if isscalar(A)
        detA = A;
        return
    end
    detA   = 0.0;
    toprow = A(1,:);
    A(1,:) = [];
    for i = 1:size(A,2)
        Ai      = A;
        Ai(:,i) = [];
        detA    = detA +(-1)^(i+1)*toprow(i)*myDet(Ai);
    end
end
```

**MainCramerExample1.m**
```
clc; clear;

n = 5;

A = eye(n,n)
b = ones(n,1)

tic; x = cramer(A,b); toc;

disp('x=')
disp(x)
```

**MainCramerExample2.m**
```
clc; clear;

A = [1+eps -1;-1 1]
b = A*[1+eps;-1]

x = cramer(A,b)
```

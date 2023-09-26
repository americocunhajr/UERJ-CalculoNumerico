## Cálculo Numérico (Aula 17) - Decomposição Cholesky e outras fatorações matriciais

**Main_Cholesky.m**
```
clc; clear;

A = [4 12 -16; 12 37 -43; -16 -43 98]

G = chol(A)
A-G'*G
```

**Main_QR_SVD.m**
```
clc; clear;

A = [4 12 -16; 12 37 -43; -16 -43 98]

[Q,R] = qr(A)
A-Q*R

[U,Sigma,V] = svd(A)
A-U*Sigma*V'
```

**Main_Backslash.m**
```
clc; clear;

A = [4 12 -16; 12 37 -43; -16 -43 98]
b = [1; 1; 1]

x = A\b

G = chol(A);
x = G\(G'\b)

[Q,R] = qr(A);
x = R\(Q'*b)

[U,Sigma,V] = svd(A);
x = V*(Sigma\(U'*b))
```

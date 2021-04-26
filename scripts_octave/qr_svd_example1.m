clcclear

A = [4 12 -16; 12 37 -43; -16 -43 98]

[Q,R] = qr(A)
A-Q*R
[U,Sigma,V] = svd(A)
A-U*Sigma*V'
clcclear

A = [4 12 -16; 12 37 -43; -16 -43 98]
b = [1; 1; 1]

x = A\b

[U,Sigma,V] = svd(A)
x = V*(Sigma\(U'*b))


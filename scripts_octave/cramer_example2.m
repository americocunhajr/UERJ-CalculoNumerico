clcclearA = [1+eps -1;-1 1]
b = A*[1+eps;-1]
x = cramer(A,b)
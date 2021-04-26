clcclear
A = [10 -7 0; -3 2 6; 5 -1 5]

[L,U,P] = lu(A);
P*A-L*U
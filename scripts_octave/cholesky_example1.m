clcclear

A = [4 12 -16; 12 37 -43; -16 -43 98]

G = chol(A)
A-G'*G
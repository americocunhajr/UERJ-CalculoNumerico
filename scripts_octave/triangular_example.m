clcclearn = 15; 

A = triu(ones(n,n)); 
b = A*ones(n,1);


tic
x = backwardsub(A,b)
tocA = tril(ones(n,n)); 
b = A*ones(n,1);

tic 
x = forwardsub(A,b)
toc
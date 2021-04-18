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
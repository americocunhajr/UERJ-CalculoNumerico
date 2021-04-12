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
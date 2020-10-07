function [xnew,iter] = fixedpoint(g,x0,tol,maxiter)
	iter = 0;
    Error = inf;
    while Error > tol && iter < maxiter
        iter = iter + 1;
        xnew = g(x0);
        Error = abs(xnew-x0);
        x0 = xnew;
        fprintf([' iter = %3d   ',...
                 ' root = %.16f ',...
                 'Error = %.16f \n'],iter,xnew,Error);
    end
    if Error > tol
        xnew = NaN;
    end
return

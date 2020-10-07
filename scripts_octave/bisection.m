function [xm,iter] = bisection(f,a,b,tol)
    iter = 1;
      xm = 0.5*(a+b);
   Error = 0.5*abs(b-a);
   while Error > tol
      fprintf([' iter = %3d   ',...
               ' root = %.16f ',...
               'Error = %.16f \n'],iter,xm,Error);
      if f(a)*f(xm) < 0
         b = xm;
      else
         a = xm;
      end
         xm = 0.5*(a+b);
      Error = 0.5*abs(b-a);
       iter = iter + 1;
   end
return

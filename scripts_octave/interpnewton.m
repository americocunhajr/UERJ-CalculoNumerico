function y = interpnewton(x,xdat,coef)
   n = length(xdat);
   y = coef(n)*ones(size(x));
   for j=n-1:-1:1
      y = y.*(x - xdat(j)) + coef(j);
   end
end

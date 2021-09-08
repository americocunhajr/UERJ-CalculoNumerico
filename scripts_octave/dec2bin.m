function N2 = dec2bin(N10)
   k = 1;
   q = fix(N10/2);
   r = mod(N10,2);

   N2(k) = r;

   while q ~= 0
      k     = k + 1;
      N10   = q;
      q     = fix(N10/2);
      r     = mod(N10,2);
      N2(k) = r;
   end
   N2 = flip(N2);
end
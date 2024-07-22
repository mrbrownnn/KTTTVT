function erb = NVD17_erlang_b(A,c)

% A = offered traffic in Erlangs.
% c = number of truncked channels.

num     = A^c;
sum     = 0;
for k=0:c
   kfact    = prod(1:k);
   term     = (A^k)/kfact;
   sum      = sum + term;
end
cfact   = prod(1:c);
den     = cfact*sum;
erb     = num/den;
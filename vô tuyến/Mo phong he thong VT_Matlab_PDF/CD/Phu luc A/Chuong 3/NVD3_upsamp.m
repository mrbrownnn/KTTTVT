function out = NVD3_upsamp(in,M)

L       = length(in);
out     = zeros(1,(L-1)*M+1);

for j=1:L
   out(M*(j-1)+1)   =in(j);
end
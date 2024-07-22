function h  =   NVD3_lininterp(M)

h1          = zeros(1,(M-1));
for j=1:(M-1)
   h1(j)    = j/M;
end
h = [0,h1,1,fliplr(h1),0];
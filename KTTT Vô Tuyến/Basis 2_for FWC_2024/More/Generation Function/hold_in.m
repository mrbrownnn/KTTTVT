function output = hold_in(in,k)

output  =   [];
L       =   length(in);
b       =   ones(k,1)*in;
output  =   reshape(b,1,L*k);

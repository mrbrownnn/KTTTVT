% NVD5_ex1

w1=0; w2=0; w3=0 w4=0; % initialize state variables

for k=1:nputs
    .
    .
    .
    w0  =   w1      +           b0*x
    w1  =   -a1*w0  +   w2 +    b1*x;
    w2  =   -a2*w0  +   w3 +    b2*x;
    w3  =   -a3*w0  +   w4 +    b3*x;
    w4  =   -a4*w0  +           b4*x;
    y   =   w0;
    .
    .
    .    
end


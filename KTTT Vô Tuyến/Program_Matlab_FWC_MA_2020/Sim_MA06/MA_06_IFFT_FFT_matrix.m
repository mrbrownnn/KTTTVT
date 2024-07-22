%--------------------------------------------------------------------------
%------------------------- MA_06_IFFT_FFT_matrix  -------------------------
%--------------------------------------------------------------------------

clc
clear;
% solution 1: belong to matrix W_H & W
display('SOLUTION 1: belong to Generation OF MATRIX');
W_H 	= [1 1 1 1;
    	1 exp(j*2*pi/4) exp(j*4*pi/4) exp(j*6*pi/4); 
    	1 exp(j*4*pi/4) exp(j*8*pi/4) exp(j*12*pi/4);
    	1 exp(j*6*pi/4) exp(j*12*pi/4) exp(j*2*3*3*pi/4)];    
W_H=1/2*W_H    
 W   	= [1 1 1 1;
    	1 exp(-j*2*pi/4) exp(-j*4*pi/4) exp(-j*6*pi/4); 
    	1 exp(-j*4*pi/4) exp(-j*8*pi/4) exp(-j*12*pi/4);
    	1 exp(-j*6*pi/4) exp(-j*12*pi/4) exp(-j*2*3*3*pi/4)];
W=1/2*W
test = abs(W_H*W);
display('tich ma tran W_H*W');
disp(test);
display(' so lieu vao ma tran IFFT (W_H)');
x11 =  1:4
display(' dau ra IFFT sau khi nhan ma tran W_H (W_H*x11)');
x12 = W_H*x11'
display(' dau ra FFT sau khi nhan ma tran W');
x13 = W*x12
display(' so sanh I/O cua IFFT & FFT o dang ma tran');
test2   = x11~=round(x13')

display('SOLUTION 2: belong to Generation OF MATRIX');

% clear; 
clc;
N= 4;
W_H_2 = zeros(N);

for i =1:N
    for m= 1:N
        W_H_2(i,m) = exp(j*2*pi/N*(i-1)*(m-1));
    end
end
W_H_2 = 1/sqrt(N)*W_H_2
W_H
W_H_2~=W_H

W_2 = zeros(N);
for m =1:N
    for i= 1:N
        W_2(m,i) = exp(-j*2*pi/N*(m-1)*(i-1));
    end
end
W_2 = 1/sqrt(N)*W_2
W
W_2~=W
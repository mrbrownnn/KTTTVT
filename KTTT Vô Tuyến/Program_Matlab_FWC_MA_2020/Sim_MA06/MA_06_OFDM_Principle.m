%--------------------------------------------------------------------------
%------------------------- MA_06_OFDM_Principle  --------------------------
%--------------------------------------------------------------------------

clc;
clear;
N   = 4;  %input('Enter N =');
V   = 2;  %input('Enter V =');



 X1         = 1:N;
[W_H]       =   MA_06_IFFT_matrix(N);
[W]         =   MA_06_FFT_matrix(N); % note W=inv(W_H) W*W_H = I
[CP_insert] =   MA_06_CP_insert(N,V);
[CP_Remve]  =   MA_06_CP_Remove(N,V);

Mode = 1;

if Mode == 1

else
    X1    = 0.5*(sign(rand(1,N)-0.5)+1);
%     X1    = 2*X1-1;

end
%---------------------------------
X2  = X1';
X3  =  W_H*X2; % IFFT
X4  = X3';
X5  = X4';
X6  = CP_insert*X5;
X7  = X6';
X8  = X7';
X9  = CP_Remve*X8;
X10 = X9';
X11 = X10';
X12 = W*X11; % FFT
X13 = X12'
% ===== Check for IFFT/FFT; CP_insert_remove
% X13_T = abs(X13)
    Test_IFFT_FFT_matrix    = abs(W_H*W);
    Test_CP_inser_remove    = CP_Remve*CP_insert;
    % Test_CP_inser_remove2   = CP_insert*CP_Remve
% ===== Check for System Modeling
    X1;
    X13;
%     Test_I_O = xor(X1,X13); % Note khong dung X1~=X13
    
%==================================================
% IFFT & FFT Princeples
    % step 1: IFFT process
        data_IFFT       = sqrt(N)*ifft(X1,N);
    % step 2: add CP
%         data_IFFT=data_IFFT';
        data_IFFT_CP = [data_IFFT(N-V+1:N) data_IFFT];
    % step 3: remove CP
%         data_IFFT_CP= data_IFFT_CP';    
        data_CPR        = data_IFFT_CP(V+1:N+V);
    % step 4: IFFT process
        data_FFT        = (1/sqrt(N))*fft(data_CPR,N)


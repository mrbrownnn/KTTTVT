%--------------------------------------------------------------------------
%------------------------- MA_06_Basis_OFDM_System_Modeling1  -------------
%--------------------------------------------------------------------------

clc;
clear all;
close all;
%---------------------------------------------
FFTsize         = 4;
CPsize          = 2;
%-----------------------------------------------
% Generate for FFTsize bits: BPSK
    % solution 1:
        data    = 0.5*(sign(rand(1,FFTsize)-0.5)+1);
        data    = 2*data-1
        
%     % solution 2:
%         data         = round(rand(1,FFTsize));
%         data    = 2*data-1
%----------------------------------------------

% IFFT & FFT Princeples
    % step 1: IFFT process
        data_IFFT       = ifft(data,FFTsize)
    % step 2: add CP
        data_IFFT_CP = [data_IFFT(FFTsize-CPsize+1:FFTsize) data_IFFT];
    % step 3: remove CP
        data_CPR        = data_IFFT_CP(CPsize+1:FFTsize+CPsize);
    % step 4: IFFT process
        data_FFT        = fft(data_CPR,FFTsize)

%%%%% decision and determine error
% solution 1:
    % Hard decision
    data_des1    = zeros(1, length(data));
    for i = 1:length(data_FFT)
        if data_FFT(i) >= 0
            data_des1(i) = 1;
        else
            data_des1(i) = -1;
        end
    end
    % to determine error (comparesion)
    error_vector1        = data~=data_des1;
    % errCount & number of errors
    num_error1           = sum(error_vector1);
    BER1                 = num_error1/FFTsize

% solution 2:
    % Hard decision
    data_des2           = sign(real(data_FFT));
    % to determine error (comparesion)
    error_vector2        = data~=data_des2;
    % errCount & number of errors
    num_error2           = sum(error_vector2);
    BER2                 = num_error2/FFTsize
    
% optimal solution optimal    
    BER_op = sum(sign(real(data_FFT))~=data)/FFTsize

    
disp('      Du lieu dau vao IFFT:')
        disp(data);
disp('      Du lieu dau sau IFFT:')
        disp(data_IFFT);
        
disp('      Du lieu dau sau chen CP:')
        disp(data_IFFT_CP);
disp('      Du lieu dau sau khu CP:')
        disp(data_CPR);
disp('      Du lieu dau ra FFT:')
        disp(data_FFT);

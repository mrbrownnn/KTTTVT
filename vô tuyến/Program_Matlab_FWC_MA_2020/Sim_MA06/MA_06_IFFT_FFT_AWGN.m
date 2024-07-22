%--------------------------------------------------------------------------
%------------------------- MA_06_IFFT_FFT_AWGN  ---------------------------
%--------------------------------------------------------------------------

clc;
clear all;
close all;
%---------------------------------------------
FFTsize         = 1000;
CPsize          = 25;
snr_in_dB       = 10; 
noisePower      = 10^(-snr_in_dB/10);
%----------------------------------------------
% Generate for FFTsize bits: BPSK
        data    = 0.5*(sign(rand(1,FFTsize)-0.5)+1);
        data    = 2*data-1;
%----------------------------------------------
% IFFT & FFT Princeples
    % step 1: IFFT process
        data_IFFT       = ifft(data);
    % step 2: add CP
        data_IFFT_CP = [data_IFFT(FFTsize-CPsize+1:FFTsize) data_IFFT];
    %  step 3: AWGN channel
        tmp             = randn(1,FFTsize+CPsize);
        RV_Gausian      = tmp*noisePower;
        RxSymbols       = data_IFFT_CP + RV_Gausian;
    % step 4: remove CP
        data_CPR        = RxSymbols(CPsize+1:FFTsize+CPsize);
    % step 5: IFFT process
        data_FFT        = fft(data_CPR);        
        
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
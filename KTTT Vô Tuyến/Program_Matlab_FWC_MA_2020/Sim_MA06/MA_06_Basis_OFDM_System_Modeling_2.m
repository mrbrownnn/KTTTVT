%--------------------------------------------------------------------------
%------------------------- MA_06_Basis_OFDM_System_Modeling_2 -------------
%--------------------------------------------------------------------------

clc;
clear all;
close all;
%---------------------------------------------
FFTsize         = 8;
CPsize          = 2;
%-----------------------------------------------
% Generate for FFTsize bits: BPSK
        data    = 0.5*(sign(rand(1,FFTsize)-0.5)+1);
%         x1= rand(1,FFTsize);
%         x2= sign(x1-0.5);
%         x3=0.5*(x2+1);
        data    = 2*data-1
%----------------------------------------------

% IFFT & FFT Princeples
    % step 1: IFFT process
        data_IFFT       = ifft(data)
    % step 2: add CP
        data_IFFT_CP = [data_IFFT(FFTsize-CPsize+1:FFTsize) data_IFFT];
    % step 3: remove CP
        data_CPR        = data_IFFT_CP(CPsize+1:FFTsize+CPsize);
    % step 4: IFFT process
        data_FFT        = fft(data_CPR)

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

% for n = 1:length(SNR),
%     errCount = 0;
%     errCount1 = 0;
%     for k = 1:numRun
%         % Tao khoi du lieu Q-PSK
%         numSymbols  = FFTsize; % note
%         tmp         = round(rand(2,numSymbols));
%         tmp         = tmp*2 - 1;
%         data        = (tmp(1,:) + j*tmp(2,:))/sqrt(2);
%         inputSymbols = data;        
%         % Dieu che OFDM su dung IFFT
%         TxSamples   = sqrt(FFTsize)*ifft(inputSymbols);        
%         % Chen them CP
%         Tx_ofdm     = [TxSamples(numSymbols-CPsize+1:numSymbols) TxSamples];        
%         % qua kenh AWGN
%         tmp             = randn(2,numSymbols+CPsize);
%         complexNoise    = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
%         noisePower      = 10^(-SNR(n)/10);
%         RxSymbols       = Tx_ofdm + sqrt(noisePower)*complexNoise;        
%         % Loai bo CP
%         EstSymbols      = RxSymbols(CPsize+1:numSymbols+CPsize);        
%         % Chuyen tin hieu thu duoc sang mien tan so        
%         Y               = fft(EstSymbols,FFTsize); % dau ra cua FFT       
%         % Tach song quyet dinh cung
%         EstSymbols      = Y;
%         EstSymbols      = sign(real(EstSymbols)) + i*sign(imag(EstSymbols));        
%         EstSymbols1     = EstSymbols;        
%         EstSymbols      = EstSymbols/sqrt(2);
%         
%         errCount1       = sum(inputSymbols~=EstSymbols)        
%         
%         % Kiem tra loi
%         I               = find((inputSymbols-EstSymbols) == 0);
%         % Dem loi
%         errCount        = errCount + (numSymbols-length(I))
%     end
%     SER(n,:)             = errCount / (numSymbols*numRun);
%     SER1(n,:)             = errCount1 / (numSymbols*numRun);
% end
%--------------------------------------------------------------------------
%------------------------ MA_08_SER_ofdm ----------------------------------
%--------------------------------------------------------------------------

function SER = MA_08_SER_ofdm(SNR,numRun,FFTsize,dataType,...
                        CPsize,channelType,equalizerType)
%--------------------------------------------------------------------------
% Tinh toan ty so loi ky hieu (SER) trong OFDM
% SNR:      ty so tin hieu tren tap am
% numRun:   so lan thuc hien mo phong (so vong lap)
% FFTsize:  Kich thuoc FFT
% dataType: kieu du lieu dieu che o bang tan co so ('Q-PSK)
% CPsize:   kich thuoc tien to vong
% channelType: mo hinh kenh
       %+ channelType='0000': kenh AWGN
       %+ channelType='pedA': kenh ITU PedA co AWGN
       %+ channelType='vehA': kenh ITU VehA co AWGN
% equalizerType: phuong phap can bang kenh ('ZERO' hoac 'MMSE')
%--------------------------------------------------------------------------

numSymbols  = FFTsize;   % so ky hieu
errCount    = 0;
for k = 1:numRun
    % Tao khoi du lieu ban dau
    inputSymbols = MA_08_QPSK_data_block_gen(dataType,numSymbols);
    % Dieu che OFDM su dung IFFT
    TxSamples = sqrt(FFTsize)*ifft(inputSymbols);
    % Chen them CP
    ofdmSymbols = MA_08_addCP(TxSamples,numSymbols,CPsize);        
    % Qua kenh da duong va AWGN
    if channelType=='pedA'
        pedAchannel         = [1 10^(-9.7/20) 10^(-22.8/20)];
        channel             = pedAchannel/sqrt(sum(pedAchannel.^2));            
        H_channel           = fft(channel,FFTsize);
        RxSymbols           = filter(channel,1,ofdmSymbols);
        % add AWGN
        tmp             = randn(2,numSymbols+CPsize);
        complexNoise    = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
        noisePower      = 10^(-SNR/10);
        RxSymbols       = RxSymbols + sqrt(noisePower)*complexNoise;            
    elseif channelType=='vehA'
        vehAchannel         = [1 0 10^(-1/20) 0 10^(-9/20) 10^(-10/20) 0 0 0 10^(-15/20) 0 0 0 10^(-20/20)];
        channel             = vehAchannel/sqrt(sum(vehAchannel.^2));
        H_channel           = fft(channel,FFTsize);
        RxSymbols           = filter(channel,1,ofdmSymbols);
        % add AWGN
        tmp             = randn(2,numSymbols+CPsize);
        complexNoise    = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
        noisePower      = 10^(-SNR/10);
        RxSymbols       = RxSymbols + sqrt(noisePower)*complexNoise;
        
    elseif channelType=='AWGN' % AWGN channel
        tmp             = randn(2,numSymbols+CPsize);
        complexNoise    = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
        noisePower      = 10^(-SNR/10);
        RxSymbols       = ofdmSymbols + sqrt(noisePower)*complexNoise;
    end
    
    % Loai bo CP
    EstSymbols = MA_08_removeCP(RxSymbols,numSymbols,CPsize);
    % Chuyen tin hieu thu duoc sang mien tan so
    Y = fft(EstSymbols,FFTsize);        
    % Can bang kenh        
    if channelType~='AWGN'
        if equalizerType =='ZERO'
            YY = Y./H_channel;
        elseif equalizerType =='MMSE'
            C = conj(H_channel)./(conj(H_channel).*H_channel + 10^(-SNR/10));
            YY = Y.*C;
        end
    elseif channelType=='AWGN'
        YY = Y;            
    end
    % Tach song quyet dinh cung
    EstSymbols = YY;
    EstSymbols = sign(real(EstSymbols)) + i*sign(imag(EstSymbols));
    EstSymbols = EstSymbols/sqrt(2);
    % Kiem tra loi
    I = find((inputSymbols-EstSymbols) == 0);
    % Tinh toan loi
    errCount = errCount + (numSymbols-length(I));
end
SER = errCount / (numSymbols*numRun);
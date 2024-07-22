function SER = NVD_SER_ofdm_ChannelCode(SNR,numRun,FFTsize,dataType,...
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
%--------------------------------------------------------------------------
NumBits         = FFTsize*numRun;
%--------------------------------------------------------------------------

mode_Sim        = 2;
Codding_Type    = 1;
if mode_Sim ==2
    if Codding_Type == 1
        k0      = 1;
        G       = [1 1 1;1 0 1];
    elseif Codding_Type == 2        
        k0      = 1;
        G       = [1 1 1 1 0 0 1;1 0 1 1 0 1 0];
    else
        k0      = 2;
        G       = [0 0 1 0 1 0 0 1;0 0 0 0 0 0 0 1;1 0 0 0 0 0 0 1];
    end
end
%--------------------------------------------------------------------------

%==========================================================================
for k = 1:numRun    
    % Tao khoi du lieu ban dau
    data            = 0.5*(sign(rand(1,numSymbols)-0.5)+1);
    data2           = 2*data-1;    
    %------------------------------------------------------------------
    if mode_Sim ==2
        inputSymbols        = NVD_COV_Encoder(G,k0,data);
        inputSymbols        = 2*inputSymbols-1;                      
    else
        inputSymbols        = 2*data-1;
    end
    %------------------------------------------------------------------

    % Dieu che OFDM su dung IFFT
        TxSamples       = sqrt(length(inputSymbols))*ifft(inputSymbols,length(inputSymbols));
        numSymbols      = length(inputSymbols);
        % Chen them CP
        Tx_ofdm         = [TxSamples(numSymbols-CPsize+1:numSymbols) TxSamples];
        
        % qua kenh AWGN
        numSymbols_2    = length(inputSymbols);
        tmp             = randn(1,numSymbols_2+CPsize);
        noisePower      = 10^(-SNR/10);
        RxSymbols       = Tx_ofdm + sqrt(noisePower)*tmp;        
        % Loai bo CP
        EstSymbols_1      = RxSymbols(CPsize+1:numSymbols_2+CPsize);        
        % Chuyen tin hieu thu duoc sang mien tan so        
        Y               = fft(EstSymbols_1,length(EstSymbols_1)); % dau ra cua FFT
%     
%     % Dieu che OFDM su dung IFFT
%     TxSamples = sqrt(FFTsize)*ifft(inputSymbols);
%     % Chen them CP
%     ofdmSymbols = addCP(TxSamples,numSymbols,CPsize);        
%     % Qua kenh da duong va AWGN
%     if channelType=='pedA'
%         pedAchannel         = [1 10^(-9.7/20) 10^(-22.8/20)];
%         channel             = pedAchannel/sqrt(sum(pedAchannel.^2));            
%         H_channel           = fft(channel,FFTsize);
%         RxSymbols           = filter(channel,1,ofdmSymbols);
%         % add AWGN
%         tmp             = randn(2,numSymbols+CPsize);
%         complexNoise    = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
%         noisePower      = 10^(-SNR/10);
%         RxSymbols       = RxSymbols + sqrt(noisePower)*complexNoise;            
%     elseif channelType=='vehA'
%         vehAchannel         = [1 0 10^(-1/20) 0 10^(-9/20) 10^(-10/20) 0 0 0 10^(-15/20) 0 0 0 10^(-20/20)];
%         channel             = vehAchannel/sqrt(sum(vehAchannel.^2));
%         H_channel           = fft(channel,FFTsize);
%         RxSymbols           = filter(channel,1,ofdmSymbols);
%         % add AWGN
%         tmp             = randn(2,numSymbols+CPsize);
%         complexNoise    = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
%         noisePower      = 10^(-SNR/10);
%         RxSymbols       = RxSymbols + sqrt(noisePower)*complexNoise;
%         
%     elseif channelType=='AWGN' % AWGN channel
%         tmp             = randn(2,numSymbols+CPsize);
%         complexNoise    = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
%         noisePower      = 10^(-SNR/10);
%         RxSymbols       = ofdmSymbols + sqrt(noisePower)*complexNoise;
%     end
%     
%     % Loai bo CP
%     EstSymbols = removeCP(RxSymbols,numSymbols,CPsize);
%     % Chuyen tin hieu thu duoc sang mien tan so
%     Y = fft(EstSymbols,FFTsize);        
%     % Can bang kenh        
%     if channelType~='AWGN'
%         if equalizerType =='ZERO'
%             YY = Y./H_channel;
%         elseif equalizerType =='MMSE'
%             C = conj(H_channel)./(conj(H_channel).*H_channel + 10^(-SNR/10));
%             YY = Y.*C;
%         end
%     elseif channelType=='AWGN'
%         YY = Y;            
%     end
    
%==========================================================================       
        % Tach song quyet dinh cung
        EstSymbols_1      = Y;
        EstSymbols_1      = sign(real(EstSymbols_1)); 
        for ii = 1:length(EstSymbols_1)
            if EstSymbols_1(ii)>0
                Decis(ii)= 1;
            else
                Decis(ii)= 0;
            end
        end
        %------------------------------------------------------------------
        if mode_Sim==2
            EstSymbols    = NVD_COV_Dencoder(G,k0,Decis);            
        else
            EstSymbols  =  EstSymbols_1;
        end        
        %------------------------------------------------------------------        
        % Kiem tra loi
        if mode_Sim==2
            I               = find((data-EstSymbols) == 0);
        else
            I               = find((data2-EstSymbols) == 0);
        end
        % Dem loi
        errCount        = errCount + (FFTsize-length(I));
%==========================================================================   
end
SER = errCount / (numSymbols*numRun);
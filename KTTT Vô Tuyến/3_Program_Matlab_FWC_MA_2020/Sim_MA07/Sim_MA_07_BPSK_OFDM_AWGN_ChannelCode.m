%==========================================================================
%================= Sim_MA_07_BPSK_OFDM_AWGN_ChannelCode ===================
%==========================================================================

clc;
clear all;
close all;

SNR             = [0:1:9];
FFTsize         = 512;
CPsize          = 20;
numRun          = 10^3;             % Note
NumBits         = FFTsize*numRun;
%==========================================================================
mode_Sim        = 2;    % 1 for No channel code (OFDM without channel coding); 
                        % 2 for channel coding (OFDM with channel coding)
Codding_Type    = 1;    % Code Generation Matrix

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
%==========================================================================
for n = 1:length(SNR),
    errCount = 0;
    for k = 1:numRun
        % Generated BPSK data
        numSymbols      = FFTsize;
        data            = 0.5*(sign(rand(1,numSymbols)-0.5)+1);
        data2           = 2*data-1;
        %------------------------------------------------------------------
        if mode_Sim ==2 % Convolution code Encoder
            inputSymbols        = FWC_COV_Encoder(G,k0,data);
            inputSymbols        = 2*inputSymbols-1;                      
        else
            inputSymbols        = 2*data-1;
        end
        %------------------------------------------------------------------        
        % IFFT (OFDM Modulation)
        TxSamples       = sqrt(length(inputSymbols))*ifft(inputSymbols,length(inputSymbols));
        numSymbols      = length(inputSymbols);
        % Insert CP
        Tx_ofdm         = [TxSamples(numSymbols-CPsize+1:numSymbols) TxSamples];        
        % AWGN channel
        numSymbols_2    = length(inputSymbols);
        tmp             = randn(1,numSymbols_2+CPsize);
        noisePower      = 10^(-SNR(n)/10);
        RxSymbols       = Tx_ofdm + sqrt(noisePower)*tmp;        
        % Remove CP
        EstSymbols_1      = RxSymbols(CPsize+1:numSymbols_2+CPsize);        
        % IFT (OFDM Demodulation)
        Y               = fft(EstSymbols_1,length(EstSymbols_1));
        % Detection and decide
        EstSymbols_1      = Y;
        EstSymbols_1      = sign(real(EstSymbols_1));        
        for i = 1:length(EstSymbols_1)
            if EstSymbols_1(i)>0
                Decis(i)= 1;
            else
                Decis(i)= 0;
            end
        end
        %------------------------------------------------------------------
        if mode_Sim==2
            %---- Convolution code Decoder
            EstSymbols    = FWC_COV_Dencoder(G,k0,Decis);            
        else
            EstSymbols  =  EstSymbols_1;
        end        
        %------------------------------------------------------------------        
        % Check for Error
        if mode_Sim==2
            I               = find((data-EstSymbols) == 0);
        else
            I               = find((data2-EstSymbols) == 0);
        end
        % Countered Errors
        errCount        = errCount + (FFTsize-length(I));
    end
    SER(n,:)            = errCount / (FFTsize*numRun);
end

%==========================================================================
if mode_Sim ==2    
    save MA_07_BPSK_OFDM_CC_AWGN.mat;
    figure(1);
    G = semilogy(SNR,SER,'-vr');
    title(['M« pháng SER hÖ thèng BPSK OFDM trong kªnh AWGN voi m· hãa kªnh; Sè bit m« pháng = ',...
        num2str(NumBits),' bits '],'FontName','.VnTime','color','b','FontSize',16);
    LT=legend('OFDM - kªnh AWGN cã m· hãa kªnh');
    set(LT,'fontname','.Vntime','fontsize',16);    
else    
    save MA_07_BPSK_OFDM_NoCC_AWGN.mat;
    figure(1);
    G = semilogy(SNR,SER,'-ob');
    title(['M« pháng SER hÖ thèng BPSK OFDM trong kªnh AWGN; Sè bit m« pháng = ',num2str(NumBits),' bits ',...
        ],'FontName','.VnTime','color','b','FontSize',16);
    LT=legend('OFDM - kªnh AWGN kh«ng m· hãa kªnh');
    set(LT,'fontname','.Vntime','fontsize',16);    
end
    set(G,'LineWidth',1.5); 
    AX = gca;
    set(AX,'fontsize',14);
    X=xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',14,'color','b');
    Y=ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',14,'color','b');
    grid on;
%----------------------------------------------------------------------
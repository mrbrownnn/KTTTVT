function SER = SER_ifdma(SNR,numRun,inputBlockSize,FFTsize,dataType,...
                         CPsize,subband,channelType,equalizerType)
%--------------------------------------------------------------------------
% Tinh toan ty so loi ky hieu (SER) trong SC-FDMA che do dan xen (phan tan)
% SNR: ty so tin hieu tren tap am
% numRun: so lan thuc hien mo phong (so vong lap)
% FFTsize: Kich thuoc FFT
% dataType: kieu du lieu dieu che o bang tan co so ('Q-PSK hoac '16QAM')
% CPsize: kich thuoc tien to vong
% subband: 
% channelType: mo hinh kenh
       %+ channelType='0000': kenh AWGN
       %+ channelType='pedA': kenh ITU PedA co AWGN
       %+ channelType='vehA': kenh ITU VehA co AWGN
% equalizerType: phuong phap can bang kenh ('ZERO' hoac 'MMNSE')

%--------------------------------------------------------------------------
numSymbols = FFTsize;
Q = numSymbols/inputBlockSize;
for n = 1:length(SNR),
    errCount = 0;
    for k = 1:numRun,
        % Tao khoi du lieu ban dau
        inputSymbols = MA_09_data_block_gen(dataType,inputBlockSize);
        % Tien ma hoa DFT
        inputSymbols_freq = fft(inputSymbols);
        % Khoi tao cac song mang con dau ra
        inputSamples = zeros(1,numSymbols);
        % Sap xep song mang con
        inputSamples(1+subband:Q:numSymbols) = inputSymbols_freq;
        % Chuyen tro lai mien thoi gian
        inputSamples = ifft(inputSamples);
        % Thêm CP
        TxSamples = MA_09_addCP(inputSamples,numSymbols,CPsize);
        % Qua kenh da duong                
        [RxSamples H_channel]= MA_09_channelFiltering(TxSamples,...
                                                channelType,FFTsize);
        % Tao va cong vao AWGN
        tmp = randn(2, numSymbols+CPsize);
        complexNoise = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
        noisePower = 10^(-SNR(n)/10);
        RxSamples = RxSamples + sqrt(noisePower/Q)*complexNoise;
        % Loai bo CP
        RxSamples = MA_09_removeCP(RxSamples,numSymbols,CPsize);
        % Chuyen tin hieu sang mien tan so
        Y = fft(RxSamples, FFTsize);
        % Giai sap xep song mang con        
        Y = Y(1+subband:Q:numSymbols);
        % Tim dap ung kenh cho cac song mang con dan xen
        H_eff = H_channel(1+subband:Q:numSymbols);
        % Can bang kenh
        if channelType~='0000'
            Y = MA_09_equalizer(Y,H_eff,equalizerType,SNR(n));
        end
        % Chuyen tin hieu tro lai mien thoi gian
        EstSymbols = ifft(Y);
        % Quyet dinh cung
        EstSymbols = sign(real(EstSymbols)) + i*sign(imag(EstSymbols));
        EstSymbols = EstSymbols/sqrt(2);
        % Tim loi
        I = find((inputSymbols-EstSymbols) == 0);
        errCount = errCount + (inputBlockSize-length(I));
    end
    SER(n,:) = errCount / (inputBlockSize*numRun);
end
function SER = SER_scfde(SNR,numRun,FFTsize,dataType,...
                         CPsize,channelType,equalizerType)
%--------------------------------------------------------------------------
% Tinh toan ty so loi ky hieu (SER) trong SC/FDE
% SNR       : ty so tin hieu tren tap am
% numRun    : so lan thuc hien mo phong (so vong lap)
% FFTsize   : Kich thuoc FFT
% dataType  : kieu du lieu dieu che o bang tan co so ('Q-PSK hoac '16QAM')
% CPsize    : kich thuoc tien to vong
% channelType: mo hinh kenh
            % + channelType='0000': kenh AWGN
            % + channelType='pedA': kenh ITU PedA co AWGN
            % + channelType='vehA': kenh ITU VehA co AWGN
% equalizerType : phuong phap can bang kenh ('ZERO' hoac 'MMSE')

%--------------------------------------------------------------------------
numSymbols = FFTsize; % so ky hieu
for n = 1:length(SNR)
    errCount  = 0;
    for k = 1:numRun
        % Tao khoi du lieu ban dau
        inputSymbols        = data_block_gen(dataType,numSymbols);
        % Chen them CP
        TxSymbols           = addCP(inputSymbols,numSymbols,CPsize);
        % Qua kenh da duong
        [RxSymbols H_channel] = channelFiltering(TxSymbols,...
                                                 channelType,FFTsize);
        % Tao va cong vao AWWGN
        tmp                 = randn(2,numSymbols+CPsize);
        complexNoise        = (tmp(1,:) + i*tmp(2,:))/sqrt(2);
        noisePower          = 10^(-SNR(n)/10);
        RxSymbols           = RxSymbols + sqrt(noisePower)*complexNoise;
        % Loai bo CP
        EstSymbols          = removeCP(RxSymbols,numSymbols,CPsize);
        % Chuyen tin hieu thu duoc sang mien tan so
        Y                   = fft(EstSymbols, FFTsize);
        % Can bang kenh
        if channelType~='0000'
            Y               = equalizer(Y,H_channel,equalizerType,SNR(n));
        end
        % Chuyen tin hieu tro lai mien thoi gian
        EstSymbols          = ifft(Y);
        % Tach song quyet dinh cung
        EstSymbols = sign(real(EstSymbols)) + i*sign(imag(EstSymbols));
        EstSymbols = EstSymbols/sqrt(2);
        % Kiem tra loi
        I = find((inputSymbols-EstSymbols) == 0);
        % Tinh toan loi
        errCount = errCount + (numSymbols-length(I));
    end
    SER(n,:) = errCount / (numSymbols*numRun);
end
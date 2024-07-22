% function NVD_MIMO_LLSE
% SER of V-BLAST, ZF and LLSE receivers for (M,N)=(8,12) and 16-QAM modulation.
% For each Eb/N0 value, we perform 10.000 iteration.

clear all;
close all;

% 16 point QAM is used
partition       =   [ -2,0,2 ];
xcodebook       =   [-3,-1,1,3 ];
ycodebook       =   xcodebook;
M               =   8;                  % no of transmitter antennas 8 (2)
N               =   12;                 % no of receiver antennas   12 (4)

Es              =   2*sum(xcodebook * xcodebook')/size(xcodebook,2); % average symbol energy per antenna
Eb              =   Es/(2*log2(size(xcodebook,2))); % transmitted bit energy per antenna
EbN0            =   -10:2:4;
N0              =   Eb./10.^(EbN0/10); % Noise power

%17
F               =   100; % no of trials at a given noise level

for T=1:length(EbN0) % T loop; choose SNR level
    tic    
    %%========================================= (2)
    % 33: % LLSE algorithm
    ser         =   0; % block error event counter
    sbler(T)    =   0; % block error rate
    
    for f=1:F
        
        %%=========================================
        % Common
        a       =   randsrc(M,1,xcodebook)+j*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M)+j*randn(N,M)) / sqrt(2);
        v       =   (randn(N,1)+j*randn(N,1))* sqrt(N0(T)/2);
        r       =   H*a+v;        
        
        %%========================================= (2)
        % 48: %Copy r and H for LLSE Receiver
        sH      =   H;
        sr      =   r;        

        %%========================================= (2)        
        % 121: % LLSE Receiver
        sy          =   Es*sH'*pinv(Es*sH*sH'+N0(T)*eye(N))*sr;
        for J=1:M
            [ o,n1(J)]  =   quantiz(real(sy(J)),partition,xcodebook);
            [ o,n2(J)]  =   quantiz(imag(sy(J)),partition,ycodebook);
        end
        
        sb      =   n1+j*n2;
        if sum(abs(a-sb.')) ~=0
            ser =   ser+1;
        end 
        
    end % end f loop
    sbler(T)    =(ser) / F;     % LLSE Receiver (2)
    toc
end % end of T loop

figure
semilogy(EbN0,sbler,'-ob'); % LLSE Receiver (2)
xlabel('E_b/N_0 (dB)'); ylabel('SER');
grid
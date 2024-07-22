% function NVD_MIMO_VLAST_LLSE
% SER of V-BLAST, ZF and LLSE receivers for (M,N)=(8,12) and 16-QAM modulation.
% For each Eb/N0 value, we perform 10.000 iteration.

clc;
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
F               =   100; % no of trials at a given noise level

for T=1:length(EbN0) % T loop; choose SNR level
    tic    
    %%========================================= (4) 
    % 25: % V-BLAST/LLSE algorithm
    mer         =   0; % block error event counter
    mbler(T)    =   0; % block error rate    
    for f=1:F        
        %%=========================================
        % Common
        a       =   randsrc(M,1,xcodebook)+j*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M)+j*randn(N,M)) / sqrt(2);
        v       =   (randn(N,1)+j*randn(N,1))* sqrt(N0(T)/2);
        r       =   H*a+v;        
        %%========================================= (4)
        % 52: %Copy r and H for VBLAST/LLSE
        mH      =   H;
        mr      =   r;        
        %%========================================= (4)        
        % 81: % V-BLAST/LLSE Algorithm starts
        k           =   zeros(1,M);
        W           =   Es*mH'*pinv(Es*mH*mH'+N0(T)*eye(N)); % Es=ro/M
        for i=1:M
            for J=1:M
                n(J)    =   (norm(W(J,:)))^2;
            end
            for t=1:i-1
                n(k(t)) =   Inf;
            end
            [ Y,I]      =   min(n);
            k(i)        =   I;
            my          =   W(I,:)*mr;
            [ o,n1]     =   quantiz(real(my),partition,xcodebook);
            [ o,n2]     =   quantiz(imag(my),partition,ycodebook);
            mb(I)       =   n1+j*n2;
            mr          =   mr-mb(I)*mH(:,I);
            mH(:,I)     =   0;
            W           =   Es*mH'*pinv(Es*mH*mH'+N0(T)*eye(N));
        end % end i loop        
        if sum(abs(a-mb.')) ~=0
            mer         =   mer+1;            
        end % V-BLAST/LLSE Algorithm ends        
    end % end f loop    
    mbler(T)    =(mer) / F;     % V-BLAST/LLSE Algorithm    
    toc    
end % end of T loop
figure
semilogy(EbN0,mbler,'-+b'); % V-BLAST/LLSE Algorithm (4)
xlabel('E_b/N_0 (dB)'); ylabel('SER');
grid
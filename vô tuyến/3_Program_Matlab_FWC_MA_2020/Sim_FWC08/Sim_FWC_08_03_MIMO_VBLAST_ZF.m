% function NVD_MIMO_VBLAST_ZF
% SER of V-BLAST, ZF and LLSE receivers for (M,N)=(8,12) and 16-QAM modulation.
% For each Eb/N0 value, we perform 10.000 iteration.

clear all;
close all;
% 16 point QAM is used
partition       =   [ -2,0,2 ];
xcodebook       =   [-3,-1,1,3 ];
ycodebook       =   xcodebook;
M               =   3;                  % no of transmitter antennas 8 (2)
N               =   4;                 % no of receiver antennas   12 (4)
Es              =   2*sum(xcodebook * xcodebook')/size(xcodebook,2); % average symbol energy per antenna
Eb              =   Es/(2*log2(size(xcodebook,2))); % transmitted bit energy per antenna
EbN0            =   -10:2:4;
N0              =   Eb./10.^(EbN0/10); % Noise power
F               =   100; % no of trials at a given noise level
h               = waitbarqa(0,'M« pháng SER cho tõng gi¸ trÞ cña SNR');
for T=1:length(EbN0) % T loop; choose SNR level
    waitbarqa(T/length(EbN0));
%     tic
    %%========================================= (3) 
    % 21 % V-BLAST/ZF algorithm
    er          =   0; % block error event counter
    bler(T)     =   0; % block error rate    
    for f=1:F        
        %%=========================================
        % Common
        a       =   randsrc(M,1,xcodebook)+j*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M)+j*randn(N,M)) / sqrt(2);
        v       =   (randn(N,1)+j*randn(N,1))* sqrt(N0(T)/2);
        r       =   H*a+v;
        %%========================================= (3)
        % 56: % V-BLAST/ZF algorithm begins
        k       =   zeros(1,M);
        G       =   pinv(H); % Note W=H+        
        %%========================================= (3)
        % V-BLAST/ZF algorithm begins
        for i=1:M %i loop
            for J=1:M
                n(J)    =   (norm(G(J,:)))^2;
            end            
            for t=1:i-1
                n(k(t)) =   Inf;
            end            
            [ Y,I]  =   min(n);
            k(i)    =   I;
            w       =   G(I,:);
            y       =   w*r;
            [ o,n1] =   quantiz(real(y),partition,xcodebook);
            [ o,n2] =   quantiz(imag(y),partition,ycodebook);
            b(I)    =   n1+j*n2;
            r       =   r-b(I)*H(:,I);
            H(:,I)  =   0;
            G       =   pinv(H);            
        end % end i loop        
        if sum(abs(a-b.')) ~=0
            er      =   er+1;
        end % V-BLAST with ZF algorithm ends        
    end % end f loop    
    bler(T)     =(er) / F;      % V-BLAST/ZF algorithm    
%     toc    
end % end of T loop
close(h);


figure
semilogy(EbN0,bler,'-dr');  % V-BLAST/ZF algorithm (3)
xlabel('E_b/N_0 (dB)'); ylabel('SER');
grid
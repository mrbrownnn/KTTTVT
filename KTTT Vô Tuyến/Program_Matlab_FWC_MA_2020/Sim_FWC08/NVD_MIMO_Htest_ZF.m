% function NVD_MIMO_Htest_ZF
% SER of V-BLAST, ZF and LLSE receivers for (M,N)=(8,12) and 16-QAM modulation.
% For each Eb/N0 value, we perform 10.000 iteration.

clc;
clear all;
close all;

% 16 point QAM is used
partition       =   [ -2,0,2 ];     % Nguong QDinh

xcodebook       =   [-3,-1,1,3 ];   % PAM 4 muc

ycodebook       =   xcodebook;
M               =   2;                  % no of transmitter antennas 8 (2)
N               =   4;                 % no of receiver antennas   12 (4)

Es              =   2*sum(xcodebook * xcodebook')/size(xcodebook,2); % average symbol energy per antenna
Eb              =   Es/(2*log2(size(xcodebook,2))); % transmitted bit energy per antenna

EbN0            =   [-10,1]; %input(' Nhap min max cua EbN0 [dB] =    '); %-10:2:4;
EbN0            =   linspace(min(EbN0),max(EbN0),22)

% EbN0            =   input(' Nhap EbN0 [dB] =    '); %-10:2:4;
N0              =   Eb./10.^(EbN0/10); % Noise power
%17
F               =   10000; % no of trials at a given noise level

for T=1:length(EbN0) % T loop; choose SNR level linspace(min(EbN0),max(EbN0),22)
    tic    
    %%========================================= (1)
    % 29: % ZF algorithm
    zer         =   0;      % block error event counter
    zbler(T)    =   0;      % block error rate    
    
    for f=1:F
        
        %%=========================================
        % Common
        a       =   randsrc(M,1,xcodebook)+j*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M)+j*randn(N,M)) / sqrt(2);
        v       =   (randn(N,1)+j*randn(N,1))* sqrt(N0(T)/2);
        r       =   H*a+v;
        
        %%========================================= (1)
        % Copy r and H for ZF Receiver
        zH      =   H;
        zr      =   r;        
        
        %%========================================= (1)        
        % 106: % ZF Algorithm begins
        zb      =   zeros(1,M); 
        %         J_test  =   zeros(1,M);
        zG      =   pinv(zH);           % Note FUNCTION pinv of MATLAB
        zy      =   zG*zr;
        for J=1:M
            %             J_test(J)       = J;
            [ o,n1(J)]      =   quantiz(real(zy(J)),partition,xcodebook);
            o_t1(J)          =   o;
            [ o,n2(J)]      =   quantiz(imag(zy(J)),partition,ycodebook);
            o_t2(J)          =   o;
            
        end

        zb(1:M)             =   n1(1:M)+j*n2(1:M);
        if sum(abs(a-zb.')) ~=0
            zer     =   zer+1;
        end         % ZF Algorithm ends
    end             % end f loop    
    zbler(T)    =(zer) / F;     % ZF Algorithm (1)    
    toc    
end         % end of T loop

figure
semilogy(EbN0,zbler,'-*r');                 % ZF Algorithm  (1)
xlabel('E_b/N_0 (dB)'); ylabel('SER');
grid on;
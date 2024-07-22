% function NVD_MIMO_ZF
% SER of V-BLAST, ZF and LLSE receivers for (M,N)=(8,12) and 16-QAM modulation.
% For each Eb/N0 value, we perform 10.000 iteration.

clc;
clear all;
close all;

%==========================================================================
%=========== set parameter=================================================
%==========================================================================
% 16 point QAM is used
partition       =   [ -2,0,2 ];
xcodebook       =   [-3,-1,1,3 ];
ycodebook       =   xcodebook;

M               =   8;                  % no of transmitter antennas 8 (2)
N               =   12;                 % no of receiver antennas   12 (4)
Display1        =   [M,N];
Es              =   2*sum(xcodebook * xcodebook')/size(xcodebook,2);    % average symbol energy per antenna
Eb              =   Es/(2*log2(size(xcodebook,2)));                     % transmitted bit energy per antenna
EbN0            =   -10:2:10;
N0              =   Eb./10.^(EbN0/10);  % Noise power
F               =   10000;              % no of trials at a given noise level

%==========================================================================
%================= start simulation========================================
%==========================================================================

h               =   waitbarqa(0,'M« pháng SER cho tõng gi¸ trÞ cña SNR');
for T=1:length(EbN0)    % T loop; choose SNR level
    tic  
    waitbarqa(T/length(EbN0));
    
    % %========================================= (1)
    % ZF algorithm
    zer         =   0; % block error event counter
    zbler(T)    =   0; % block error rate    
    
    for f=1:F        
        %%=========================================
        % Common
        a       =   randsrc(M,1,xcodebook)+ i*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M)+i*randn(N,M)) / sqrt(2);
        v       =   (randn(N,1)+i*randn(N,1))* sqrt(N0(T)/2);
        r       =   H*a+v;
        
        %%========================================= (1)
        % 44: %Copy r and H for ZF Receiver
        zH      =   H;
        zr      =   r;
        
        %%========================================= (1)        
        %  ZF Algorithm begins
        zb      =   zeros(1,M);
        zG      =   pinv(zH);           % Note FUNCTION pinv of MATLAB
        zy      =   zG*zr;
        for J=1:M
            [ o,n1(J)]      =   quantiz(real(zy(J)),partition,xcodebook);
            [ o,n2(J)]      =   quantiz(imag(zy(J)),partition,ycodebook);
        end
        zb(1:M)             =   n1(1:M)+i*n2(1:M);
        if sum(abs(a-zb.')) ~= 0
            zer     =   zer+1;
        end     % ZF Algorithm ends
        %%========================================= (1)        
    end         % end f loop        
    zbler(T)    =(zer) / F;         % SER of ZF Algorithm (1)    
    toc
end             % end of T loop
close(h);

h1_1        = figure(1);
set(h1_1,'color','c','name','SER of ZF Algorithm: NVD');

semilogy(EbN0,zbler,...
        '--rs','LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',7);
axis([min(EbN0) max(EbN0) min(zbler) max(zbler)]);
title(['M« pháng SER theo SNR cho hÖ thèng MIM0-VBLAST voi (n_T,n_R)=(',...
    num2str(Display1),')','; 16-QAM; N_i_t_e_r =',num2str(F)],'FontName','.VnTime','FontSize',18);
xlabel(' E_b/N_0 dB','FontName','.VnTime','FontSize',14);
ylabel('SER','FontName','.VnTime','FontSize',16);
legend('MIMO-ZF Detector');
grid on;
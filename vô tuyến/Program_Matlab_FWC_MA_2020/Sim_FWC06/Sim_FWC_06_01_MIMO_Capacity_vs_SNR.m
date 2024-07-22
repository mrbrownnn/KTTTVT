%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================

% function NVD_D12VT_MIMO_Capacity_vs_SNR1

clc;
clear all, 
close all;

SNR_dB      = [0:5:30];  
SNR_linear  = 10.^(SNR_dB/10.);
N_iter      = 10000; 
nT          = 8; 
nR          = 4;  % 4x4  
n            = min(nT,nR);  
I            = eye(n);
C            = zeros(1,length(SNR_dB));   

for iter=1:N_iter
    H    = sqrt(0.5)*(randn(nR,nT)+j*randn(nR,nT));
    if nR>=nT,  
        HH = H'*H;  
    else
        HH = H*H';
    end
    for i=1:length(SNR_dB)   %random channel generation
        C(i) = C(i)+log2(real(det(I+SNR_linear(i)/nT*HH)));
    end
end
C       = C/N_iter;
%==========================================================================
h1 = figure(1);
set(h1,'color','c');
set(h1,'Name','Simulation for MIMO_Ergodic_Capacity_vs_SNR');
plot(SNR_dB,C,'r-s','LineWidth',[3.5]) ;hold on;
X   = xlabel('SNR [dB]');    set(X,'fontname','.Vntime','fontsize',18,'color','b');
Y   = ylabel('Ergodic Capacity vs SNR [bps/Hz]');      set(Y,'fontname','.Vntime','fontsize',18,'color','b');
T=title(strvcat(strcat('Ergodic MIMO channel capacity',...
    ' when CSI is not available at the transmitter')));
set(T,'fontname','.Vntime','fontsize',18,'color','b');
grid on;
set(gca,'fontname','.Vntime','fontsize',9);
s1='MIMO: {\it N_T_x}=4,{\it N_R_x}=4'; 
legend(s1);
%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================

% function NVD_D12VT_Correlation_MIMO_Capacity

% Capacity reduction due to correlation of the MIMO channels
% In general, the MIMO channel gains are not independent and identically distributed (i.i.d.).
% The channel correlation is closely related to the capacity of the MIMO channel. 
% In the sequel, we consider the capacity of the MIMO channel 
% when the channel gains between transmit and received antennas are correlated.
% we consider the capacity for Case: the SNR is high and low.

clc;
clear all, 
close all;
SNR_dB      = [0:2:20];  
SNR_linear  = 10.^(SNR_dB/10);

N_iter  = 1000;
N_SNR   = length(SNR_dB);

%%----------------- 4x4 -----------------------------
nT  = 4;
nR  = 4;  
n   = min(nT,nR);
I   = eye(n);  
sq2 = sqrt(0.5);

R=[1                      0.76*exp(0.17j*pi)   0.43*exp(0.35j*pi)    0.25*exp(0.53j*pi);
   0.76*exp(-0.17j*pi)   1                     0.76*exp(0.17j*pi)    0.43*exp(0.35j*pi);
   0.43*exp(-0.35j*pi)   0.76*exp(-0.17j*pi)   1                     0.76*exp(0.17j*pi);
   0.25*exp(-0.53j*pi)   0.43*exp(-0.35j*pi)   0.76*exp(-0.17j*pi)   1                  ];

C_44_iid    = zeros(1,N_SNR);  
C_44_corr   = zeros(1,N_SNR);

for iter=1:N_iter
    
    H_iid    = sq2*(randn(nR,nT)+i*randn(nR,nT));
    H_corr   = H_iid*R^(1/2);
    tmp1     = H_iid'*H_iid/nT; 
    tmp2     = H_corr'*H_corr/nT;
    
    for i=1:N_SNR                   % Eq 9.48
        
      C_44_iid(i)   = C_44_iid(i) + log2(det(I+SNR_linear(i)*tmp1));
      C_44_corr(i)  = C_44_corr(i) + log2(det(I+SNR_linear(i)*tmp2));
   end
end
C_44_iid    = real(C_44_iid)/N_iter;
C_44_corr   = real(C_44_corr)/N_iter;

h1 = figure(1);
    set(h1,'color','c');
    set(h1,'Name','Capacity reduction due to correlation of the MIMO channels');
    plot(SNR_dB,C_44_iid,'b-o','LineWidth',3.5);    hold on;
    plot(SNR_dB,C_44_corr,'r-v', 'LineWidth',5.0);  hold on;
    X   = xlabel('SNR [dB]');    
    set(X,'fontname','.Vntime','fontsize',18,'color','b');
    Y   = ylabel('Ergodic Capacity vs SNR [bps/Hz]');     
    set(Y,'fontname','.Vntime','fontsize',18,'color','b');
    T = title('Capacity reduction due to correlation of the MIMO channels');
    set(T,'fontname','.Vntime','fontsize',18,'color','b');
    grid on;
    set(gca,'fontname','.Vntime','fontsize',14);
        s1='iid 4x4 channels'; 
        s2='correlated 4x4 channels'; 
    legend(s1,s2);
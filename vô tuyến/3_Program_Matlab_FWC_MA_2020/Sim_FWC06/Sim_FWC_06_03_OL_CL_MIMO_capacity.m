%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================

% function NVD_D12VT_CL_OL_MIMO_capacity

% The ergodic channel capacity for the open-loop system without using CSI at the
% transmitter side, from Equation: (9.31),(9.41),(9.42)
% The ergodic channel capacity for the closed-loop (CL) system using CSI at the
% transmitter side, from Equation: (9.44), (9.44)

clc;
clear all;
close all;
SNR_dB      = [0:2:22];
SNR_linear  = 10.^(SNR_dB/10.);
N_iter      = 1000;
%%----------------- 4x4 -----------------------------
nT      = 4;
nR      = 4;
n       = min(nT,nR);
I       = eye(n);
rho     = 0.2;
sq2     = sqrt(0.5);
Rtx     = [1 rho rho^2 rho^3; rho 1 rho rho^2; rho^2 rho 1 rho; rho^3 rho^2 rho 1];

rho     = 0.2;
Rrx     = [1 rho rho^2 rho^3; rho 1 rho rho^2; rho^2 rho 1 rho; rho^3 rho^2 rho 1];

C_44_OL     = zeros(1,length(SNR_dB)); 
C_44_CL     = zeros(1,length(SNR_dB));

for iter=1:N_iter
    
   Hw   = sq2*(randn(4,4) + j*randn(4,4));
   H    = Rrx^(1/2)*Hw*Rtx^(1/2);  
   tmp  = H'*H/nT;
   Lamda   = svd(H'*H);
   
   for i=1:length(SNR_dB)
      % random channel generation
      C_44_OL(i)    = C_44_OL(i) + log2(det(I+SNR_linear(i)*tmp));                      % Eq 9.41
      P_opt         = FWC_Water_Filling(Lamda,SNR_linear(i),nT);
      C_44_CL(i)    = C_44_CL(i)+log2(det(I+SNR_linear(i)/nT*diag(P_opt)*diag(Lamda)));    % Eq 9.44
   end
end
C_44_OL     = real(C_44_OL)/N_iter;  
C_44_CL     = real(C_44_CL)/N_iter;

h1 = figure(1);
set(h1,'color','c');
set(h1,'Name','MIMO_Ergodic_Capacity_vs_SNR for closed-loop and open-loop systems Programmed by Nguyen Viet Dam PTIT');
plot(SNR_dB, C_44_OL,'b-o','LineWidth',[3.5]);
hold on;
plot(SNR_dB, C_44_CL,'r-<', 'LineWidth',[3.0]);
hold on;
X   = xlabel('SNR [dB]');
set(X,'fontname','.Vntime','fontsize',18,'color','b');
Y   = ylabel('Ergodic Capacity vs SNR [bps/Hz]');
set(Y,'fontname','.Vntime','fontsize',18,'color','b');

T=title(strvcat(strcat('Ergodic capacities for the closed-loop and open-loop systems')));
set(T,'fontname','.Vntime','fontsize',18,'color','b');
grid on;
% set(gca,'fontsize',9); set(gca,'fontname','.Vntime','fontsize',8,'color','c');
set(gca,'fontname','.Vntime','fontsize',12);
    s1='Channel Unknown'; 
    s2='Channel Known'; 
legend(s1,s2);
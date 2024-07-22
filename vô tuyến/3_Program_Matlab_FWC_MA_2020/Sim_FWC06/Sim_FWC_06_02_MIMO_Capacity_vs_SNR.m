%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================

% function NVD_D12VT_MIMO_Capacity_vs_SNR2

clc;
clear all, 
close all;

SNR_dB      = [0:5:30];  
SNR_linear  = 10.^(SNR_dB/10.);
N_iter      = 10000; 

for Icase=1:5
    if Icase==1,  
        nT=4; nR=4;  % 4x4
    elseif Icase==2, 
        nT=2;  nR=2; % 2x2
    elseif Icase==3, 
        nT=1;  nR=2; % 1x2
    elseif Icase==4, 
        nT=2;  nR=1; % 2x1
    else        
        nT=1;  nR=1; % 1x1
    end
   
   n            = min(nT,nR);  
   I            = eye(n);
   C(Icase,:)   = zeros(1,length(SNR_dB));
   
   for iter=1:N_iter
       H    = sqrt(0.5)*(randn(nR,nT)+j*randn(nR,nT));
       if nR>=nT,  
           HH = H'*H;  
       else
           HH = H*H';  
       end       
       for i=1:length(SNR_dB)   %random channel generation
         C(Icase,i) = C(Icase,i)+log2(real(det(I+SNR_linear(i)/nT*HH)));
      end
   end
end
C       = C/N_iter;
%==========================================================================
h1 = figure(1);
    set(h1,'color','c');
    set(h1,'Name','Simulation for MIMO_Ergodic_Capacity_vs_SNR');
    plot(SNR_dB,C(1,:),'b-o','LineWidth',3.5);   hold on;
    plot(SNR_dB,C(2,:),'r-<','LineWidth',3.0);   hold on;
    plot(SNR_dB,C(3,:),'r-s','LineWidth',2.5);   hold on;
    plot(SNR_dB,C(4,:),'k->','LineWidth',2.0);   hold on;
    plot(SNR_dB,C(5,:),'g-^','LineWidth',1.5);   hold on;
    
    X   = xlabel('SNR [dB]');    
    set(X,'fontname','.Vntime','fontsize',18,'color','b');
    Y   = ylabel('Ergodic Capacity vs SNR [bps/Hz]');      
    set(Y,'fontname','.Vntime','fontsize',18,'color','b');
    
    T=title(strvcat(strcat('Ergodic MIMO channel capacity',...
        ' when CSI is not available at the transmitter')));
    set(T,'fontname','.Vntime','fontsize',18,'color','b');    
    grid on;
    
    % set(gca,'fontsize',9); set(gca,'fontname','.Vntime','fontsize',8,'color','c');
    set(gca,'fontname','.Vntime','fontsize',14);
        s1='MIMO: {\it N_T_x}=4,{\it N_R_x}=4'; 
        s2='MIMO: {\it N_T_x}=2,{\it N_R_x}=2'; 
        s3='MIMO: {\it N_T_x}=1,{\it N_R_x}=2'; 
        s4='MIMO: {\it N_T_x}=2,{\it N_R_x}=1'; 
        s5='MIMO: {\it N_T_x}=1,{\it N_R_x}=1';
    legend(s1,s2,s3,s4,s5);
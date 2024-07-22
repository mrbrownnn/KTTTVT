%==========================================================================
%=========================  Sim_MA_01_SS_CDMA =============================
%==========================================================================
clc;
clear;
close all;
%--------------------------------------------------------------------------
% Tham so
f       = -250:1:250;
fc      =   100;
Tb      =   0.025;
P_T     =   1;
Eb      =   P_T*Tb;
SF      =   2;          % Spread Facotor
Tc      =   Tb/SF;      % chip time
Ec      =   P_T*Tc;     % chip energy

% PSD truoc khi SS
PSD_No_SS = 2*Tb*(sinc(f*Tb)).^2;
PSD_SS = 2*Tc*(sinc(f*Tc)).^2;

% PSD of DSS_BPSK
PSD_DSS_BPSK1 = (Ec/2)*(sinc((f+fc)*Tc).^2);
PSD_DSS_BPSK2 = (Ec/2)*(sinc((f-fc)*Tc).^2);

%--------------------------------------------------------------------------
figure(1)
    subplot(2,1,1);
        plot(f,PSD_No_SS,'-.b','LineWidth',2);
        hold on;
        plot(f,PSD_SS,'r','LineWidth',4);
        grid on;
        xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',14);
        ylabel('PSD_N_o_D_S_S & PSD_D_S_S','FontName','.VnTime','color','b','FontSize',18);
        title('MËt ®é phæ c«ng suÊt PSD cña tÝn hiÖu tr­íc vµ sau tr¶i phæ:',...
            'FontName','.VnTime','color','b','FontSize',14);
    %--------------------------------------
    subplot(2,1,2);
        plot(f,PSD_DSS_BPSK1,'b','LineWidth',4);
        hold on;
        plot(f,PSD_DSS_BPSK2,'r','LineWidth',4);
        grid on;
        xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',14);
        ylabel('PSD_D_S_S_B_P_S_K','FontName','.VnTime','color','b','FontSize',18);
        title('MËt ®é phæ c«ng suÊt PSD cña tÝn hiÖu DSS-BPSK:',...
            'FontName','.VnTime','color','b','FontSize',14);
%==========================================================================        

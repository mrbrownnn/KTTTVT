%==========================================================================
%====================== Sim_FWC_01_1_PSD_Base_PassBand ====================
%==========================================================================
clc;
clear;
close all;
%--------------------------------------------------------------------------
% Tham so
f       = -200:5:200;
% f       =   linspace(-200,200,1500);
Tb      =   0.02;
Rb      =   1/Tb;
A       =   10;
AA      =   A^2*Tb;
fc      =   120;
% Mat do pho cong suat bang tan co so
PSD_BaseBand = AA*(sinc((f*Tb)).^2);

% Mat do pho cong suat BPSK
PSD_PassBand = (AA/4)*((sinc((f+fc)*Tb)).^2 +(sinc((f-fc)*Tb)).^2);

PSD_PassBand_1 = (AA/4)*((sinc((f-fc)*Tb)).^2);
PSD_PassBand_2 = (AA/4)*((sinc((f+fc)*Tb)).^2 );

%--------------------------------------------------------------------------
figure(1)
subplot(2,1,1);
    stem(f,PSD_BaseBand,'b','LineWidth',3);
    hold on
    plot(f,PSD_BaseBand,'b','LineWidth',3);
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD_B_a_s_e_B_a_n_d','FontName','.VnTime','color','b','FontSize',24);    
    title(['MËt ®é phæ c«ng suÊt PSD cña tÝn hiÖu b¨ng tÇn c¬ së víi tèc ®é R_b =',num2str(Rb),'b/s'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;

subplot(2,1,2);
    stem(f,PSD_PassBand_1,'r','LineWidth',3);
    hold on
    stem(f,PSD_PassBand_2,'g','LineWidth',3);
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD_P_a_s_s_B_a_n_d','FontName','.VnTime','color','b','FontSize',24);    
    title(['MËt ®é phæ c«ng suÊt PSD cña tÝn hiÖu th«ng gi¶i víi tèc ®é R_b =',num2str(Rb),'b/s',...
        '; TÇn sè sãng mang f_c =',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;   
%==========================================================================    
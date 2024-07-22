%==========================================================================
%======================= Sim_MA_06_PSD_OFDM ===============================
%==========================================================================

clc;
clear;
close all;

%==========================================================================
deta_f          =   20;                                 % BW_channel/num_subcarrier=Subcarrier space; 
                                                        % Corhence Bandwidth of channel;15KHz
BW_channel      =   200;                                % bandwidth of channel = 20MHz
% num_subcarrier  =   ceil(BW_channel/deta_f);          % Number of subcarrier or subchannel round
num_subcarrier  =   round(BW_channel/deta_f);           % Number of subcarrier or subchannel
T_ofdm          =   1/deta_f;                           % OFDM time
R_ofdm          =   1/T_ofdm;
Tb              =   T_ofdm/num_subcarrier;
Rb              =   1/Tb;                               % ceil function
A               =   10;
A1              =   A^2*Tb;
AA              =   A^2*T_ofdm;
f_i             =   deta_f:deta_f:BW_channel+deta_f;
f               =   -Rb:BW_channel+4*deta_f;
% f_BB          =   -Rb:4*Rb;
fc              =   3*max(f);
f2              =   -f:1:(fc+BW_channel+4*deta_f);

    % PSD of input of OFFDM Modulation Block
    PSD_ofdm_in = A1*(sinc((f*Tb)).^2);
    
    PSD_RF_SC   = A1*(sinc(((f2-fc)*Tb)).^2);
    
    % PSD of output of OFFDM Modulation Block
    PSD_OFDM        = zeros(num_subcarrier,max(size(f)));
    PSD_OFDM_RF     = zeros(num_subcarrier,max(size(f2)));
for k = 1:num_subcarrier
    PSD_OFDM(k,:)       = AA*(sinc((f-f_i(k))*T_ofdm)).^2;
    % PSD_OFDM(k,:)       = rand(1)*AA*(sinc((f-f_i(k))*T_ofdm)).^2;
    PSD_OFDM_RF(k,:)    = AA*(sinc((f2-f_i(k)-fc)*T_ofdm)).^2;
    % PSD_OFDM_RF(k,:)    = rand(1)*AA*(sinc((f2-f_i(k)-fc)*T_ofdm)).^2;
end       

figure(1)

    %------------------------
subplot(2,2,1);
    plot(f,PSD_ofdm_in,'r','LineWidth',3);
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD_I_n_p_u_t_ _o_f_ _O_F_D_M','FontName','.VnTime','color','b','FontSize',14);
    title(['MËt ®é phæ c«ng suÊt PSD cña tÝn hiÖu ®Çu vµo khèi OFDM víi tèc ®é lµ R_b =',num2str(Rb),'b/s'],...
        'FontName','.VnTime','color','b','FontSize',9);
    grid on;
    
    %------------------------
subplot(2,2,2);
    plot(f2,PSD_RF_SC,'m','LineWidth',3);
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD_S_C_R_F','FontName','.VnTime','color','b','FontSize',14);
    title(['MËt ®é phæ c«ng suÊt PSD cña tÝn hiÖu SC_R_F víi tèc ®é lµ R_b =',num2str(Rb),'b/s',...
        ';F_R_F=',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',9);
    grid on;
    
    %------------------------
subplot(2,2,3);
for k = 1:num_subcarrier
    plot(f,PSD_OFDM(k,:),'b','LineWidth',2);
    hold on        
end 
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD_O_F_D_M','FontName','.VnTime','color','b','FontSize',14);
    title(['PSD cña tÝn hiÖu OFDM: BW_C_h_a_n_n_e_l_  =',num2str(BW_channel),...
        ' H_Z ; Num_S_u_b_c_a_r_r_i_e_r =',num2str(num_subcarrier),...
        '; Subcarrier_S_p_a_c_e =',num2str(deta_f),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',9);
    grid on;
    
    %------------------------
subplot(2,2,4);
    
for k = 1:num_subcarrier
    plot(f2,PSD_OFDM_RF(k,:),'b','LineWidth',2);
    hold on        
end 
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD_O_F_D_M_R_F','FontName','.VnTime','color','b','FontSize',14);
    title(['PSD cña tÝn hiÖu OFDM_R_F: BW_C_h_a_n_n_e_l_  =',num2str(BW_channel),...
        ' H_Z ; Num_S_u_b_c_a_r_r_i_e_r =',num2str(num_subcarrier),...
        '; Subcarrier_S_p_a_c_e =',num2str(deta_f),'H_Z',';f_R_F=',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',9);
    grid on;

    PSD_OFDM_sum_RF = sum(PSD_OFDM_RF,'double');
    
    
%==============================================    
figure(2)
    
%------------------------
subplot(2,1,1);

for k = 1:num_subcarrier
    plot(f2,PSD_OFDM_RF(k,:),'b','LineWidth',2);
    hold on
end    
    h11 = plot(f2,PSD_RF_SC,'r','LineWidth',3);
    hold on    
    h12 = plot(f2,PSD_OFDM_sum_RF,'+r','LineWidth',4);
    
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD_O_F_D_M_ _R_F & SC_R_F','FontName','.VnTime','color','b','FontSize',14);
    title(['So sanh PSD cña tÝn hiÖu OFDM_R_F & SC_R_F: BW_C_h_a_n_n_e_l_  =',num2str(BW_channel),...
        ' H_Z ; Num_S_u_b_c_a_r_r_i_e_r =',num2str(num_subcarrier),...
        '; Subcarrier_S_p_a_c_e =',num2str(deta_f),'H_Z',';F_R_F=',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;    
    K   = legend('PSD cña OFDM_R_F','PSD cña SC_R_F','PSD cña OFDM_S_U_M_-_R_F');
    set(K, 'fontname','.Vntime','fontsize',13);
    
%------------------------
subplot(2,1,2)
    plot(f2,PSD_OFDM_sum_RF,'b','LineWidth',2);
    hold on
    plot(f2,PSD_RF_SC,'r','LineWidth',3);
    
    xlabel('TÇn sè [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD_O_F_D_M_ _R_F & SC_R_F','FontName','.VnTime','color','b','FontSize',14);    
    title(['PSD cña tÝn hiÖu OFDM_R_F & SC_R_F: BW_C_h_a_n_n_e_l_  =',num2str(BW_channel),...
        ' H_Z ; Num_S_u_b_c_a_r_r_i_e_r =',num2str(num_subcarrier),...
        '; Subcarrier_S_p_a_c_e =',num2str(deta_f),'H_Z',';F_R_F=',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','r','FontSize',12);
    grid on;
    L   = legend('PSD cña OFDM_S_U_M_-_R_F','PSD cña SC_R_F');
    set(L, 'fontname','.Vntime','fontsize',13);
%==========================================================================    
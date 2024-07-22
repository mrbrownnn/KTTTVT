% function Compasion_performace_channle_code

%==========================================================================
clc;
clear all;
close all;
%==========================================================================    
% proerty = char(['-vr','-ob','-:d','-sg']);

h1 = figure(9);
set(h1,'Name',' Programmed by Nguyen Viet Dam PTIT: 07-2007');    
%---------------------------
load Sim_FWC_02_02_BER_BPSK_AWGN_NoCC.mat;
    G = semilogy(SNRindB,theo_Antipodal_err_prb,'-ob',SNRindB,smld_err_prb,'-vr');
    set(G,'LineWidth',1.5);
    hold on;
    
clear;    
load Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G1.mat;    % G1

    semilogy(SNRindB,smld_err_prb,...
        '-.d','LineWidth',1.5,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',7);
    hold on;
    
clear;
load Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G2.mat;    % G2
    semilogy(SNRindB,smld_err_prb,...
        '-kp','LineWidth',1.5,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','y',...
        'MarkerSize',15);
    hold on;
    
clear;    
load Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G3.mat;    % G3
    semilogy(SNRindB,smld_err_prb,...
        '-.^b','LineWidth',1.5,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','m',...
        'MarkerSize',9);
    hold on;    
%--------------------------    
    AX = gca;
    set(AX,'FontSize',14);
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('X�c su�t l�i Pe','FontName','.VnTime','color','b','FontSize',18);
    grid on;    
    title(['M� ph�ng BER h� th�ng BPSK trong k�nh AWGN c� v� kh�ng c� m� h�a k�nh; S� bit m� ph�ng N_b_i_t= ',...
        num2str(NumBits),' bits '],'FontName','.VnTime','color','b','fontweight','normal','FontSize',16);    
    LT = legend('BER: \it Kh�ng m� h�a k�nh l� thuy�t',...
        'BER: \it Kh�ng m� h�a k�nh m� ph�ng',...
        'BER: \it C� m� h�a k�nh, \bf G1, r=1/2',...
        'BER: \it C� m� h�a k�nh, \bf G2, r=1/2',...
        'BER: \it C� m� h�a k�nh, \bf G3, r=2/3');    
    set(LT,'fontname','.vntime','fontsize',18);

    text(1,7e-5,'M� h�nh h�a v� m� ph�ng hi�u n�ng c�c b� m� h�a k�nh',...
        'FontName','.VnTimeh','Color','r','FontSize',14);    
    text(0.5,min(theo_Antipodal_err_prb),'T�nh ch�nh x�c c�a k�t qu� m� ph�ng, x�c nh�n v� ph� chu�n m� h�nh',...
        'FontName','.VnUniverseH','Color','b','FontSize',22);
% % ================== simulation time=======================================
% load Sim_FWC_02_02_BER_BPSK_AWGN_NoCC.mat;
%     SimTime1 = SimTime;
% load Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G1.mat;
%     SimTime2 = SimTime;
% load Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G2.mat;
%     SimTime3 = SimTime;
% load Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G3.mat;
%     SimTime4 = SimTime;
% SimTime_com = [SimTime1 SimTime2 SimTime3 SimTime4];


    


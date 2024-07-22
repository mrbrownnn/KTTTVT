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
    ylabel('X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',18);
    grid on;    
    title(['M« pháng BER hÖ thèng BPSK trong kªnh AWGN cã vµ kh«ng cã m· hãa kªnh; Sè bit m« pháng N_b_i_t= ',...
        num2str(NumBits),' bits '],'FontName','.VnTime','color','b','fontweight','normal','FontSize',16);    
    LT = legend('BER: \it Kh«ng m· hãa kªnh lý thuyÕt',...
        'BER: \it Kh«ng m· hãa kªnh m« pháng',...
        'BER: \it Cã m· hãa kªnh, \bf G1, r=1/2',...
        'BER: \it Cã m· hãa kªnh, \bf G2, r=1/2',...
        'BER: \it Cã m· hãa kªnh, \bf G3, r=2/3');    
    set(LT,'fontname','.vntime','fontsize',18);

    text(1,7e-5,'M« h×nh hãa vµ m« pháng hiÖu n¨ng c¸c bé m· hãa kªnh',...
        'FontName','.VnTimeh','Color','r','FontSize',14);    
    text(0.5,min(theo_Antipodal_err_prb),'TÝnh chÝnh x¸c cña kÕt qu¶ m« pháng, x¸c nhËn vµ phª chuÈn m« h×nh',...
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


    


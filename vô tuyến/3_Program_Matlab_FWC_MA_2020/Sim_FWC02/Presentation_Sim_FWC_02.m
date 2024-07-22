%==========================================================================
%===================== Presentation_Sim_FWC_02 =============================
%==========================================================================

clc;
clear all;
close all;
%==========================================================================
    load Sim_FWC_02_02_BER_BPSK_AWGN.mat;
%==========================================================================
%--------------------------------------------------------------------------    
%     Xsize   = 14;
%     Ysize   = 18;
%     Ysize   = 18;
%     Lsize   = 18;
%     LTsize  = 18;

h1 = figure(1);
set(h1,'color','c');
set(h1,'Name','Sim_FWC_02_02_BER_BPSK_AWGN');
subplot(121)
    G = semilogy(SNRindB,smld_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
    set(G,'LineWidth',[1.5]);        
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('\bf X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',18);   
    %----------------------------
    TT=title(strvcat(strcat('M« pháng BER hÖ thèng BPSK','trong kªnh AWGN;'),...
        strcat(['Sè bit m« pháng N_{bits} = ',num2str(NumBits),'bits '])));
    
    % Notes: TT=title(strvcat(strcat('str1'),strcat(['str2',num2str(NumBits),'str3'])));    
    set(TT,'fontname','.Vntime','fontsize',9,'color','b');
    %----------------------------
    LT = legend('   M« pháng ','   TÝnh to¸n');    
    set(LT,'FontName','.VnTime','FontSize',16);    
    AX=gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 0.2]);
    grid on;
    Note1= 'M« h×nh hãa vµ m« pháng';
    Note2= 'TÝnh chÝnh x¸c cña kÕt qu¶ m« pháng';
    text(2,7e-5,{Note1,Note2},'FontName','.VnTime','Color','b','FontSize',14);
    
%     text(0.5,min(theo_Antipodal_err_prb),'TÝnh chÝnh x¸c cña kÕt qu¶ m« pháng, x¸c nhËn vµ phª chuÈn m« h×nh',...
%         'FontName','.VnTimeh','Color','r','FontSize',9.9)

subplot(122)
    G = semilogy(SNRindB,theo_Orthogonal_err_prb,'-vr');
    G = semilogy(SNRindB,theo_Orthogonal_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
    set(G,'LineWidth',[1.5]);        
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',18);
    TT = title(strvcat(strcat('So s¸nh x¸c suÊt lçi bit hÖ thèng BPSK'),...
        strcat('trùc giao vµ ®èi cùc trong kªnh AWGN')));
    set(TT,'FontName','.VnTime','color','b','FontSize',12);
    LT = legend('   Trùc giao','    §èi cùc');
    set(LT,'FontName','.VnTime','FontSize',16,'fontweight','normal','fontAngle','normal');
    AX = gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 0.2]);
    grid on;
    text(2,7e-5,'TÝnh to¸n so s¸nh hiÖu n¨ng','FontName','.VnTimeh','Color','b','FontSize',14);
    
%==========================================================================
%     T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
%         ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE & ZF'));
%     set(T,'fontname','.Vntime','fontsize',18,'color','b');
%     Xsize   = 12;
%     Ysize   = 18;
%     Lsize   = 12;
%     LTsize  = 14;
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
    ylabel('\bf X�c su�t l�i Pe','FontName','.VnTime','color','b','FontSize',18);   
    %----------------------------
    TT=title(strvcat(strcat('M� ph�ng BER h� th�ng BPSK','trong k�nh AWGN;'),...
        strcat(['S� bit m� ph�ng N_{bits} = ',num2str(NumBits),'bits '])));
    
    % Notes: TT=title(strvcat(strcat('str1'),strcat(['str2',num2str(NumBits),'str3'])));    
    set(TT,'fontname','.Vntime','fontsize',9,'color','b');
    %----------------------------
    LT = legend('   M� ph�ng ','   T�nh to�n');    
    set(LT,'FontName','.VnTime','FontSize',16);    
    AX=gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 0.2]);
    grid on;
    Note1= 'M� h�nh h�a v� m� ph�ng';
    Note2= 'T�nh ch�nh x�c c�a k�t qu� m� ph�ng';
    text(2,7e-5,{Note1,Note2},'FontName','.VnTime','Color','b','FontSize',14);
    
%     text(0.5,min(theo_Antipodal_err_prb),'T�nh ch�nh x�c c�a k�t qu� m� ph�ng, x�c nh�n v� ph� chu�n m� h�nh',...
%         'FontName','.VnTimeh','Color','r','FontSize',9.9)

subplot(122)
    G = semilogy(SNRindB,theo_Orthogonal_err_prb,'-vr');
    G = semilogy(SNRindB,theo_Orthogonal_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
    set(G,'LineWidth',[1.5]);        
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('X�c su�t l�i Pe','FontName','.VnTime','color','b','FontSize',18);
    TT = title(strvcat(strcat('So s�nh x�c su�t l�i bit h� th�ng BPSK'),...
        strcat('tr�c giao v� ��i c�c trong k�nh AWGN')));
    set(TT,'FontName','.VnTime','color','b','FontSize',12);
    LT = legend('   Tr�c giao','    ��i c�c');
    set(LT,'FontName','.VnTime','FontSize',16,'fontweight','normal','fontAngle','normal');
    AX = gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 0.2]);
    grid on;
    text(2,7e-5,'T�nh to�n so s�nh hi�u n�ng','FontName','.VnTimeh','Color','b','FontSize',14);
    
%==========================================================================
%     T=title(strvcat(strcat('SER c�a h� th�ng OFDM trong c�c m�',...
%         ' h�nh k�nh kh�c nhau'),'        v� ph��ng ph�p c�n b�ng k�nh MMSE & ZF'));
%     set(T,'fontname','.Vntime','fontsize',18,'color','b');
%     Xsize   = 12;
%     Ysize   = 18;
%     Lsize   = 12;
%     LTsize  = 14;
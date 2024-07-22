%==========================================================================
%=======================  Presentation_Sim_MA_04 ==========================
%==========================================================================
clc;
clear all;
close all;

load Sim_MA_04_DS_BPSK_CDMA_Jamer.mat;

    fprintf('\n SNRbdB= %5.2f   %5.2f (Jamming power= %5.2f)', SNRbdBs,PJ);
    fprintf('\n    BER= %6.4f  %6.4f (Without PN coding)', pobe(1,:));
    fprintf('\n    BER= %6.4f  %6.4f (With PN coding)\n', pobe(2,:));

figure(1)
    G = semilogy(SNRbdBt,pobet,'-.d',SNRbdBs,pobe(1,:),'-ob',SNRbdBs,pobe(2,:),'-^');
    set(G,'LineWidth',1.5);
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('\bf X�c su�t l�i Pe','FontName','.VnTime','color','b','FontSize',18);    
    AX      = gca;
    set(AX,'FontSize',14);
    T = title(['M� ph�ng x�c su�t l�i h� th�ng DS-CDMA/BPSK; C�ng su�t nhi�u ph� = ',num2str(PJ),' W',...
        '; N_S_I_M =',num2str(MaxIter),' l�n']);        
    set(T,'FontName','.VnTime','color','b','FontSize',16');
    LT = legend('T�nh to�n theo h�m Q(x)','M� ph�ng kh�ng d�ng m� PN','M� ph�ng d�ng m� PN');
    set(LT,'FontName','.VnTime','FontSize',14');
    grid on;
    
%==========================================================================    
%     text(2,7e-5,'M� h�nh h�a v� m� ph�ng',...
%         'FontName','.VnTimeh','Color','b','FontSize',14);    
%     text(0.5,min(theo_Antipodal_err_prb),'T�nh ch�nh x�c c�a k�t qu� m� ph�ng, x�c nh�n v� ph� chu�n m� h�nh',...
%         'FontName','.VnTimeh','Color','r','FontSize',9.9)
%==========================================================================
%===================== Presentation_Sim_MA_07 =============================
%==========================================================================

clc;
clear all;
close all;
%==========================================================================
    load MA_07_BPSK_OFDM_NoCC_AWGN.mat;
    SER_noChannelCoding = SER;
    SNR_1               = SNR;
    clear SER;
    %----------
    load MA_07_BPSK_OFDM_CC_AWGN.mat;
    SER_ChannelCoding = SER;
    SNR_2             = SNR;
    clear SER;
%--------------------------------------------------------------------------    
figure(1)
    G = semilogy(SNR_1,SER_noChannelCoding,'-ob');
    set(G,'LineWidth',1.5);
    hold on;
    %--------
    G = semilogy(SNR_2,SER_ChannelCoding,'-.vr');
    set(G,'LineWidth',2.5);
    %--------
    AX      = gca;
    set(AX,'fontsize',14);
    X = xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',14,'color','b');
    Y = ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',14,'color','b');
    title(['M« pháng SER hÖ thèng BPSK/OFDM trong kªnh AWGN cã vµ kh«ng m· hãa kªnh; Sè bit m« pháng = ',...
        num2str(NumBits),' bits '],'FontName','.VnTime','color','b','FontSize',14);
    L=legend('OFDM - kªnh AWGN kh«ng m· hãa kªnh','OFDM - kªnh AWGN cã m· hãa kªnh');
    set(L,'fontname','.Vntime','fontsize',13);
    grid on;
%==========================================================================    
    
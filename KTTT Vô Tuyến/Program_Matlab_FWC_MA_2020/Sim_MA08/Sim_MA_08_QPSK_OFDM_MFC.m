%==========================================================================
%====================== Sim_MA_08_QPSK_OFDM_MFC ===========================
%==================== NVD_D12VT_SER_OFDM_AWGN_MFC =========================
% ----------------- Comparision: SER of OFDM in AWGN & MFC ----------------
%==========================================================================
clc;
clear all;
close all;
%--------------------------------------------------------------------------
SNR             = [1:2:18];
FFTsize         = 512;
CPsize          = 20;
numRun          = 10^4;         % 10^3
dataType        = 'Q-PSK';      % 'Q-PSK'
SER_ofdm_AWGN =[];
SER_ofdm_pedA =[];
SER_ofdm_vehA =[];
%--------------------------------------------------------------------------
for n = 1:length(SNR),
    %--------------------
    channelType = 'AWGN';
    SER_ofdm_AWGN(n)   = MA_08_SER_ofdm(SNR(n),numRun,...
        FFTsize,dataType,CPsize,channelType,[]);
    %--------------------
    channelType     = 'pedA';
    equalizerType   = 'ZERO'; % note chon 'ZERO' hoac 'MMSE'
    SER_ofdm_pedA_ZF(n) = MA_08_SER_ofdm(SNR(n),numRun,FFTsize,dataType,...
        CPsize,channelType,equalizerType);
    %--------------------
    channelType     = 'vehA';
    equalizerType   = 'ZERO'; % note chon 'ZERO' hoac 'MMSE'
    SER_ofdm_vehA_ZF(n)= MA_08_SER_ofdm(SNR(n),numRun,FFTsize,dataType,...
        CPsize,channelType,equalizerType);
    %--------------------
    channelType     = 'pedA';
    equalizerType   = 'MMSE'; % note chon 'ZERO' hoac 'MMSE'
    SER_ofdm_pedA_MMSE(n) = MA_08_SER_ofdm(SNR(n),numRun,FFTsize,dataType,...
        CPsize,channelType,equalizerType);
    %--------------------
    channelType     = 'vehA';
    equalizerType   = 'MMSE'; % note chon 'ZERO' hoac 'MMSE'
    SER_ofdm_vehA_MMSE(n)= MA_08_SER_ofdm(SNR(n),numRun,FFTsize,dataType,...
        CPsize,channelType,equalizerType);    
end

%==================================
save Sim_MA_08_QPSK_OFDM_MFC.mat;
%==================================

figure(1)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_ZF','-*r',SNR,SER_ofdm_vehA_ZF','-sb');
    set(G,'LineWidth',[1.5]);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',14,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',14,'color','b');
    L   =legend('OFDM - k�nh AWGN','OFDM - k�nh pha �inh m�i tr��ng �i b�','OFDM - k�nh pha �inh m�i tr��ng xe c�');
    set(L,'fontname','.Vntime','fontsize',13);
    grid on
    T=title(strvcat(strcat('SER c�a h� th�ng OFDM trong c�c m�',...
        ' h�nh k�nh kh�c nhau'),'        v� ph��ng ph�p c�n b�ng k�nh ZF'));
    set(T,'fontname','.Vntime','fontsize',18,'color','b');    

figure(2)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_MMSE','-*r',SNR,SER_ofdm_vehA_MMSE','-sb');
    set(G,'LineWidth',[1.5]);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',14,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',14,'color','b');
    L   =legend('OFDM - k�nh AWGN','OFDM - k�nh pha �inh m�i tr��ng �i b�','OFDM - k�nh pha �inh m�i tr��ng xe c�');
    set(L,'fontname','.Vntime','fontsize',13);
    grid on
    T=title(strvcat(strcat('SER c�a h� th�ng OFDM trong c�c m�',...
        ' h�nh k�nh kh�c nhau'),'        v� ph��ng ph�p c�n b�ng k�nh MMSE'));
    set(T,'fontname','.Vntime','fontsize',18,'color','b');    
    
figure(3)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_MMSE','-*r',SNR,SER_ofdm_vehA_MMSE','-sb',...
    SNR,SER_ofdm_pedA_ZF','-vb',SNR,SER_ofdm_vehA_ZF','-vr');
    set(G,'LineWidth',[1.5]);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',14,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',14,'color','b');
    L   =legend('OFDM - k�nh AWGN','OFDM - K�nh MFC/pedA & B� l�c MMSE','OFDM - K�nh MFC/vehA & B� l�c MMSE',...
        'OFDM - K�nh MFC/pedA & B� l�c ZF','OFDM - K�nh MFC/vehA & B� l�c ZF');
    set(L,'fontname','.Vntime','fontsize',13);
    grid on
    T=title(strvcat(strcat('SER c�a h� th�ng OFDM trong c�c m�',...
        ' h�nh k�nh kh�c nhau'),'        v� ph��ng ph�p c�n b�ng k�nh MMSE & ZF'));
    set(T,'fontname','.Vntime','fontsize',18,'color','b');
%==========================================================================    
%==========================================================================
%===================== Presentation_Sim_MA_08 =============================
%==========================================================================

clc;
clear all;
close all;
%==========================================================================
    load Sim_MA_08_QPSK_OFDM_MFC.mat;
%==========================================================================
%--------------------------------------------------------------------------    
    Xsize   = 14;
    Ysize   = 18;
    Ysize   = 18;
    Lsize   = 18;
    LTsize  = 18;

%--------------------------------------------------------------------------
figure(1)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_ZF','-*r',SNR,SER_ofdm_vehA_ZF','-sb');
    set(G,'LineWidth',1.5);        
    X   =xlabel('SNR [dB]');
    set(X,'fontname','.Vntime','fontsize',Xsize,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',Ysize,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - kªnh pha ®inh m«i tr­êng ®i bé','OFDM - kªnh pha ®inh m«i tr­êng xe cé');
    set(L,'fontname','.Vntime','fontsize',Lsize);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh ZF'));
    set(T,'fontname','.Vntime','fontsize',LTsize,'color','b');    
%--------------------------------------------------------------------------
figure(2)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_MMSE','-*r',SNR,SER_ofdm_vehA_MMSE','-sb');
    set(G,'LineWidth',1.5);        
    X   =xlabel('SNR [dB]');
    set(X,'fontname','.Vntime','fontsize',14,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',14,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - kªnh pha ®inh m«i tr­êng ®i bé','OFDM - kªnh pha ®inh m«i tr­êng xe cé');
    set(L,'fontname','.Vntime','fontsize',13);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE'));
    set(T,'fontname','.Vntime','fontsize',18,'color','b');    
%--------------------------------------------------------------------------    
figure(3)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_MMSE','-*r',SNR,SER_ofdm_vehA_MMSE','-sb',...
    SNR,SER_ofdm_pedA_ZF','-vb',SNR,SER_ofdm_vehA_ZF','-vr');
    set(G,'LineWidth',[1.5]);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',14,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',14,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - Kªnh MFC/pedA & Bé läc MMSE','OFDM - Kªnh MFC/vehA & Bé läc MMSE',...
        'OFDM - Kªnh MFC/pedA & Bé läc ZF','OFDM - Kªnh MFC/vehA & Bé läc ZF');
    set(L,'fontname','.Vntime','fontsize',13);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE & ZF'));
    set(T,'fontname','.Vntime','fontsize',18,'color','b');

%==========================================================================
%==========================================================================
%==========================================================================
figure(4)
    Xsize   = 12;
    Ysize   = 18;
    Lsize   = 12;
    LTsize  = 14;
%----------------------------------
subplot(1,2,1)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_ZF','-*r',SNR,SER_ofdm_vehA_ZF','-sb');
    set(G,'LineWidth',1.5);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',Xsize,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',Ysize,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - kªnh pha ®inh m«i tr­êng ®i bé','OFDM - kªnh pha ®inh m«i tr­êng xe cé');
    set(L,'fontname','.Vntime','fontsize',Lsize);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh ZF'));
    set(T,'fontname','.Vntime','fontsize',LTsize,'color','b');    
%----------------------------------
subplot(1,2,2)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_MMSE','-*r',SNR,SER_ofdm_vehA_MMSE','-sb');
    set(G,'LineWidth',1.5);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',Xsize,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',Ysize,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - kªnh pha ®inh m«i tr­êng ®i bé','OFDM - kªnh pha ®inh m«i tr­êng xe cé');
    set(L,'fontname','.Vntime','fontsize',Lsize);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE'));
    set(T,'fontname','.Vntime','fontsize',LTsize,'color','b');    
    
%==========================================================================
%==========================================================================
%==========================================================================
figure(5)
    Xsize   = 12;
    Ysize   = 18;
    Lsize   = 7;
    LTsize  = 9;

%----------------------------------
subplot(1,3,1)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_ZF','-*r',SNR,SER_ofdm_vehA_ZF','-sb');
    set(G,'LineWidth',1.5);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',Xsize,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',Ysize,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - kªnh pha ®inh m«i tr­êng ®i bé','OFDM - kªnh pha ®inh m«i tr­êng xe cé');
    set(L,'fontname','.Vntime','fontsize',Lsize);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh ZF'));
    set(T,'fontname','.Vntime','fontsize',LTsize,'color','b');    
    
%----------------------------------
subplot(1,3,2)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_MMSE','-*r',SNR,SER_ofdm_vehA_MMSE','-sb');
    set(G,'LineWidth',1.5);        
    X   =xlabel('SNR (dB)');
    set(X,'fontname','.Vntime','fontsize',Xsize,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',Ysize,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - kªnh pha ®inh m«i tr­êng ®i bé','OFDM - kªnh pha ®inh m«i tr­êng xe cé');
    set(L,'fontname','.Vntime','fontsize',Lsize);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE'));
    set(T,'fontname','.Vntime','fontsize',LTsize,'color','b');    
    
%----------------------------------    
subplot(1,3,3)
G = semilogy(SNR,SER_ofdm_AWGN','-vk',SNR,SER_ofdm_pedA_MMSE','-*r',SNR,SER_ofdm_vehA_MMSE','-sb',...
    SNR,SER_ofdm_pedA_ZF','-vb',SNR,SER_ofdm_vehA_ZF','-vr');
    set(G,'LineWidth',1.5);        
    X   =xlabel('SNR [dB]');
    set(X,'fontname','.Vntime','fontsize',Xsize,'color','b');
    Y   =ylabel('SER');
    set(Y,'fontname','.Vntime','fontsize',Ysize,'color','b');
    L   =legend('OFDM - kªnh AWGN','OFDM - Kªnh MFC/pedA & Bé läc MMSE','OFDM - Kªnh MFC/vehA & Bé läc MMSE',...
        'OFDM - Kªnh MFC/pedA & Bé läc ZF','OFDM - Kªnh MFC/vehA & Bé läc ZF');
    set(L,'fontname','.Vntime','fontsize',Lsize);
    grid on
    T=title(strvcat(strcat('SER cña hÖ thèng OFDM trong c¸c m«',...
        ' h×nh kªnh kh¸c nhau'),'        vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE & ZF'));
    set(T,'fontname','.Vntime','fontsize',LTsize,'color','b'); 
    
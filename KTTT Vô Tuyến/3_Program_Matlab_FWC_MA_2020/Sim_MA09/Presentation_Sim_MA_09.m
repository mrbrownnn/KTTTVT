%==========================================================================
%===================== Presentation_Sim_MA_09 =============================
%==========================================================================

clc;
clear all;
close all;
%==========================================================================
    load Sim_MA_09_SC_FDMA_MFC.mat;
%==========================================================================
%------------------------------------------------             
%------------------------------------------------             
G=semilogy(SNR,SER1','-ob',SNR,SER2','-vk',...
           SNR,SER3','-sr',SNR,SER4','-^m');
set(G,'LineWidth',[1.5]);       
X=xlabel('SNR [dB]');
set(X,'fontname','.Vntime','fontsize',14,'color','b');
Y=ylabel('SER');
set(Y,'fontname','.Vntime','fontsize',14,'color','b');

L=legend('IFDMA, Subband 0','LFDMA, Subband 0',...
    'IFDMA, Subband 15','LFDMA, Subband 15');
set(L, 'fontname','.Vntime','fontsize',13);
grid on        
% =========================================================================
if   channelType     == 'pedA'; % 'pedA'; 'vehA'    
    if  equalizerType   == 'MMSE'; % 'MMSE'; 'ZERO'
        T=title(strvcat('SER cña hÖ thèng SC-FDMA víi m« h×nh kªnh PedA',...
            '       vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE'));
    else % equalizerType  'ZERO'
        T=title(strvcat('SER cña hÖ thèng SC-FDMA víi m« h×nh kªnh PedA',...
            '       vµ ph­¬ng ph¸p c©n b»ng kªnh ZF'));
        set(T,'fontname','.Vntime','fontsize',13,'color','b');        
    end
    
else % channelType     == 'vehA'    
    if  equalizerType   == 'MMSE'; % 'MMSE'; 'ZERO'
        T=title(strvcat('SER cña hÖ thèng SC-FDMA víi m« h×nh kªnh vehA',...
            '       vµ ph­¬ng ph¸p c©n b»ng kªnh MMSE'));
    else % equalizerType  'ZERO'
        T=title(strvcat('SER cña hÖ thèng SC-FDMA víi m« h×nh kªnh vehA',...
            '       vµ ph­¬ng ph¸p c©n b»ng kªnh ZF'));
    end
end
set(T,'fontname','.Vntime','fontsize',13,'color','b');
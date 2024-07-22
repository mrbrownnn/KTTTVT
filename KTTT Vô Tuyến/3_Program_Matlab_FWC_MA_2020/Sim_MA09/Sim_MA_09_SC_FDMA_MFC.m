%==========================================================================
%====================== Sim_MA_09_SC_FDMA_MFC =============================
% ----------------- Comparision: SER of SC-FDMA in AWGN & MFC -------------
%--------------- Simlation SER of SC-FDMA with mapping subcarier ----------
%==========================================================================
clc;
clear all;
close all;
%------------------------------------------------
% set parameter
FFTsize         = 512;
inputBlockSize  = 16;
CPsize          = 20;
SNR             = [1:2:14];
numRun          = 10^3;
dataType        = 'Q-PSK';   
channelType     = 'vehA';   % 'pedA'; 'vehA'
equalizerType   = 'ZERO';   % 'MMSE'; 'ZERO'
subband         =  0;        % subband = 0; subband = 15;
%==========================================================================
SER1 = MA_09_SER_ifdma(SNR,numRun,inputBlockSize,FFTsize,dataType,CPsize,...
                 subband,channelType,equalizerType);
SER2 = MA_09_SER_lfdma(SNR,numRun,inputBlockSize,FFTsize,dataType,CPsize,...
                 subband,channelType,equalizerType);             
%------------------------------------------------
subband = 15;
SER3 = MA_09_SER_ifdma(SNR,numRun,inputBlockSize,FFTsize,dataType,CPsize,...
                 subband,channelType,equalizerType);
SER4 = MA_09_SER_lfdma(SNR,numRun,inputBlockSize,FFTsize,dataType,CPsize,...
                 subband,channelType,equalizerType);
%==========================================================================
    save Sim_MA_09_SC_FDMA_MFC.mat;
%==========================================================================
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
%--------------------------------------------------------------------------
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
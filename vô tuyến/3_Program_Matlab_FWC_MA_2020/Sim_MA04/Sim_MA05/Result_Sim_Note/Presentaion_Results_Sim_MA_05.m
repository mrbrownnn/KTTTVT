%==========================================================================
%======== Presentation: Comparision: Performance of DS_CDMA_Systems =======
%===================  Presentaion_Results_Sim_MA_05  ======================
%==========================================================================

clc;
clear all;
close all;
%%%%-----------------------------------------------------------------------
% proerty = char(['-vr','-ob','-d','-sg']);

%==========================================================================
    load sim_ds_cdma_Mseq_awgn.mat; 
    num_fig = 1;
    Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);
%==========================================================================
    clear;
    load sim_ds_cdma_Mseq_rayleigh.mat;
    num_fig = 2;
    Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);

%==========================================================================
figure(3)
    subplot(1,2,1)
    clear;
    load sim_ds_cdma_Mseq_awgn.mat; 
    num_fig = 0;
    Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);
    %======================================================================
    subplot(1,2,2)
    clear;
    load sim_ds_cdma_Mseq_rayleigh.mat;
    num_fig = 0;
    Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);


%==========================================================================    
%==========================================================================
clear;
figure(8)
    subplot(1,3,1)
        load sim_ds_cdma_Mseq_awgn.mat;    
        num_fig = 0;        
        Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);
        % text(2,7e-5,'Kªnh AWGN, Chuçi M','FontName','.VnTime','Color','b','FontSize',14);
    
    subplot(1,3,2)
        clear;
        load sim_ds_cdma_Goldseq_awgn.mat;        
        num_fig = 0;        
        Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);
    
    subplot(1,3,3)    
        clear;
        load sim_ds_cdma_OrthGoldseq_awgn.mat;
        num_fig = 0;        
        Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);         
    
%==========================================================================    
%==========================================================================
figure(9)
    subplot(1,3,1)    
        clear;
        load sim_ds_cdma_Mseq_rayleigh.mat;         
        num_fig = 0;        
        Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);         
    
    subplot(1,3,2)
        clear;
        load sim_ds_cdma_Goldseq_rayleigh.mat;    
        num_fig = 0;        
        Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);         
    
    subplot(1,3,3)
        clear;
        load sim_ds_cdma_OrthGoldseq_rayleigh.mat;
        num_fig = 0;        
        Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);
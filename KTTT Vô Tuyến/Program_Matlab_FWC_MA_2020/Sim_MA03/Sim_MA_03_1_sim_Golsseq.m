%==========================================================================
%=========================  Sim_MA_03_1_sim_Golsseq =======================
%==========================================================================

% function HW_Chaper3_1_MA_gold

clc;
clear all;
close all;

%--------------------------------------------
% function [gout] = NVD_goldseq(m1, m2, n)

% The generation function of Gold sequence

% ****************************************************************
% m1 : M-sequence 1
% m2 : M-sequence 2
% n  : Number of output sequence(It can be omitted)
% gout : output Gold sequence
% ****************************************************************

%--------------------------------------------
% m1 : M-sequence 1
Number_stages               = 3;
Position_registerfeedback   = [1 3];
Initial_sequence            = [1 1 1];
Number_outputsequence       = 1;
m_1   = MA_03_mseq(Number_stages,Position_registerfeedback,Initial_sequence,Number_outputsequence);

input_sequence  = 1-2*m_1;
number_period   = 2;
Rxx_1  = (1/length(m_1))*MA_03_autocorr(input_sequence, number_period);

%--------------------------------------------
% m2 : M-sequence 2
Number_stages               = 3;
Position_registerfeedback   = [2 3];
Initial_sequence            = [1 1 1];
Number_outputsequence       = 1;
m_2   = MA_03_mseq(Number_stages,Position_registerfeedback,Initial_sequence,Number_outputsequence);

input_sequence  = 1-2*m_2;
number_period   = 2;
Rxx_2  = (1/length(m_2))*MA_03_autocorr(input_sequence, number_period);


%--------------------------------------------
% The generation function of Gold sequence
g_1     = MA_03_goldseq(m_1, m_2,1);
g1      = 1-2*g_1;

%------------------------------------------------------------------
% Autocorrelation function of a sequence
% indata : input sequence
% tn     : number of period
% out    : autocorrelation data
%------------------------------------------------------------------
input_sequence  = g1;
number_period   = 2;
Rxx  = (1/length(g1))*MA_03_autocorr(input_sequence, number_period);

%%%%%%%%%%%%%%%%%%
figure(1)
subplot(2,1,1);
stem(g1,'r','LineWidth',[3.5]);
xlabel('Thoi gian','FontName','.VnTime','color','b','FontSize',12);
ylabel('Bien do','FontName','.VnTime','color','b','FontSize',12);
title(['Chuoi GOLD  voi chu ky N = ',num2str(length(g1))],...
        'FontName','.VnTime','color','b','FontSize',12);
axis([1 length(g1) -2 2]);
grid on;

subplot(2,1,2);
plot(Rxx,'LineWidth',[1.5]);
xlabel('tre','FontName','.VnTime','color','b','FontSize',12);
ylabel('R_X_X(i)','FontName','.VnTime','color','b','FontSize',12);
title(['Ham tu tuong quan cua chuoi GOLD voi so chu ky = ',num2str(number_period)],...
        'FontName','.VnTime','color','b','FontSize',12);
hold on;
stem(Rxx,'r','LineWidth',[3.5]);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
    subplot(4,1,1);
    m1=1-2*m_1;
    stem(m1,'r','LineWidth',[3.5]);
    xlabel('Thoi gian','FontName','.VnTime','color','b','FontSize',12);
    ylabel('Bien do','FontName','.VnTime','color','b','FontSize',12);
    title(['Chuoi m1  voi chu ky N = ',num2str(length(m1))],...
        'FontName','.VnTime','color','b','FontSize',12);
    axis([1 length(m1) -2 2]);
    grid on;

subplot(4,1,2);
    m2=1-2*m_2;
    stem(m2,'r','LineWidth',[3.5]);
    xlabel('Thoi gian','FontName','.VnTime','color','b','FontSize',12);
    ylabel('Bien do','FontName','.VnTime','color','b','FontSize',12);
    title(['Chuoi m2  voi chu ky N = ',num2str(length(m1))],...
        'FontName','.VnTime','color','b','FontSize',12);
    axis([1 length(m2) -2 2]);
    grid on;

subplot(4,1,3);
    stem(g1,'r','LineWidth',[3.5]);    
    xlabel('Thoi gian','FontName','.VnTime','color','b','FontSize',12);
    ylabel('Bien do','FontName','.VnTime','color','b','FontSize',12);
    title(['Chuoi GOLD  voi chu ky N = ',num2str(length(g1))],...
        'FontName','.VnTime','color','b','FontSize',12);
    axis([1 length(g1) -2 2]);
    grid on;

subplot(4,1,4);
    plot(Rxx,'LineWidth',[1.5]);
    xlabel('tre','FontName','.VnTime','color','b','FontSize',12);
    ylabel('R_X_X(i)','FontName','.VnTime','color','b','FontSize',12);
    title(['Ham tu tuong quan cua chuoi GOLD voi so chu ky = ',num2str(number_period)],...
        'FontName','.VnTime','color','b','FontSize',12);
    hold on;
    stem(Rxx,'r','LineWidth',[3.5]);
    grid on;
%----------------------------------------------------
    
    
figure(3)    
subplot(3,1,1);
    plot(Rxx_1,'LineWidth',[1.5]);
    xlabel('tre','FontName','.VnTime','color','b','FontSize',12);
    ylabel('R_X_X(i)','FontName','.VnTime','color','b','FontSize',12);
    title(['Ham tu tuong quan cua chuoi m1 voi so chu ky = ',num2str(number_period)],...
        'FontName','.VnTime','color','b','FontSize',12);
    hold on;
    stem(Rxx_1,'r','LineWidth',[3.5]);
    grid on;    
    
subplot(3,1,2);
    plot(Rxx_2,'LineWidth',[1.5]);
    xlabel('tre','FontName','.VnTime','color','b','FontSize',12);
    ylabel('R_X_X(i)','FontName','.VnTime','color','b','FontSize',12);
    title(['Ham tu tuong quan cua chuoi m2 voi so chu ky = ',num2str(number_period)],...
        'FontName','.VnTime','color','b','FontSize',12);
    hold on;
    stem(Rxx_2,'r','LineWidth',[3.5]);
    grid on;    

subplot(3,1,3);
    plot(Rxx,'LineWidth',[1.5]);
    xlabel('tre','FontName','.VnTime','color','b','FontSize',12);
    ylabel('R_X_X(i)','FontName','.VnTime','color','b','FontSize',12);
    title(['Ham tu tuong quan cua chuoi GOLD voi so chu ky = ',num2str(number_period)],...
        'FontName','.VnTime','color','b','FontSize',12);
    hold on;
    stem(Rxx,'r','LineWidth',[3.5]);
    grid on;
    
    
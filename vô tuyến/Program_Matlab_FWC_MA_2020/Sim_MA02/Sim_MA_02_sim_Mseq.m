%==========================================================================
%=========================  Sim_MA_02_sim_Mseq ==========================
%==========================================================================
clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The generation function of M-sequence
% ****************************************************************
% stg     : Number of stages
% taps    : Position of register feedback
% inidata : Initial sequence
% n       : Number of output sequence(It can be omitted)
% mout    : output M sequence
% ****************************************************************

Number_stages               = 5;
Position_registerfeedback   = [1 3 4 5];
Initial_sequence            = [1 0 1 1 1];
Number_outputsequence       = 1;

m_seq   = MA_03_mseq(Number_stages,Position_registerfeedback,Initial_sequence,Number_outputsequence);
m1      = m_seq;
m_seq   = 1- 2*m_seq;

%------------------------------------------------------------------
% Autocorrelation function of a sequence
% indata : input sequence
% tn     : number of period
% out    : autocorrelation data
%------------------------------------------------------------------
input_sequence  = m_seq;
number_period   = 1;
Rxx  = (1/length(m_seq))*MA_03_autocorr(input_sequence, number_period);

%%%%%%%%%%%%%%%%%%
figure(1)
subplot(2,1,1);
stem(m_seq,'r','LineWidth',[3.5]);
xlabel('Thoi gian','FontName','.VnTime','color','b','FontSize',14);
ylabel('Bien do','FontName','.VnTime','color','b','FontSize',14);
title(['Chuoi m  voi chu ky N = ',num2str(length(m_seq))],...
        'FontName','.VnTime','color','b','FontSize',14);
axis([1 length(m_seq) -2 2]);
grid on;

subplot(2,1,2);
plot(Rxx,'LineWidth',[1.5]);
xlabel('tre','FontName','.VnTime','color','b','FontSize',14);
ylabel('Ham tu tuong quan cua chuoi','FontName','.VnTime','color','b','FontSize',14);
title(['Ham tu tuong quan cua chuoi voi so chu ky = ',num2str(number_period)],...
        'FontName','.VnTime','color','b','FontSize',14);
hold on;
stem(Rxx,'r','LineWidth',[3.5]);
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
plot(Rxx,'LineWidth',[3.5]);
xlabel('Tre','FontName','.VnTime','color','b','FontSize',14);
ylabel('Ham tu tuong quan cua chuoi','FontName','.VnTime','color','b','FontSize',18);
title(['Ham tu tuong quan cua chuoi voi so chu ky = ',num2str(number_period)],...
        'FontName','.VnTime','color','b','FontSize',18);

hold on;
stem(Rxx,'r','LineWidth',[3.5]);
grid on;
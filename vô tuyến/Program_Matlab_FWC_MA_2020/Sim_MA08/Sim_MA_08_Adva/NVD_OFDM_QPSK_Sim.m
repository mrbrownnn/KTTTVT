% function NVD_OFDM_QPSK_Sim
clc;
clear all;
close all;

% Set parameter: numbits,fp,fc, T0, TP, TG, A, N,
% numbits     = 1024;             % number of bits to be transmitted
% fp          = 1e9;              % central frequency
% fc          = 50e9;             % sampling frequency   
% T0          = 242.4e-9;         % information length
% TP          = 60.6e-9;          % cyclic prefix
% TG          = 70.1e-9;          % total guard time
% A           = 1;                % amplitude of the rectangular impulse response
% N           = 128;              % number of carriers of the OFDM system

numbits     = 1024;                 % number of bits to be transmitted
fp          = 2e7;                  % central frequency, Carrier frequency of RF 
fc          = 3*fp;                 % sampling frequency, frequency axis
BW          = 7.68e6;               % Bandwidth of system, 7.68 MHz
N           = 128;                  % number of carriers of the OFDM system
Sub_space   = BW/N;                 % Subcarrier space 15KHz; 15e3
% N           = ceil(BW/Sub_space); % number of carriers of the OFDM system
T0          = 1/Sub_space;          % information length, T_FFT of OFDM
TP          = T0/8;                 % cyclic prefix
TG          = T0/4;                 % total guard time
A           = 1;                    % amplitude of the rectangular impulse response

[bits,S,SI,SQ,ofdm,fc,fp,T0,TP,TG,N]    = NVD_OFDM_qpsk(numbits,fp,fc,T0,TP,TG,A,N);
[PSD,df]                                = NVD_PSD(ofdm,fc);
PSD_dB                                  = 10*log10(PSD/max(PSD));

% -----------------------------------
% Step Two - Graphical representation
% -----------------------------------

frequency   = linspace(-fc/2,fc/2,length(PSD));
h11 = figure(1);
PF          = plot(frequency,PSD);
set(PF,'LineWidth',[2]);
AX          = gca;
set(AX,'FontSize',12);
X           = xlabel('Frequency [Hz]');
set(X,'FontSize',14);
Y           = ylabel('Power Spectral Density [V^2/Hz]');
set(Y,'FontSize',14);
% axis([0.9*10^9 1.2*10^9 -0.001 20*10^-10]);
grid on;

h21 = figure(2);
PF = plot(frequency,PSD_dB);
set(PF,'LineWidth',[2]);
AX          = gca;
set(AX,'FontSize',12);
X           = xlabel('Frequency [Hz]');
set(X,'FontSize',14);
Y           = ylabel('10log_1_0[PSD/max(PSD)] dB');
set(Y,'FontSize',14);
grid on;

h21 = figure(3);
plot(ofdm)
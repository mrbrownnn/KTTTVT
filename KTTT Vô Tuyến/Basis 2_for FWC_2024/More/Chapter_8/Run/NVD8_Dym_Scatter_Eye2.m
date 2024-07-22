% File: NVD8_Dym_Scatter_Eye_sim.m
clc;
clear all;
close all;
%=========================
% Setup parameter
%=========================
N       = 16;
Fd      = 1;
Fs      = N*Fd;
Delay   = 3;
Symb    = 100;
Offset  = 0;
M       = 4;
%=====================================================
% Transmitter: Generation for data & modulation & filter
%=====================================================
msg_orig    = randsrc(Symb,1,[0:M-1],4321);
msg_tx      = modmap(msg_orig,Fd,Fd,'qask',M);
x           = complex(msg_tx(:,1),msg_tx(:,2));
[y,t]       = rcosflt(x,Fd,Fs);

%============================
% Channel: AWGN
%============================
SNR             = 5; 
sig_rx1         = awgn(msg_tx,SNR,'measured',1234,'dB');
sig_rx          = complex(sig_rx1(:,1),sig_rx1(:,2));
[fsig_rx,t2]    = rcosflt(sig_rx,Fd,Fs);
tfsig_rx        = fsig_rx(1 + Delay*N : end - Delay*(N+1),:);

%=============================
yy = y(1+Delay*N:end-Delay*(N+1));

%=============================
% Scatterplot:
%============================
% Tx
scatterplot_qa(yy,N);
%
scatterplot_qa(msg_tx,N);

scatterplot_qa(tfsig_rx,N);

% scatterplot_qa(yy,1,0,'c');
% hold on;
% h2 = scatterplot_qa(yy,N,0,'b-.',h2);
% hold on;
% h3 = scatterplot_qa(real(tfsig_rx),N,0,'b-.');


%==========================================
% h       =[];
% h7      =[];
% [h h7] = animatescattereye_qa(yy,N,.1,17,'lr',0);
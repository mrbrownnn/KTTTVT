% File: NVD8_Dym_Scatter_Eye_sim.m
clc;
clear all;
close all;

% NVD8_Scatter_sim

%%%%% (1)
N       = 16;
Fd      = 1;
Fs      = N*Fd;
Delay   = 3;
Symb    = 100;
Offset  = 0;
M       = 4;

%===================================
msg_orig    = randsrc(Symb,1,[0:M-1],4321);
msg_tx      = modmap(msg_orig,Fd,Fd,'qask',M);
x           = complex(msg_tx(:,1),msg_tx(:,2));
[y,t]       = rcosflt(x,Fd,Fs);
%===================================

%%%% (4)
yy = y(1+Delay*N:end-Delay*(N+1));

%%%%% (9)
SNR             = 15; % Thay doi de khao sat
sig_rx1         = awgn(msg_tx,SNR,'measured',1234,'dB');
sig_rx          = complex(sig_rx1(:,1),sig_rx1(:,2));
[fsig_rx,t2]    = rcosflt(sig_rx,Fd,Fs);
tfsig_rx        = fsig_rx(1 + Delay*N : end - Delay*(N+1),:);



%=========================================== note
% scatterplot_qa(yy,N);
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
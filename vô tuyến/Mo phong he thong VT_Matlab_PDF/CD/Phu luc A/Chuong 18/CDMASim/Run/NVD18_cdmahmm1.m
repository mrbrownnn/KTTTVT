% File: NVD18_cdmahmm1
clc;
clear all;
close all;

% File: NVD18_cdmahmm1.m

N       = 100000;                     % 100000
EoNdB   = 5;
EbNo    = 10^(EoNdB/10);            % specity Eb/No and Eb/No in dB
KdB     = 0; 
SF      = 7;
NoI     = 0;                        % specify parameters
MPathDelay  = [0 3 4];              % specify multipath delay

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run cdma simulation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[BER,ErrorRun]      = NVD18_cdmasim(N,SF,EbNo,NoI,MPathDelay,KdB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Develop runlength vector in required form.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lenER               = length(ErrorRun);
row2                = zeros(1,lenER);
row2(2:2:lenER)     = 1;
runcode1(1,:)       = ErrorRun;
runcode1(2,:)       = row2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Generate semi-Markov model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A_matrix, pi_est]  = NVD18_semiMarkov(runcode1,50,[2 1]);
save cdmadata1 N BER ErrorRun A_matrix runcode1
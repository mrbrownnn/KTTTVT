% File NVD18_cdmahmm2.m

clc;
clear all;
close all;

load cdmadata1                                          % load data from c18_cdmahmm1

NN              = 25000									% number of points to be used   25000
[out]           = NVD18_errvector(A_matrix,NN);         % generate error vector from HMM

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Compute and display three error probabilities.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pe2             = A_matrix^100;
pe2             = pe2(1,3);
pe3             = sum(out/NN);

a = ['Cac xac suat loi duoc du doan cho he thong CDMA: '];
b = ['      Tu mo phong goc PE                         = ', num2str(BER),'.'];
c = ['      Duoc du doan tu mo hinh semi-Markov PE     = ', num2str(pe2),'.'];
d = ['      Tu vector loi duoc tai tao                 = ', num2str(pe3),'.'];
%
disp(a)
disp(b)			% display PE from simulation
disp(c)			% display PE predicted from semi-Markov model
disp(d)			% display PE from reconstructed error vecor
save cdmadata2 out
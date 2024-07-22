% NVD15_test3

clear all;
close all;

%%%%%%%% Test1
a1  =   [0.90 0.02 0.08; 0.10 0.50 0.40; 0.10 0.20 0.70];
b1  =   [1 1 0; 0 0 1];
N   =   20000;
out1 = NVD15_errvector_test(N,a1,b1);

% out1                =   out;

runcode1            =   NVD15_seglength(out1);
[A_matrix, pi_est]  =   NVD15_semiMarkov(runcode1,100,[2 1]);
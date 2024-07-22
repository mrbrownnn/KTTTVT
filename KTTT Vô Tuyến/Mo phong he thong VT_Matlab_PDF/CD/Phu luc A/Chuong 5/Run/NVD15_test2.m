% File: NVD15_test2

clear all;
close all;

%%%%%%%% Test1
NVD15_errvector_test1;
out1        =   out;
% [p, pye, b] = NVD15_bwa_test(20,3,out);
NVD15_bwa_test(20,3,out);

%%%%%%%%%%%%%%%%
a       =   [0.9473 0.0299 0.0263; 0.1173 0.7425 0.1402; 0.0663 0.1324 0.8013];
b       =   [0.9522 0.6637 0.4313; 0.0478 0.3363 0.5678];

NVD15_errvector;
N   = 20000; 
A   =   a;
B   =   b;
out2    =   out;
runcode1 = NVD15_seglength(out1);
runcode2 = NVD15_seglength(out2);
NVD15_intervals2(runcode1,runcode2);
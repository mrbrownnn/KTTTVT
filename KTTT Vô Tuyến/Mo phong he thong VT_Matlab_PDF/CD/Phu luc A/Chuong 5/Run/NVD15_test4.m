% File NVD15_test4

clear all;
close all;

Ch15test3

%%%%%%%%
a2                  =   [0.9043 0.0 0.0957; 0.0 0.4911 0.45098; 0.1402 0.1515 0.7083];
b2                  =   [1 1 0; 0 0 1];
NVD15_errvector_test4;
out2                =   out;
runcode2            =   NVD15_seglength(out2);
NVD15_interval2(runcode1,runcode2);
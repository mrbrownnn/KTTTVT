% file: FIR_IIR_desig.m

clc;
clear all;
close all;

br = remez(42,[0 0.37 0.43 1],[1 1 0 0]);
bls = firls(42,[0 0.37 0.43 1],[1 1 0 0]);

bm = gremez(42,[0 0.37 0.43 1],...
[1 1 0 0],[1 10],'minphase');

blp = firlpnorm(30,[0 .3 .45 1],[0 .3 ...
.45 1],[1 1 0 0],[1 1 10 10]);

b = firlpnorm(40,[0 .4 .45 1],[0 .4 .45 1],...
[1 1 0 0],[1 1 10 10],[2 2]);
b2 = firls(40,[0 .4 .45 1],[1 1 0 0],[1 20]);

b = gremez('minorder',[0 .3 .45 1],...
[1 1 0 0],[.008 .0009]);

bgm = gremez('minorder',[0 .12 .14 1],...
[1 1 0 0],[0.01 0.001],'minphase');

bc = firceqrip(50,0.375,[0.008 0.0009]);

bcm=firceqrip(50,0.375,[0.008 0.0009],'min');

bc = firceqrip(40,0.45,[0.008 0.0009],...
'stopedge');

bg = gremez(40,[0 .3 .45 1],[1 1 0 0],...
[1 0.0009],{'w','c'});


b1=firhalfband(102,.47); % N and TW
b2=firhalfband(102,.01,'dev'); % N and R
b3=firhalfband('minorder',.47,.01);% TW and R

h = mfilt.firinterp(2,2*b3);
polyphase(h);

b1 = firnyquist('minorder',4,.1,.01); % L=4
b2 = firceqrip(90,.25,[.01 .01]);

%============================
N = 20; % Filter order
Npow = 5; % Sinc power
w = 0.5; % Sinc frequency factor
Apass = 5.7565e-004; % 0.01 dB
Astop = 0.01; % 40 dB
Aslope = 60; % 60 dB slope
Fpass = 80/541.666; % Passband-edge
cfir = firceqrip(N,Fpass,[Apass, Astop],...
    'passedge','slope',...
Aslope,'invsinc',[w,Npow]);
Hcfir = mfilt.firdecim(2,cfir);
%===========================
N = 62;
Fs=541666;
F=[0 80e3 100e3 122e3 132e3 541666/2]/(Fs/2);
A = [1 1 0 0 0 0];
W = [10 1 10];
pfir= gremez(N,F,A,W);
Hpfir = mfilt.firdecim(2,pfir);
%===========================
N = 62;
Fs=541666;
F=[0 80e3 100e3 541666/2]/(Fs/2);
A = [1 1 0 0];
W = [1 1];
pfir= gremez(N,F,A,W);
Hpfir = mfilt.firdecim(2,pfir);
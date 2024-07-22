% File: c5_sqrcdemo.m
clc;
clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup the parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T       = 1;						% symbol time
k       = 10;						% samples per symbol
m       = 4;						% delay
beta    = 0.32;						% bandwidth factor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h       = NVD5_sqrc(T,k,m,beta);	% impulse response
in      = zeros(1,101); in(11) = 1; % input
out     = conv(in,h);				% output h[10]
out1    = conv(out,h);				% conv of h[n-10] and h[n]
t       = 2:0.1:8;					% time vector for plot

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Display results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot h[n-10]
subplot(2,1,1)
stem(t,out(21:81),'.'); grid
xlabel('Th�i gian','fontname','.Vntime','color','b','fontsize',12);
ylabel('p[n-1]','fontname','.Vntime','color','b','fontsize',14);
title('��p �ng xung kim c�a b� l�c s�: p[n-1]','fontname','.Vntime','color','b','fontsize',12);

% plot conv of h[n-10] and h[n]
subplot(2,1,2)
t1 = 6:0.1:12;					% time vector for plot
stem(t1,out1(61:121),'.'); grid
xlabel('Th�i gian','fontname','.Vntime','color','b','fontsize',12);
ylabel('conv(p[n-1],p[n])','fontname','.Vntime','color','b','fontsize',14);
title('T�ng ch�p c�a ��p �ng xung kim b� l�c s�: conv(p[n-1],p[n])','fontname','.Vntime','color','b','fontsize',12);
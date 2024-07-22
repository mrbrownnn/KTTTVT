% File: NVD5_rcosdsim.m
clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%
% Setup parameters
%%%%%%%%%%%%%%%%%%%%%%%%

k       = 10;							% samples per symbol
m       = 4;							% delay
beta    = 0.32;             			% bandwidth factor
t       = 0:0.1:10;						% time vector for plot
%%%%%%%%%%%%%%%%%%%%%%%%
% Main program
%%%%%%%%%%%%%%%%%%%%%%%%
h       = NVD5_rcos(k,m,beta);			% impulse response
in      = zeros(1,101); in(11) = 1;	    % input
out     = conv(in,h);					% output
%%%%%%%%%%%%%%%%%%%%%%%
% Display result
%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(3,1,1)
stem(h)

subplot(3,1,2)
stem(in)

subplot(3,1,3)
stem(t,out(1:101),'.')
xlabel('Th�i gian','fontname','.Vntime','color','b','fontsize',12);
ylabel('Bi�n ��','fontname','.Vntime','color','b','fontsize',14);
title('��p �ng b� l�c Cosine t�ng','fontname','.Vntime','color','b','fontsize',14);
grid;
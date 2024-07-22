% function NVD5_hreefilters
% File: NVD5_threefilters.m

clc;
clear all;
close all;
T       = 0.01;
f       = 0:0.1:50;
% Define for z see (5.4)
z       = exp(-i*2*pi*f*T);
% bilinear invariant Filter
a0      = 0.239057;
a1      = 0.239057;
b1      = 0.521886;
num     = a0+a1*z;
den     = 1-b1*z;
ampx    = abs(num./den);
% impulse invariant Filter
a0      = 0.628319; 
b1      = 0.533488;
num     = a0;
den     = 1-b1*z;
ampy    = abs(num./den);
% step invriant Filter	
a0      = 1.0; 
a1      = 0.533488;
b1      = 0.533488;
num     = (a0-a1)*z;
den     = 1-b1*z;
ampz    = abs(num./den);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display results
%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(f,ampy,'-h',f,ampz,'*g',f,ampx,'-o')
xlabel('T�n s� [Hz]','FontName','.VnTime','color','b','FontSize',12);
ylabel('��p �ng bi�n ��','FontName','.VnTime','color','b','FontSize',12);
legend('Impulse-Invariant Filter','Step-Invariant Filter','Bilinear z - transform Filter');
title('SS ��p �ng bi�n �� gi�a ba b� l�c; z ���c x�c ��nh b�i (5.4)',...
    'FontName','.VnTime','color','b','FontSize',12);
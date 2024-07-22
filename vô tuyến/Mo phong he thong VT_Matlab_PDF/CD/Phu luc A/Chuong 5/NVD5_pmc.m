% File: NVD5_pmc.m
clc;
close all;
clear all;
order   = 50,               					% points in impulse response	
f       = [0 0.1 0.12 0.23 0.25 0.35 0.37 1];	% frequency points
amp     = [1 1 0 0 1 1 0 0];        			% amplitude response
%==================
b       = remez(order,f,amp);              		% synthesize filter
%==================

%===========================
% Display results
%===========================
%===========
figure(1)% plot impulse response
stem(b,'.k')
xlabel('Ch� s� m�u','fontname','.vntime','fontsize',12);
ylabel('Bi�n ��','fontname','.vntime','fontsize',12);
title('��p �ng xung kim','fontname','.vntime','fontsize',14);
figure(2)% am response
freqz(b,1);
% xlabel('T�n s� chu�n h�a','fontname','.vntime','fontsize',12);
% ylabel('Bi�n ��','fontname','.vntime','fontsize',12);
title('��p �ng bi�n �� v� ��p �ng pha','fontname','.vntime','fontsize',14);


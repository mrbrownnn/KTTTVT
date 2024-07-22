% File: NVD5_FIRFilterExample.m
clc;
clear all;
close all;

% scaling parameters
fscale      = 1; 
fshift      = 0.0; 
dscale      = 1000;

NVD5_FilterData;       % load data
Freq_Resp   = data;
fs          = 900; 
filtsize    = 512;
ts          = 1/fs;
[himp time] = NVD5_Filter_AMP_Delay(Freq_Resp,fs,filtsize,fscale,fshift,dscale); 

%===================
% Apply a window
%===================
nw          = 256;
window1     = hamming(nw);
window      = zeros(filtsize,1);

%=============================
% Make sure the window is centered properly.
%=============================
wstart              = (filtsize/2)-(nw/2); wend = (filtsize/2)+(nw/2)-1;  
window(wstart:wend) = window1;
impw                = himp.*window';
%============================
figure(1); 
subplot(1,2,1);
plot(abs(himp));
grid;
xlabel('Ch� s� m�u th�i gian','fontname','.vntime','fontsize',12); 
ylabel('��p �ng xung kim b� l�c','fontname','.vntime','fontsize',12);
title('Kh�ng ���c c�a s� h�a','fontname','.vntime','fontsize',12);
subplot(1,2,2);
plot(abs(impw));
grid;
xlabel('Ch� s� m�u th�i gian','fontname','.vntime','fontsize',12);
ylabel('��p �ng xung kim b� l�c ���c c�a s� h�a','fontname','.vntime','fontsize',12);
title('���c c�a s� h�a','fontname','.vntime','color','b','fontsize',12);

%================================================
[logpsd,freq,ptotal,pmax]   = NVD5_log_psd(himp,filtsize,ts);
[logpsdw,freq,ptotal,pmax]  = NVD5_log_psd(impw,filtsize,ts);
%================================================
%=========
figure(2);
subplot(1,2,1)
plot(freq(128:384),logpsd(128:384)); grid;
xlabel('Ch� s� m�u t�n s�','fontname','.vntime','fontsize',12);
ylabel('��p �ng t�n s�','fontname','.vntime','fontsize',12);
title('Kh�ng ���c c�a s� h�a','fontname','.vntime','fontsize',12);
subplot(1,2,2)
plot(freq(128:384),logpsdw(128:384)); grid; 
xlabel('Ch� s� m�u t�n s�','fontname','.vntime','fontsize',12); 
ylabel('��p �ng t�n s� ���c c�a s� h�a','fontname','.vntime','fontsize',12);
title('���c c�a s� h�a','fontname','.vntime','color','b','fontsize',12);
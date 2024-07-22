% File: NVD12_sim3.m
clc;
clear all;
close all;
% This is an example of the response of Saleh's LPE model 
% showing the IM products when the input is the sum of two tones.

backoff = input('Nhap backoff don vi dB (5) > ');

f1      = -1.0;
f2      = 2.0;
ts      = 1.0/128; 
n       = 1024;

for k=1:n
   t(k) = (k-1)*ts;
   x(k) = exp(i*2*pi*f1*t(k))+0.707*exp(i*2*pi*f2*t(k));
   y(k) = NVD12_salehs_model(x(k),-1*backoff,1);
end
[psdx,freq] = NVD12_log_psd(x,n,ts);
[psdy,freq] = NVD12_log_psd(y,n,ts);

subplot(2,1,1)
plot(freq,psdx); grid;
xlabel('TÇn sè Hz ','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD [dB]','fontname','.Vntime','color','b','fontsize',14);
title('§Æt vµo phÇn tö phi tuyÕn NL','fontname','.Vntime','color','b','fontsize',14);

subplot(2,1,2)
plot(freq,psdy); grid;
xlabel('TÇn sè Hz ','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD [dB]','fontname','.Vntime','color','b','fontsize',14);
title('§Çu ra cña phÇn tö phi tuyÕn NL ','fontname','.Vntime','color','b','fontsize',14);
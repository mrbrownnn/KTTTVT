% file: NVD12_sim2.m
clc;
clear all;
close all;

% This example implements both Lowpass and  bandpass versions of a 
% power series nonlinearity of the form  y(t) = x(t) - a3*x(t)^3
% For the BP Model f1=11Hz; f2=14Hz; IM @ 8 and 17 Hz 3rd harmonics at  33 and 42
%
% For the LPE model the ref freq is :f0 =10Hz and  hence f1=-1  and f2=2 Hz; IM @  -4 and 5Hz
% Input parameters: None; Plots: BP input; BP output; LPE input; LPE Output 

f1      = 11.0;
f2      = 14.0;
ts      = 1.0/128;
n       = 1024;
a3      = 0.3;
%=====================================
% Generate input samples
for k=1:n
    t(k) = (k-1)*ts;
    x(k) = cos(2*pi*f1*t(k))+0.707*cos(2*pi*f2*t(k));
end
%=====================================
% Generate output samples
for k=1:n
	y(k) = x(k)-a3*x(k)^3;
end
%=====================================
% Plot the results
[psdx,freq] = NVD12_log_psd(x,n,ts); 
[psdy,freq] = NVD12_log_psd(y,n,ts);
h1=figure(1);
set(h1,'color','g');
set(h1,'Name','Designed by Nguyen Viet Dam');
subplot(2,1,1)
plot(freq,psdx,'b'); grid;
xlabel('TÇn sè Hz ','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD [dB]','fontname','.Vntime','color','b','fontsize',14);
title('§Çu vµo BP @ f_1 = 11 vµ f_2=14','fontname','.Vntime','color','b','fontsize',14);

subplot(2,1,2)
plot(freq,psdy,'b'); grid;  
xlabel('TÇn sè Hz ','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD [dB]','fontname','.Vntime','color','b','fontsize',14);
title('§Çu ra BP: IM  @ 8 vµ 17 vµ hµi bËc ba','fontname','.Vntime','color','b','fontsize',14);

%=====================================================================
% This  Section of the model implements the LPE model for the 3-rd order 
% power series nonlinearity. Baseband model: y(t) = x(t) - a3*x(t)^3.
% LPE Model: y(k)=x(k)+0.75*a3*(abs(x(k))^2)*x(k);
%======================================================================
% Generate LPE of the input signals using 12Hz as the ref frequency
% and generate output samples using the LPE model%
f1  =   -1.0; 
f2  =   2.0; 
for k=1:n
    t(k) = (k-1)*ts;
    x(k) = exp(i*2*pi*f1*t(k))+0.707*exp(i*2*pi*f2*t(k));
    y(k) = x(k)+0.75*a3*(abs(x(k))^2)*x(k);
end
%=====================================
% Plot the results
[psdx,freq] = NVD12_log_psd(x,n,ts);
[psdy,freq] = NVD12_log_psd(y,n,ts);
h2=figure(2);
set(h2,'color','g');
set(h1,'Name','Designed by Nguyen Viet Dam');
subplot(2,1,1)
plot(freq,psdx); grid;
xlabel('TÇn sè Hz ','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD [dB]','fontname','.Vntime','color','b','fontsize',14);
title('§Çu vµo t­¬ng ®­¬ng th«ng thÊp LP: f_0=12; f_1=-1 vµd f_2 = 2','fontname','.Vntime','color','b','fontsize',14);

subplot(2,1,2)
plot(freq,psdy); grid;
xlabel('TÇn sè Hz ','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD [dB]','fontname','.Vntime','color','b','fontsize',14);
title('IM ®Çu ra LP t¹i: 2f_1-f_2= -4 and 2f_2-f_1 =5','fontname','.Vntime','color','b','fontsize',14);
% File: NVD13_tiv1.m
clc;
clear all;
close all;

f1          = 512;              	% default signal frequency
bdoppler    = 64;                   % default doppler sampling
fs          = 8192;                 % default sampling frequency
tduration   = 1;                    % default duration   

ts          = 1.0/fs;				% sampling period 
n           = tduration*fs;			% number of samples
t           = ts*(0:n-1);			% time vector
x1          = exp(i*2*pi*f1*t);	    % complex signal
zz          = zeros(1,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate Uncorrelated seq of Complex Gaussian Samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z           = randn(1,n)+ i*randn(1,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter the uncorrelated samples to generate correlated samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coefft      = exp(-bdoppler*2*pi*ts);
h           = waitbarqa(0,'Ch��ng tr�nh �ang th�c hi�n l�c');
for k=2:n
   zz(k)    = (ts*z(k))+coefft*zz(k-1);
   waitbarqa(k/n)
end
close(h)
y1          = x1.*zz; 			% filtered output of LTV system

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the results in time domain and frequency domain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
subplot(2,1,1);
[psdzz,freq]    = NVD13_log_psd(zz,n,ts);
plot(freq,psdzz); grid;
ylabel('��p �ng xung kim [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('T�n s�','fontname','.Vntime','color','b','fontsize',12)
title('M�t �� ph� c�ng su�t PSD c�a ��p �ng xung kim','fontname','.Vntime','color','b','fontsize',12);

subplot(2,1,2);
zzz = abs(zz.^2)/(mean(abs(zz.^2)));
plot(10*log10(zzz)); grid;
ylabel('B�nh ph��ng �� l�n c�a  h(t) [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('Ch� s� m�u th�i gian','fontname','.Vntime','color','b','fontsize',12)
title('B�nh ph��ng �� l�n chu�n h�a c�a ��p �ng xung kim [dB]','fontname','.Vntime','color','b','fontsize',12);

%%%%%%%%%
figure(2);
subplot(2,1,1) 
[psdx1,freq]    = NVD13_log_psd(x1,n,ts); 
plot(freq,psdx1); grid;
ylabel('PSD c�a Tone ��u v�o [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('T�n s�','fontname','.Vntime','color','b','fontsize',12)
title('M�t �� ph� c�ng su�t ��t v�o h� th�ng LTV','fontname','.Vntime','color','b','fontsize',12);

subplot(2,1,2) 
[psdy1,freq]    = NVD13_log_psd(y1,n,ts);
plot(freq,psdy1); grid;
ylabel('PSD ��u ra [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('T�n s�','fontname','.Vntime','color','b','fontsize',12)
title('��u ra c�a h� th�ng LTV b� tr�i ph� (n� r�ng ph� t�n)','fontname','.Vntime','color','b','fontsize',12);
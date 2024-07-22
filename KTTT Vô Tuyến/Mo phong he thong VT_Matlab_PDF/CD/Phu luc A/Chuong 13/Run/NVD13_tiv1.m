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
h           = waitbarqa(0,'Ch­¬ng tr×nh ®ang thùc hiÖn läc');
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
ylabel('§¸p øng xung kim [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('TÇn sè','fontname','.Vntime','color','b','fontsize',12)
title('MËt ®é phæ c«ng suÊt PSD cña ®¸p øng xung kim','fontname','.Vntime','color','b','fontsize',12);

subplot(2,1,2);
zzz = abs(zz.^2)/(mean(abs(zz.^2)));
plot(10*log10(zzz)); grid;
ylabel('B×nh ph­¬ng ®é lín cña  h(t) [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('ChØ sè mÉu thêi gian','fontname','.Vntime','color','b','fontsize',12)
title('B×nh ph­¬ng ®é lín chuÈn hãa cña ®¸p øng xung kim [dB]','fontname','.Vntime','color','b','fontsize',12);

%%%%%%%%%
figure(2);
subplot(2,1,1) 
[psdx1,freq]    = NVD13_log_psd(x1,n,ts); 
plot(freq,psdx1); grid;
ylabel('PSD cña Tone ®Çu vµo [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('TÇn sè','fontname','.Vntime','color','b','fontsize',12)
title('MËt ®é phæ c«ng suÊt ®Æt vµo hÖ thèng LTV','fontname','.Vntime','color','b','fontsize',12);

subplot(2,1,2) 
[psdy1,freq]    = NVD13_log_psd(y1,n,ts);
plot(freq,psdy1); grid;
ylabel('PSD ®Çu ra [dB]','fontname','.Vntime','color','b','fontsize',12)
xlabel('TÇn sè','fontname','.Vntime','color','b','fontsize',12)
title('§Çu ra cña hÖ thèng LTV bÞ tr¶i phæ (në réng phæ tÇn)','fontname','.Vntime','color','b','fontsize',12);
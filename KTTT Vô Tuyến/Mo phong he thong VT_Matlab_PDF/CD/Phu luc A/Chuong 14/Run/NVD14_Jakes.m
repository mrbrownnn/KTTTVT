% File: NVD14_Jakes.m
clc;
clear all;
close all;

% This program builds up a two-tap TDL model and computes the output 
% for the two inpput signasl of interest.

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate tapweights. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
fd      = 100; 
impw    = NVD14_jakes_filter(fd);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate tap input processes and Run through doppler filter.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1  = randn(1,256)+i*randn(1,256); 
y1  = filter(impw,1,x1);
x2  = randn(1,256)+i*randn(1,256);
y2  = filter(impw,1,x2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discard the first 128 points since the FIR filter transient.
% Scale them for power and Interpolate weight values.
% Interpolation factor=100 for the QPSK sampling rate of 160000/sec.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z1(1:128)   = y1(129:256); 
z2(1:128)   = y2(129:256);
z2          = sqrt(0.5)*z2; 
m           = 100;
tw1         = NVD14_linear_interp(z1,m);
tw2         = NVD14_linear_interp(z2,m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate QPSK signal and filter it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbits       = 512;
nsamples    = 16;
ntotal      = 8192;
qpsk_sig    = NVD14_random_binary(nbits,nsamples)+i*NVD14_random_binary(nbits,nsamples);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Genrate output of tap1 (size the vectors first). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input1      = qpsk_sig(1:8184);
output1     = tw1(1:8184).*input1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay the input by eight samples (this is the delay specified 
% in term of number of samples at the sampling rate of 
% 16,000 samples/sec and genrate the output of tap 2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input2      = qpsk_sig(9:8192);
output2     = tw2(9:8192).*input2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add the two outptus and genrate overall output.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qpsk_output = output1+output2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the 1000 Hz  complex exponential and run it through the TDL 
% model. This could be done at the higher sampling rate of 16,0000
% samples per sec or at a lower rate. At the lower rate the tap spacing
% must be recomputed in number of samples at the lower rate. Also the 
% interpolation of the tap gain functions must now be at the lower rate. 
% In this example we will use the higher sampling rate.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ts      = 1/160000;
time    = (ts:ts:8200*ts); 
cexp    = exp(2*pi*i*1000*time);

input1  = cexp(1:8184);
output3 = tw1(1:8184).*input1;

input2  = cexp(9:8192);
output4 = tw2(9:8192).*input2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add the two outputs and genrate overall output.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cexp_out                        = output3+output4;
[psdcexp,freq,ptotal,pmax]      = NVD14_linear_psd(cexp(1:8184),8184,ts);
[psdcexp_out,freq,ptotal,pmax]  = NVD14_linear_psd(cexp_out(1:8184),8184,ts);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(2,1,1)
plot(freq(4100:4180), psdcexp(4100:4180));
grid;
xlabel('TÇn sè (Hz)','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD ®Çu vµo','fontname','.Vntime','color','b','fontsize',14);
title('Kh¶o s¸t d·n phæ do Doppler','fontname','.Vntime','color','b','fontsize',12)


subplot(2,1,2)
plot(freq(4100:4180), psdcexp_out(4100:4180),'r');
grid;
xlabel('TÇn sè (Hz)','fontname','.Vntime','color','b','fontsize',12);
ylabel('PSD ®Çu ra','fontname','.Vntime','color','b','fontsize',14)

figure(2); 
subplot(2,1,1)
plot(real(qpsk_sig(501:1000)),'r'); 
grid;
xlabel('ChØ sè mÉu','fontname','.Vntime','color','b','fontsize',12); 
ylabel('§Çu ra thµnh phÇn ®ång pha I','fontname','.Vntime','color','b','fontsize',14);
title('¶nh h­ëng cña Doppler lªn tÝn hiÖu vµo/ra kªnh I cña tÝn hiÖu QPSK','fontname','.Vntime','color','b','fontsize',12)
axis([0 500 -2 2])

subplot(2,1,2)
plot(real(qpsk_output(501:1000)));grid;
xlabel('ChØ sè mÉu','fontname','.Vntime','color','b','fontsize',12); 
ylabel('§Çu ra thµnh phÇn ®ång pha I','fontname','.Vntime','color','b','fontsize',14);

figure(3); 
plot(abs(output3(3000:6000)));
grid
xlabel('ChØ sè mÉu','fontname','.Vntime','color','b','fontsize',12);
ylabel('§­êng bao biªn ®é','fontname','.Vntime','color','b','fontsize',14);
title('§­êng bao ®Çu ra mò phøc cña tÝn hiÖu QPSK','fontname','.Vntime','color','b','fontsize',12);
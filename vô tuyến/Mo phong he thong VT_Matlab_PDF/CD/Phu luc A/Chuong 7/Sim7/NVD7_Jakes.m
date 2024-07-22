% File NVD7_Jakes.m
clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate and test the impulse response of the filter.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fd      = 100;						% maximum doppler
impw    = NVD7_jakes_filter(fd);	% call to Jakes filter
fs      = 16*fd; ts = 1/fs; 		% sampling frequency and time
time    = [1*ts:ts:128*ts];         % time vector for plot

%====================================================
subplot(2,1,1)
stem(time,impw,'.'); grid 
xlabel('Th�i gian ','fontname','.vntime','fontsize',12);
ylabel('��p �ng xung kim','fontname','.vntime','fontsize',12)
title('��p �ng xung kim v� PSD','fontname','.vntime','color','b','fontsize',12)

%%====================================================
% Square the fft and check the power transfer function.
%%====================================================
[h f]   = NVD7_linear_fft(impw,128,ts);    % generate H(f) for filter
subplot(2,1,2)
plot(f,abs(h.*h));
xlabel('T�n s�','fontname','.vntime','fontsize',12);
ylabel('PSD','fontname','.vntime','fontsize',15)
grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Put Gaussian noise through and check the output psd.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x       = randn(1,1024);                      % generate Gaussian input
y       = filter(impw,1,x);                   % filter Gaussian input
[output_psd ff] = NVD7_log_psd(y,1024,ts);    % log of PSD

figure;
subplot(2,1,1)
plot(ff,output_psd); grid;
axis([-500 500 -50 0]);
xlabel('T�n s�','fontname','.vntime','fontsize',12); 
ylabel('PSD','fontname','.vntime','fontsize',15);
title('PSD v� ���ng bao ���c ��c t�nh','fontname','.vntime','color','b','fontsize',12)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter complex noise and look at the envelope fading.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z       = randn(1,1024)+i*randn(1,1024);   % generate complex noise
zz      = filter(impw,1,z);                % filter complex noise
time    = (0.0:ts:1024*ts);                % new time axis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalize output and plot envelope.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
zz      = zz/max(max(abs(zz)));              % normalize to one
subplot(2,1,2)
plot(time(161:480),10*log10(abs(zz(161:480)))); 
axis([0.1 0.3 -20 0])
xlabel('Th�i gian','fontname','.vntime','fontsize',12);
ylabel('Log bi�n ��','fontname','.vntime','fontsize',12);
grid;
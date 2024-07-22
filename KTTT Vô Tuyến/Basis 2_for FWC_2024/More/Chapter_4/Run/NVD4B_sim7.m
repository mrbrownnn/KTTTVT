% function NVD4B_sim7

%File NVD4B_sim7.m = CS31.m
% demonstration for DSB-AM modulation.

%========================
clc;
clear all;
close all;
%========================
t0      = .15;              % signal duration
ts      = 0.001;            % sampling interval
fc      = input('   Nhap tan so song mang =    ');  % Carrier frequency
snr     = input('   Nhap SNR = ');
fs      = 1/ts;             % Sampling frequency
df      = 0.3;              % desired frequency resolution
t       = [0:ts:t0];        % time vector
snr_lin = 10^(snr/10);      % Linear SNR

%========================
% message signal
m   = [ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c   = cos(2*fc*pi.*t);          % Carrier signal
u   = m.*c;                     % modulation signal
[M,m,df1]   = fftseq(m,ts,df);  % Fourier Transform
M           = M/fs;             % scaling
[U,u,df1]   = fftseq(u,ts,df);  % Fourier Transform
U           = U/fs;             % scaling
[C,c,df1]   = fftseq(c,ts,df);  % Fourier Transform
C           = C/fs;             % scaling

f           = [0:df1:df1*(length(m)-1)]-fs/2;   % frequency vector
signal_power    = spower(u(1:length(t)));       % power in modulated signal
noise_power     = signal_power/snr_lin;         % compute noise power
noise_std       = sqrt(noise_power);            % Compute noise standard deviation
noise           = noise_std*randn(1,length(u)); % Generate noise
r               = u + noise;                    % add noise to the modulated signal
[R,r,df1]       = fftseq(r,ts,df);              % spectrum of the signal + noise
R               = R/fs;                         % scaling

%========================
h1_27 = figure(1)
set(h1_27,'name','H1.27: NVD')
%==========
% the message signal in time domain
subplot(221);
plot(t,m(1:length(t)),'LineWidth',2);
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12);
title('TÝn hiÖu b¶n tin trong miÒn thêi gian',...
    'FontName','.VnTime','color','b','FontSize',12);
axis([min(t) max(t) min(m)-0.5 max(m)+0.5])
%==========
% the message signal in frequency domain
subplot(223);
plot(f,abs(fftshift(M)),'LineWidth',1.5);
xlabel('TÇn sè Hz','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12);
title('TÝn hiÖu b¶n tin trong miÒn tÇn sè','FontName','.VnTime','color','b','FontSize',12);

%==========
% the modulated signal in time domain
subplot(222);
plot(t,u(1:length(t)),'LineWidth',1.5);
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12);
title(['DSB-AM trong miÒn thêi gian: f_c=',num2str(fc),'Hz'],...
    'FontName','.VnTime','color','b','FontSize',12);
%===========
% the modulated signal in the frequency domain
subplot(224);
plot(f,abs(fftshift(U)),'LineWidth',1.5);
xlabel('TÇn sè Hz','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12);
title(['DSB-AM trong miÒn tÇn sè: P_T_x = ',num2str(signal_power),'w'],...
    'FontName','.VnTime','color','b','FontSize',12);

%======================================================
h1_28 = figure(2)
set(h1_28,'name','H1.28: NVD')

subplot(221);
plot(t,noise(1:length(t)),'LineWidth',1.5);
xlabel('Thêi gian','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12);
title(['Sãng t¹p ©m: SNR = ',num2str(snr),' dB'],...
    'FontName','.VnTime','color','b','FontSize',12);

subplot(222);
plot(f,abs(fftshift(U)),'LineWidth',1.5);
xlabel('TÇn sè Hz','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12);
title('Phæ tÝn hiÖu ph¸t',...
    'FontName','.VnTime','color','b','FontSize',12);

subplot(223);
plot(t,r(1:length(t)),'LineWidth',1.5);
xlabel('Thêi gian','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12);
title('Sãng DSB-AM thu',...
    'FontName','.VnTime','color','b','FontSize',12);

subplot(224);
plot(f,abs(fftshift(R)),'LineWidth',1.5);
xlabel('TÇn sè Hz','FontName','.VnTime','color','b','FontSize',10);
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12);
title(['Phæ tÝn hiÖu thu: f_c=',num2str(fc),' Hz; SNR=',num2str(snr),'dB'],...
    'FontName','.VnTime','color','b','FontSize',12);
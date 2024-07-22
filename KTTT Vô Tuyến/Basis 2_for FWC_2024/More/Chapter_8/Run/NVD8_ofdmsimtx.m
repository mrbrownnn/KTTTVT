% file: NVD8_ofdmsimtx.m
% The available bandwidth is 8 MHz

clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simualation Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FS      =   4096/2;         %IFFT/FFT length <=> FFT_size
T       =   0.1094e-6;      %baseband elementary period (7/64)e-6
% T       =  4.8828e-008;   %baseband elementary period (7/64)e-6
Tu      =   T*(FS/2);       %useful OFDM symbol period
G       =   1/4;            %choice of 1/4, 1/8, 1/16, and 1/32
delta   =   G*Tu;           %guard band duration
Ts      =   delta+Tu;       %total OFDM symbol period
Kmax    =   1000;           %number of subcarriers
Kmin    =   0;
q       =   10;             %carrier period to elementary period ratio
fc      =   q*1/T;          %carrier frequency <=> 90MHz
Rs      =   4*fc;           %simulation period
t       =   0:1/Rs:Tu;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Data generator (A) %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M       =   Kmax+1;
rand('state',0);
a       =   -1+2*round(rand(M,1)).'+i*(-1+2*round(rand(M,1))).';
A       =   length(a);
info    =   zeros(FS,1);
info(1:(A/2))           = [ a(1:(A/2)).'];            %Zero padding
info((FS-((A/2)-1)):FS) = [ a(((A/2)+1):A).'];
% info_Mon = info;                         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Subcarriers generation (B)%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
carriers    =   FS.*ifft(info,FS);
tt          =   0:T/2:Tu;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%===========================
h1 = figure(1);
set(h1,'color','g');
set(h1,'Name','H8_OFDMTx.1: NVD');
subplot(211);
stem(tt(1:20),real(carriers(1:20)));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña ®ång pha','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu t¹i B - MiÒn thêi gian','FontName','.VnTime','FontSize',14);
grid on
subplot(212);
stem(tt(1:20),imag(carriers(1:20)));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña vu«ng pha','FontName','.VnTime','FontSize',14)
grid on
%===========================
h2 = figure(2);
set(h2,'color','g');
set(h2,'Name','H8_OFDMTx.2: NVD');
f   =(2/T)*(1:(FS))/(FS);
subplot(211);
plot(f,abs(fft(carriers,FS))/FS);
xlabel('TÇn sè (Hz)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu t¹i B - MiÒn tÇn sè','FontName','.VnTime','FontSize',14);
subplot(212);
pwelch(carriers,[],[],[],2/T);
xlabel('TÇn sè [MHz]','FontName','.VnTime','FontSize',12)
ylabel('PSD [dB/Hz]','FontName','.VnTime','FontSize',14)
title('¦íc tÝnh mËt ®é phæ c«ng suÊt PSD dïng hµm pwelch','FontName','.VnTime','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% D/A simulation %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L       =   length(carriers);
chips   =   [ carriers.';zeros((2*q)-1,L)];
p       =   1/Rs:1/Rs:T/2;
g       =   ones(length(p),1);  %pulse shape
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%=============================
h3 = figure(3);
set(h3,'color','g');
set(h3,'Name','H8_OFDMTx.3: NVD');
stem(p,g);
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','FontSize',14)
% axis([ ]);
title('D¹ng xung g(t)','FontName','.VnTime','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dummy   =   conv(g,chips(:));
u       =   [dummy(1:length(t))]; % (C)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==============================
h4  = figure(4);
set(h4,'color','g');
set(h4,'Name','H8_OFDMTx.4: NVD');
subplot(211);
plot(t(1:400),real(u(1:400)));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña I','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu U t¹i C - MiÒn thêi gian','FontName','.VnTime','color','r','FontSize',14);
subplot(212);
plot(t(1:400),imag(u(1:400)));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña Q','FontName','.VnTime','FontSize',14)

%===============================
h5 = figure(5);
set(h5,'color','g');
set(h5,'Name','H8_OFDMTx.5: NVD');
ff      =(Rs)*(1:(q*FS))/(q*FS);
subplot(211);
plot(ff,abs(fft(u,q*FS))/FS);
xlabel('TÇn sè (Hz)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu U t¹i C - MiÒn tÇn sè','FontName','.VnTime','FontSize',14);
subplot(212);
pwelch(u,[],[],[],Rs);
xlabel('TÇn sè [MHz]','FontName','.VnTime','FontSize',12)
ylabel('PSD [dB/Hz]','FontName','.VnTime','FontSize',14)
title('¦íc tÝnh mËt ®é phæ c«ng suÊt PSD dïng hµm pwelch','FontName','.VnTime','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%reconstruction filter
[b,a]   = butter(13,1/20);
[H,F]   = FREQZ(b,a,FS,Rs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%================================
h6 = figure(6);
set(h6,'color','g');
set(h6,'Name','H8_OFDMTx.6: NVD');
plot(F,20*log10(abs(H)));
xlabel('TÇn sè (Hz)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é dB','FontName','.VnTime','FontSize',14)
title('§¸p øng tÇn sè bé läc A/D','FontName','.VnTime','color','r','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%baseband signal (D)
uoft    = filter(b,a,u);
%%%%%%%%%%%%%%%%%%%%%%%%%%

h7 = figure(7);
set(h7,'color','g');
set(h7,'Name','H8_OFDMTx.7: NVD');

subplot(211);
plot(t(80:480),real(uoft(80:480)));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña phÇn thùc','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu U_O_F_T t¹i D - MiÒn thêi gian','FontName','.VnTime','color','b','FontSize',14);

subplot(212);
plot(t(80:480),imag(uoft(80:480)));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña phÇn ¶o','FontName','.VnTime','FontSize',14)

%==============================
h8 = figure(8);
set(h8,'color','g');
set(h8,'Name','H8_OFDMTx.8: NVD');

subplot(211);
plot(ff,abs(fft(uoft,q*FS))/FS);
xlabel('TÇn sè (Hz)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é ','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu U_O_F_T t¹i D - MiÒn tÇn sè','FontName','.VnTime','color','b','FontSize',14);
subplot(212);
pwelch(uoft,[],[],[],Rs);
xlabel('TÇn sè [MHz]','FontName','.VnTime','FontSize',12)
ylabel('PSD [dB/Hz]','FontName','.VnTime','FontSize',14)
title('¦íc tÝnh mËt ®é phæ c«ng suÊt PSD dïng hµm pwelch','FontName','.VnTime','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upconverter
s_tilde =   (uoft.').*exp(1i*2*pi*fc*t);
s       =   real(s_tilde);          %passband signal (E)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%===============================
h9 = figure(9);
set(h9,'color','g');
set(h9,'Name','H8_OFDMTx.9: NVD');

subplot(211)
plot(t(80:480),s(80:480));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu s(t) t¹i E - MiÒn thêi gian','FontName','.VnTime','FontSize',14);

subplot(212)
plot(ff,abs(fft(((real(uoft).').*cos(2*pi*fc*t)),q*FS))/FS);
xlabel('TÇn sè Hz','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu s(t) t¹i E - MiÒn tÇn sè','FontName','.VnTime','FontSize',14);
clc;
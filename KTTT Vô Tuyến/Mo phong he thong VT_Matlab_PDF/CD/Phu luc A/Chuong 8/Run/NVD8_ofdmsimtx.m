% file: NVD8_ofdmsimtx.m
% The available bandwidth is 8 MHz
clc;
clear all;
close all;

% Simualation Parameters
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
fc      =   q*1/T;          %carrier frequency
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
info(1:(A/2)) = [ a(1:(A/2)).'];            %Zero padding
info((FS-((A/2)-1)):FS) = [ a(((A/2)+1):A).'];
% info_Mon = info;                         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Subcarriers generation (B)%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
carriers    =   FS.*ifft(info,FS);
tt          =   0:T/2:Tu;

h1 = figure(1);
set(h1,'color','g');
set(h1,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(211);
stem(tt(1:20),real(carriers(1:20)));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é ®ång pha','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng thêi gian cña sãng mang t¹i B',...
    'FontName','.VnTime','color','b','FontSize',12);
grid on
subplot(212);
stem(tt(1:20),imag(carriers(1:20)));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é vu«ng pha','FontName','.VnTime','color','b','FontSize',12)
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h2 = figure(2);
set(h2,'color','g');
set(h2,'Name','Designed by Eng. Nguyen Viet Dam');
f   =(2/T)*(1:(FS))/(FS);
subplot(211);
plot(f,abs(fft(carriers,FS))/FS);
xlabel('TÇn sè (Hz)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè cña c¸c sãng mang tÝn hiÖu t¹i B',...
    'FontName','.VnTime','color','b','FontSize',12);
subplot(212);
pwelch(carriers,[],[],[],2/T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% D/A simulation %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L       =   length(carriers);
chips   =   [ carriers.';zeros((2*q)-1,L)];
p       =   1/Rs:1/Rs:T/2;
g       =   ones(length(p),1); %pulse shape

h3 = figure(3);
set(h3,'color','g');
set(h3,'Name','Designed by Eng. Nguyen Viet Dam');
stem(p,g);
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)
% axis([ ]);
title('D¹ng xung g(t)',...
    'FontName','.VnTime','color','b','FontSize',12);
%%%%%%%%%%%%
dummy   =   conv(g,chips(:));
u       =   [dummy(1:length(t))]; % (C)

h4 = figure(4);
set(h4,'color','g');
set(h4,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(211);
plot(t(1:400),real(u(1:400)));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é I','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng thêi gian cña tÝn hiÖu U t¹i C',...
    'FontName','.VnTime','color','b','FontSize',12);
subplot(212);
plot(t(1:400),imag(u(1:400)));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é Q','FontName','.VnTime','color','b','FontSize',12)
%%%%%%%%%%%%%%%%%%
h5 = figure(5);
set(h5,'color','g');
set(h5,'Name','Designed by Eng. Nguyen Viet Dam');
ff      =(Rs)*(1:(q*FS))/(q*FS);
subplot(211);
plot(ff,abs(fft(u,q*FS))/FS);
xlabel('TÇn sè (Hz)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè cña tÝn hiÖu U t¹i C','FontName','.VnTime','color','b','FontSize',12);
subplot(212);
pwelch(u,[],[],[],Rs);
[b,a]   = butter(13,1/20); %reconstruction filter
[H,F]   = FREQZ(b,a,FS,Rs);

%%%%%%%%%%%%%%%%%%%%%%%%%%
h6 = figure(6);
set(h6,'color','g');
set(h6,'Name','Designed by Eng. Nguyen Viet Dam');
plot(F,20*log10(abs(H)));
xlabel('TÇn sè (Hz)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é dB','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè bé läc A/D','FontName','.VnTime','color','b','FontSize',12);

uoft    = filter(b,a,u); %baseband signal (D)
%%%%%%%%%%%%%%%%%%%%%%%%%%
h7 = figure(7);
set(h7,'color','g');
set(h7,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(211);
plot(t(80:480),real(uoft(80:480)));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng thêi gian cña tÝn hiÖu U_O_F_T t¹i D','FontName','.VnTime','color','b','FontSize',12);

subplot(212);
plot(t(80:480),imag(uoft(80:480)));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)


%%%%%%%%%%%%%%%%%%%%%%%%%%
h8 = figure(8);
set(h8,'color','g');
set(h8,'Name','Designed by Eng. Nguyen Viet Dam');

subplot(211);
plot(ff,abs(fft(uoft,q*FS))/FS);
xlabel('TÇn sè (Hz)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é ','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè cña tÝn hiÖu U_O_F_T t¹i D','FontName','.VnTime','color','b','FontSize',12);
subplot(212);
pwelch(uoft,[],[],[],Rs);

%Upconverter
s_tilde =   (uoft.').*exp(1i*2*pi*fc*t);
s       =   real(s_tilde);          %passband signal (E)

%%%%%%%%%%%%%%%%%%%%%%%%%%
h9 = figure(9);
set(h9,'color','g');
set(h9,'Name','Designed by Eng. Nguyen Viet Dam');
plot(t(80:480),s(80:480));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng thêi gian cña tÝn hiÖu s(t) t¹i E','FontName','.VnTime','color','b','FontSize',12);

%%%%%%%%%%%%%%%%%%%%%%%%%%
h10 = figure(10);
set(h10,'color','g');
set(h10,'Name','Designed by Eng. Nguyen Viet Dam');
plot(ff,abs(fft(((real(uoft).').*cos(2*pi*fc*t)),q*FS))/FS);
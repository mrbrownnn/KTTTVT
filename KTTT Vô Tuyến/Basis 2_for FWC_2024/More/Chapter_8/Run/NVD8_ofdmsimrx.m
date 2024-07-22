% function NVD8_ofdmsimrx
% Reception section simulation for OFDM system 
clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Simualation Parameters%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tu      =   224e-6;             % useful OFDM symbol period
T       =   Tu/2048;            % baseband elementary period
G       =   1/4;                % choice of 1/4, 1/8, 1/16, and 1/32
delta   =   G*Tu;               % guard band duration
Ts      =   delta+Tu;           % total OFDM symbol period
Kmax    =   1705;               % number of subcarriers
Kmin    =   0;
FS      =   4096;               % IFFT/FFT length
q       =   10;                 % carrier period to elementary period ratio
fc      =   q*1/T;              % carrier frequency
Rs      =   4*fc;               % simulation period
t       =   0:1/Rs:Tu;
tt      =   0:T/2:Tu;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%Data generator%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sM          =   2;
[x,y]       =   meshgrid((-sM+1):2:(sM-1),(-sM+1):2:(sM-1));
alphabet    =   x(:) + 1i*y(:);
N           =   Kmax+1;
rand('state',0);
a           =   -1+2*round(rand(N,1)).'+i*(-1+2*round(rand(N,1))).';
A           =   length(a);

info                    =   zeros(FS,1);
info(1:(A/2))           = [ a(1:(A/2)).'];
info((FS-((A/2)-1)):FS) = [ a(((A/2)+1):A).'];
carriers                = FS.*ifft(info,FS);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%Upconverter%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L           =   length(carriers);
chips       =   [ carriers.';zeros((2*q)-1,L)];
p           =   1/Rs:1/Rs:T/2;
g           =   ones(length(p),1);
dummy       =   conv(g,chips(:));
u           =   [dummy; zeros(46,1)];
[b,aa]      =   butter(13,1/20);
uoft        =   filter(b,aa,u);
delay       =   64;             %Reconstruction filter delay
s_tilde     =   (uoft(delay+(1:length(t))).').*exp(1i*2*pi*fc*t);

s           =   real(s_tilde);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% OFDM RECEPTION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Downconversion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r_tilde     =   exp(-1i*2*pi*fc*t).*s; %(F)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%===================
h1  =   figure(1);
set(h1,'color','g');
set(h1,'Name','H8_OFDMRx.1: NVD');
subplot(211);
plot(t,real(r_tilde));
axis([0e-7 12e-7 -60 60]);
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña I','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu thu t¹i F - MiÒn thêi gian','FontName','.VnTime','FontSize',14);
grid on;
subplot(212);
plot(t,imag(r_tilde));
axis([0e-7 12e-7 -100 150]);
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña Q','FontName','.VnTime','FontSize',14)
grid on;
%=====================
h2 = figure(2);
set(h2,'color','g');
set(h2,'Name','H8_OFDMRx.2: NVD');
ff=(Rs)*(1:(q*FS))/(q*FS);
subplot(211);
plot(ff,abs(fft(r_tilde,q*FS))/FS);
xlabel('TÇn sè Hz','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu thu t¹i F - MiÒn tÇn sè','FontName','.VnTime','FontSize',14);
grid on;

subplot(212);
pwelch(r_tilde,[],[],[],Rs);
xlabel('tÇn sè [MHz]','FontName','.VnTime','color','b','FontSize',12)
ylabel('PSD [dB/Hz]','FontName','.VnTime','color','b','FontSize',14)
title('¦íc tÝnh mËt ®é phæ c«ng suÊt PSD dïng hµm pwelch','FontName','.VnTime','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Carrier suppression %%%%%%%%%%%%%%%%%%
[B,AA]  = butter(3,1/2);
r_info  = 2*filter(B,AA,r_tilde); %Baseband signal continuous-time (G)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%===============================
h3  =   figure(3);
set(h3,'color','w');
set(h3,'Name','H8_OFDMRx.3: NVD');
subplot(211);
plot(t,real(r_info));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña I','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu thu t¹i G - MiÒn thêi gian','FontName','.VnTime','FontSize',14);
axis([0 12e-7 -60 60]);
grid on;
subplot(212);
plot(t,imag(r_info));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña Q','FontName','.VnTime','FontSize',14)
axis([0 12e-7 -60 60]);
grid on;

%==============================
h4 = figure(4);
f=(2/T)*(1:(FS))/(FS);
set(h4,'color','w');
set(h4,'Name','H8_OFDMRx.4: NVD');
subplot(211);
plot(ff,abs(fft(r_info,q*FS))/FS);
xlabel('TÇn sè Hz','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu thu t¹i G - MiÒn tÇn sè','FontName','.VnTime','FontSize',14);
grid on;

subplot(212);
pwelch(r_info,[],[],[],Rs);
xlabel('tÇn sè [MHz]','FontName','.VnTime','FontSize',12)
ylabel('PSD [dB/Hz]','FontName','.VnTime','FontSize',14)
title('¦íc tÝnh mËt ®é phæ c«ng suÊt PSD dïng hµm pwelch','FontName','.VnTime','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Sampling %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Baseband signal, discrete time
r_data  = real(r_info(1:(2*q):length(t)))...
    + 1i*imag(r_info(1:(2*q):length(t))); % (H); 1i*

%=============================
h5 = figure(5);
set(h5,'color','g');
set(h5,'Name','H8_OFDMRx.5: NVD');
subplot(211);
stem(tt(1:20),(real(r_data(1:20))));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',12)
ylabel('Biªn ®é cña I','FontName','.VnTime','FontSize',14)
title('TÝn hiÖu thu t¹i H - MiÒn thêi gian','FontName','.VnTime','FontSize',14);
axis([0 12e-7 -60 60]);
grid on;
subplot(212);
stem(tt(1:20),(imag(r_data(1:20))));
xlabel('Thêi gian (s)','FontName','.VnTime','FontSize',8)
ylabel('Biªn ®é cña Q','FontName','.VnTime','FontSize',12)
axis([0 12e-7 -60 60]);
grid on;

%=============================
h6 = figure(6);
set(h6,'color','g');
set(h6,'Name','H8_OFDMRx.6: NVD');
f=(2/T)*(1:(FS))/(FS);
subplot(211);
plot(f,abs(fft(r_data,FS))/FS);
xlabel('TÇn sè','FontName','.VnTime','color','b','FontSize',12)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',14)
title('TÝn hiÖu thu t¹i H - MiÒn tÇn sè','FontName','.VnTime','FontSize',14);
grid on;
subplot(212);
pwelch(r_data,[],[],[],2/T);
xlabel('tÇn sè [MHz]','FontName','.VnTime','FontSize',12)
ylabel('PSD [dB/Hz]','FontName','.VnTime','FontSize',14)
title('¦íc tÝnh mËt ®é phæ c«ng suÊt PSD dïng hµm pwelch','FontName','.VnTime','FontSize',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% FFT %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
info_2N     =   (1/FS).*fft(r_data,FS); % (I)
info_h      =   [info_2N(1:A/2) info_2N((FS-((A/2)-1)):FS)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Slicing %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:N,
    a_hat(k)=alphabet((info_h(k)-alphabet)==min(info_h(k)-alphabet)); %(J)
end;

%==================================
h7 = figure(7)
set(h7,'color','g');
set(h7,'Name','H8_OFDMRx.7: NVD');
subplot(121)
plot(info_h((1:A)),'.k');
xlabel('Trôc thùc I','FontName','.VnTime','FontSize',12)
ylabel('Trôc ¶o  Q','FontName','.VnTime','FontSize',14)
title('BiÓu ®å chßm sao tÝn hiÖu t¹i I','FontName','.VnTime','FontSize',14);
axis square;
axis equal;
grid on;
axis([-1.5 1.5 -1.5 1.5]);

subplot(122)
plot(a_hat((1:A)),'or');
xlabel('Trôc thùc I','FontName','.VnTime','FontSize',12)
ylabel('Trôc ¶o  Q','FontName','.VnTime','FontSize',14)
title('BiÓu ®å chßm sao tÝn hiÖu 4-QAM t¹i J','FontName','.VnTime','FontSize',14);
axis square;
axis equal;
grid on;
axis([-1.5 1.5 -1.5 1.5]);
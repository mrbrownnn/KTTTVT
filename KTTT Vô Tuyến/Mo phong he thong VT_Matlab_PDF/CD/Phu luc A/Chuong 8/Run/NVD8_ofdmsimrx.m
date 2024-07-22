% function NVD8_ofdmsimrx
% Reception section simulation for OFDM system 
clc;
clear all;
close all;
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

%Data generator
sM          =   2;
[x,y]       =   meshgrid((-sM+1):2:(sM-1),(-sM+1):2:(sM-1));
alphabet    =   x(:) + 1i*y(:);
N           =   Kmax+1;
rand('state',0);
a           =   -1+2*round(rand(N,1)).'+i*(-1+2*round(rand(N,1))).';
A           =   length(a);

info        =   zeros(FS,1);
info(1:(A/2)) = [ a(1:(A/2)).'];
info((FS-((A/2)-1)):FS) = [ a(((A/2)+1):A).'];
carriers=FS.*ifft(info,FS);

%Upconverter
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

s=real(s_tilde);

%OFDM RECEPTION
%Downconversion
r_tilde     =   exp(-1i*2*pi*fc*t).*s; %(F)

figure(1);
h1=figure(1);
set(h1,'color','g');
set(h1,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(211);
plot(t,real(r_tilde));
axis([0e-7 12e-7 -60 60]);
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é I','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng thêi gian cña tÝn hiÖu thu t¹i F','FontName','.VnTime','color','b','FontSize',12);
grid on;
subplot(212);
plot(t,imag(r_tilde));
axis([0e-7 12e-7 -100 150]);
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é Q','FontName','.VnTime','color','b','FontSize',12)
grid on;

%%%%%%%%%%%%%%
h2 = figure(2);
set(h2,'color','g');
set(h2,'Name','Designed by Eng. Nguyen Viet Dam');
ff=(Rs)*(1:(q*FS))/(q*FS);
subplot(211);
plot(ff,abs(fft(r_tilde,q*FS))/FS);
xlabel('tÇn sè Hz','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè cña tÝn hiÖu thu t¹i F','FontName','.VnTime','color','b','FontSize',12);
grid on;
subplot(212);
pwelch(r_tilde,[],[],[],Rs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Carrier suppression
[B,AA] = butter(3,1/2);
r_info=2*filter(B,AA,r_tilde); %Baseband signal continuous-time (G)

h3=figure(3);
set(h3,'color','w');
set(h3,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(211);
plot(t,real(r_info));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é I','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè cña tÝn hiÖu thu t¹i G','FontName','.VnTime','color','b','FontSize',12);
axis([0 12e-7 -60 60]);
grid on;
subplot(212);
plot(t,imag(r_info));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é Q','FontName','.VnTime','color','b','FontSize',12)
axis([0 12e-7 -60 60]);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h4 = figure(4);
f=(2/T)*(1:(FS))/(FS);
set(h4,'color','w');
set(h4,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(211);
plot(ff,abs(fft(r_info,q*FS))/FS);
xlabel('tÇn sè Hz','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè cña tÝn hiÖu thu t¹i G','FontName','.VnTime','color','b','FontSize',12);
grid on;
subplot(212);
pwelch(r_info,[],[],[],Rs);

%Sampling
r_data=real(r_info(1:(2*q):length(t)))... %Baseband signal, discretetime
+1i*imag(r_info(1:(2*q):length(t))); % (H)

h5 = figure(5);
set(h5,'color','g');
set(h5,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(211);
stem(tt(1:20),(real(r_data(1:20))));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é I','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng thêi gian cña tÝn hiÖu thu t¹i H','FontName','.VnTime','color','b','FontSize',12);
axis([0 12e-7 -60 60]);
grid on;
subplot(212);
stem(tt(1:20),(imag(r_data(1:20))));
xlabel('Thêi gian (s)','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é q','FontName','.VnTime','color','b','FontSize',12)
axis([0 12e-7 -60 60]);
grid on;

%%%%%%%%%%%%%%%%
h6 = figure(6);
set(h6,'color','g');
set(h6,'Name','Designed by Eng. Nguyen Viet Dam');
f=(2/T)*(1:(FS))/(FS);
subplot(211);
plot(f,abs(fft(r_data,FS))/FS);
xlabel('tÇn sè','FontName','.VnTime','color','b','FontSize',8)
ylabel('Biªn ®é','FontName','.VnTime','color','b','FontSize',12)
title('§¸p øng tÇn sè cña tÝn hiÖu thu t¹i H','FontName','.VnTime','color','b','FontSize',12);
grid on;
subplot(212);
pwelch(r_data,[],[],[],2/T);

%FFT
info_2N=(1/FS).*fft(r_data,FS); % (I)
info_h=[info_2N(1:A/2) info_2N((FS-((A/2)-1)):FS)];
%Slicing
for k=1:N,
    a_hat(k)=alphabet((info_h(k)-alphabet)==min(info_h(k)-alphabet)); %(J)
end;
h7 = figure(7)
set(h7,'color','g');
set(h7,'Name','Designed by Eng. Nguyen Viet Dam');
plot(info_h((1:A)),'.k');
xlabel('Trôc thùc I','FontName','.VnTime','color','b','FontSize',8)
ylabel('Trôc ¶o  Q','FontName','.VnTime','color','b','FontSize',12)
title('BiÓu ®å chßm sao tÝn hiÖu t¹i I','FontName','.VnTime','color','b','FontSize',12);
axis square;
axis equal;

%%%%%%%%%%%
h8 = figure(8)
set(h8,'color','g');
set(h8,'Name','Designed by Eng. Nguyen Viet Dam');
plot(a_hat((1:A)),'or');
xlabel('Trôc thùc I','FontName','.VnTime','color','b','FontSize',8)
ylabel('Trôc ¶o  Q','FontName','.VnTime','color','b','FontSize',12)
title('BiÓu ®å chßm sao tÝn hiÖu 4-QAM t¹i J','FontName','.VnTime','color','b','FontSize',12);
axis square;
axis equal;
grid on;
axis([-1.5 1.5 -1.5 1.5]);
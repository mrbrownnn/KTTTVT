% File: NVD13_tiv2.m
clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Set default parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symrate         = 512;
nsamples        = 16;
nsymbols        = 128;
bdoppler        = 16;
ndelay          = 8; 
n               = nsymbols*nsamples;
ts              = 1.0/(symrate*nsamples);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate two uncorrelated seq of Complex Gaussian Samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z1      = randn(1,n)+i*randn(1,n);
z2      = randn(1,n)+i*randn(1,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter the two uncorrelated samples to generate correlated sequences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coefft  = exp(-bdoppler*2*pi*ts);     
zz1     = zeros(1,n);
zz2     = zeros(1,n);
for k = 2:n   
   zz1(k) = z1(k)+coefft*zz1(k-1);
   zz2(k) = z2(k)+coefft*zz2(k-1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate a BPSK (random binry wavefrom and compute the output)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M       = 2;								% binary case
x1      = NVD13_mpsk_pulses(M,nsymbols,nsamples);
y1      = x1.*zz1;                          % first output component 
y2      = x1.*zz2;                          % second output component

y(1:ndelay)     = y1(1:ndelay);
y(ndelay+1:n)   = y1(ndelay+1:n)+y2(1:n-ndelay);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Plot the results 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[psdzz1,freq]   = NVD13_log_psd(zz1,n,ts);
figure; 
plot(freq,psdzz1); grid;
xlabel('T�n s� Hz','fontname','.Vntime','color','b','fontsize',12);
ylabel('Bi�n �� [dB]','fontname','.Vntime','color','b','fontsize',12);
title('M�t �� ph� c�ng su�t PSD c�a ��p �ng xung kim th�nh ph�n th� nh�t','fontname','.Vntime','color','b','fontsize',12);


nn = 0:499;
figure; 
subplot(2,1,1)
plot(nn,imag(x1(1:500)),'k',nn,real(y1(1:500)),'k'); grid;
title('��u v�o v� th�nh ph�n th� nh�t c�a ��u ra','fontname','.Vntime','color','b','fontsize',12);
xlabel('Ch� s� m�u','fontname','.Vntime','color','b','fontsize',12);
ylabel('M�c t�n hi�u','fontname','.Vntime','color','b','fontsize',12);

subplot(2,1,2)
plot(nn,imag(x1(1:500)),'k',nn,real(y(1:500)),'k');grid;
title('��u v�o v� ��u ra t�ng','fontname','.Vntime','color','b','fontsize',12)
xlabel('Ch� s� m�u','fontname','.Vntime','color','b','fontsize',12);
ylabel('M�c t�n hi�u','fontname','.Vntime','color','b','fontsize',12);
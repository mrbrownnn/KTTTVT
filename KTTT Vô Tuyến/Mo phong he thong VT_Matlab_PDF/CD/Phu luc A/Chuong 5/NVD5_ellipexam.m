% file: NVD5_ellipexan.m

clc;
clear all;
close all;
%=======================
% setup parameter
%=======================
fs          = 100;						% set sampling frequency
fc          = 20;						% set cuttoff frequency
f           = 0:0.1:50;					% define frequency vector
%=======================
% Main program
%=======================
[b,a]       = ellip(5,1,20,2*pi*fc,'s');% synthesize elliptic filter
h           = freqs(b,a,2*pi*f);		% amp. resp. of analog filter
[bz1,az1]   = impinvar(b,a,fs);			% impulse invariant digital filter
h1          = freqz(bz1,az1,f,fs);		% amplitude response of above
[bz2,az2]   = bilinear(b,a,fs);			% bilinear z filter (not prewarped)
h2          = freqz(bz2,az2,f,fs);		% amplitude response of above
[bz3,az3]   = bilinear(b,a,fs,fc);		% bilinear z filter (prewarped)
h3          = freqz(bz3,az3,f,fs);		% amplitude response of above
%=======================
% Display results
%=======================
subplot(2,1,1);
plot(f,abs(h),f,abs(h1));
xlabel('T�n s� - Hz','fontname','.Vntime','color','b','fontsize',12);
ylabel('��p �ng bi�n ��','fontname','.Vntime','color','b','fontsize',14);
title('So s�nh c�c ��p �ng bi�n ��: Nguy�n m�u t��ng t� v� b�t bi�n xung kim',...
    'fontname','.Vntime','color','b','fontsize',12);
legend('Nguyen mau tuong tu','Bat bien xung kim');
subplot(2,1,2);
plot(f,abs(h2),f,abs(h3));
xlabel('T�n s� - Hz','fontname','.Vntime','color','b','fontsize',12);
ylabel('��p �ng bi�n ��','fontname','.Vntime','color','b','fontsize',14);
title('So s�nh c�c ��p �ng bi�n �� hai b� l�c bi�n ��i z song tuy�n: kh�ng l�m m�o t�n s� v� l�m m�o t�n s�',...
    'fontname','.Vntime','color','b','fontsize',12);
legend('Khong lam meo truoc','Lam meo truoc');
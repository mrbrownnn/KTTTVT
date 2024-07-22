% File: NVD7_flicker.m
clc;
clear all;
close all;
%==========================
f       = 0:100;					% frequency points
fn      = 100;						% Nyquist rate
F       = f/fn;						% frequency vector
M       = abs(10./sqrt(f));			% normalized fequency response
M       = [zeros(1,6),M(6:100)];	% bound from zero frequency

[b1,a1] = yulewalk(3,F,M);          % generate order=3 filter
[b2,a2] = yulewalk(20,F,M);         % generate order=20 filter
[h1,w1] = freqz(b1,a1);             % generate 3-rd order H(f)
[h2,w2] = freqz(b2,a2);             % generate 20-th order H(f)
%%=========================
%% Display results
%%=========================
figure(1)
subplot(2,1,1)
plot(F,M,':',w1/pi,abs(h1));
xlabel('T�n s� chu�n h�a','fontname','.Vntime','fontsize',12);
ylabel('��p �ng bi�n ��','fontname','.Vntime','fontsize',12);
title('T�o t�p �m flicker khi b�c b� l�c =3','fontname','.vntime','color','b','fontsize',14);
legend('Ham truyen dat mong muon','Ham truyen dat mo phong')
subplot(2,1,2)
plot(F,M,':',w2/pi,abs(h2));
xlabel('T�n s� chu�n h�a','fontname','.Vntime','fontsize',12);
ylabel('��p �ng bi�n ��','fontname','.Vntime','fontsize',12);
title('T�o t�p �m flicker khi b�c b� l�c = 20','fontname','.vntime','color','b','fontsize',14);
legend('Ham truyen dat mong muon','Ham truyen dat mo phong')
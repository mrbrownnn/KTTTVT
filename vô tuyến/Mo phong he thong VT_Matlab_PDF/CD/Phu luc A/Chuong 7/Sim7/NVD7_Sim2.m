% File: NVD7_sim2
clc;
clear all;
close all;
nbits   = 10;
nsamples= 8;
x       = NVD7_random_binary(nbits,nsamples)+i*NVD7_random_binary(nbits,nsamples);
xd      = real(x); 
xq      = imag(x);

subplot(2,1,1)
stem(xd,'.'); 
grid;
axis([0 80 -1.5 1.5]);
xlabel('Ch� s� m�u','fontname','.vntime','fontsize',12);
ylabel('X_I','fontname','.vntime','fontsize',16);
title('C�c th�nh ph�n ��ng pha X_I v� vu�ng pha X_Q c�a t�n hi�u QPSK',...
    'fontname','.vntime','color','b','fontsize',14);

subplot(2,1,2)
stem(xq,'.'); 
grid;
axis([0 80 -1.5 1.5]);
xlabel('Ch� s� m�u','fontname','.vntime','fontsize',12);
ylabel('X_Q','fontname','.vntime','fontsize',16);
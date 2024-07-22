% function [K] = NVD4B_sim4
% File: NVD4B_sim4.m = CS16.m

clc;
clear all;
close all;
%==========================================
ts      =   0.2;
fs      =   1/ts;
df      =   0.01;
x       =   [zeros(1,10),(0:0.2:1),ones(1,9),(1:-0.2:0),zeros(1,10)];
xt      =   x;
[X,x,df1] = fftseq(x,ts,df);                    % derive the FFT
X1      =   X/fs;                                % Scaling
f       =   [0:df1:df1*(length(x)-1)] - fs/2;    % Frequency vector for FFT
f1      =   [-2.5:0.001:2.5];                    % Frequency vector for analytic approach
y       =   4*(sinc(2*f1).^2)-(sinc(f1)).^2;     % Exact Fourier Transform

%==========================================
h1_19 = figure(1)
set(h1_19,'color','c','Name','H1.19 & H1.20. Simulation Results of NVD4B_sim4 Program: NVD');
%========================
% plot of FT derived analytically is used by analytically
subplot(2,2,2);
plot(f1,abs(y),'r','LineWidth',4);
xlabel('TÇn sè Hz','fontname','.vntime','Fontsize',12);
ylabel('|X(f)|','fontname','.vntime','Fontsize',16);
title('Phæ biªn ®é |X(f)| b»ng ph­¬ng ph¸p gi¶i tÝch','fontname','.vntime','Fontsize',14);
grid on;
%========================
subplot(2,2,[1,3]);
tt      =   2*(-2:0.1:2);
plot(tt,xt,'b','LineWidth',4);
xlabel('Thêi gian','fontname','.vntime','Fontsize',12);
ylabel('x(t)','fontname','.vntime','Fontsize',20);
title('TÝn hiÖu x(t)','fontname','.vntime','Fontsize',18);
axis([min(tt) max(tt) min(xt)-0.2 max(xt)+0.4]);
grid on;
%========================
% plot of FT derived numerically used by FFT
subplot(2,2,4);
plot(f,fftshift(abs(X1)),'b','LineWidth',4);
xlabel('TÇn sè Hz','fontname','.vntime','Fontsize',12);
ylabel('|X(f)|','fontname','.vntime','Fontsize',16);
title('Phæ biªn ®é |X(f)| b»ng ph­¬ng ph¸p sè','fontname','.vntime','Fontsize',14);
grid on
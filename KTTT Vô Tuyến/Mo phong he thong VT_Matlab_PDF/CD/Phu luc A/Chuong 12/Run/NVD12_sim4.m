% File: NVD12_sim4.m
% This is an example of Saleh's LPE showing the effects of 
% AM to AM and AM to PM when the input is 16QAM

clc;
clear all;
close all;
%===============================
% Create input constellation
backoff = input('Nhap backoff don vi dB (10) > ');
N       = 1024;							% number of points
x1      = 2*fix(4*rand(1,N))-3;		    % direct components
x2      = 2*fix(4*rand(1,N))-3;		    % quadrature components
y       = x1+i*x2;						% signal space points

%======================================
% Run it thru Saleh's model
z       = NVD12_salehs_model(y,-1*backoff,1024);
%======================================
% Display results
subplot(1,2,1)
plot(real(y),imag(y));
grid; 
xlabel('§ång pha','fontname','.Vntime','color','b','fontsize',12);
ylabel('Vu«ng pha','fontname','.Vntime','color','b','fontsize',12);
title('Chßm sao tÝn hiÖu ®Çu vµo','fontname','.Vntime','color','b','fontsize',13);
axis equal

subplot(1,2,2)
plot(real(z),imag(z));
grid;
xlabel('§ång pha','fontname','.Vntime','color','b','fontsize',12);
ylabel('Vu«ng pha','fontname','.Vntime','color','b','fontsize',12);
title('Chßm sao tÝn hiÖu ®Çu ra','fontname','.Vntime','color','b','fontsize',13);
axis equal
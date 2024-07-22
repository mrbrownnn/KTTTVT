% function y = NVD4B_sim6
%File NVD4B_sim6.m = CS18.m

clc;
clear all;
close all;
%========================
ts      = 0.001;
fs      = 1/ts;
t       = [0:ts:10];
f1      = input('Nhap tan so f1 =   ');
f2      = input('Nhap tan so f2 =   ');
x       = cos(2*pi*f1*t) + cos(2*pi*f2*t);
p       = spower(x);
psd     = spectrum(x,1024);
%========================
h1_25 = figure
set(h1_25,'color','c','Name','H1.27. Simulation Results of NVD4B_sim6 Program: NVD');
specplot(psd,fs);
xlabel('TÇn sè Hz','fontname','.vntime','Fontsize',14);
ylabel('PSD','fontname','.vntime','Fontsize',18);
title(['PSD cña tÝn hiÖu chøa hai thµnh phÇn tÇn sè t¹i: f_1= ',...
    num2str(f1),'Hz; f_2=',num2str(f2),'Hz; C«ng suÊt tÝn hiÖu =',num2str(p),'w'],...
    'fontname','.vntime','Fontsize',14);
grid on;
% legend('data_1','data_2','data_3');
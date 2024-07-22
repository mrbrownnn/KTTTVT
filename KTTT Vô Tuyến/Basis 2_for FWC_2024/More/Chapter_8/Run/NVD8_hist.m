% File: NVD8_hist.m
clc;
clear all;
close all;

h8_10   =   figure(1)
% set(h8_10,'color','c');
set(h8_10,'name','H8.10: NVD');

subplot(2,2,1)
x       = randn(1,100);
hist(x,20);
ylabel('N_i','fontname','.Vntime','fontsize',14);
xlabel('(a)','fontname','.Vntime','fontsize',14);
title('Tr­êng hîp: N=100; B =20',...
    'fontname','.vntime','color','b','fontsize',14)

subplot(2,2,2)
x       = randn(1,100);
hist(x,5);
ylabel('N_i','fontname','.Vntime','fontsize',14); 
xlabel('(b)','fontname','.Vntime','fontsize',14);
title('Tr­êng hîp: N=100; B =5',...
    'fontname','.vntime','color','b','fontsize',14)

subplot(2,2,3)
x = randn(1,1000);
hist(x,50);
ylabel('N_i','fontname','.Vntime','fontsize',14); 
xlabel('(c)','fontname','.Vntime','fontsize',14);
title('Tr­êng hîp: N=1000; B =50',...
    'fontname','.vntime','color','b','fontsize',14)

subplot(2,2,4)
x = randn(1,100000);
hist(x,50);
ylabel('N_i','fontname','.Vntime','fontsize',14); 
xlabel('(d)','fontname','.Vntime','fontsize',14)
title('Tr­êng hîp: N=100.000; B =50',...
    'fontname','.vntime','color','b','fontsize',14);
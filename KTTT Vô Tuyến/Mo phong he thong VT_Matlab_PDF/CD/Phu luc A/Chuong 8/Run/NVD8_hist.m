% File: NVD8_hist.m
clc;
clear all;
close all;

subplot(2,2,1)
x = randn(1,100); hist(x,20)
ylabel('N_i','fontsize',14); xlabel('(a)','fontsize',14)
title('Tr­êng hîp: N=100; B =20',...
    'fontname','.vntime','color','b','fontsize',12)

subplot(2,2,2)
x = randn(1,100); hist(x,5)
ylabel('N_i','fontsize',14); xlabel('(b)','fontsize',14)
title('Tr­êng hîp: N=100; B =5',...
    'fontname','.vntime','color','b','fontsize',12)

subplot(2,2,3)
x = randn(1,1000); hist(x,50)
ylabel('N_i','fontsize',14); xlabel('(c)','fontsize',14)
title('Tr­êng hîp: N=1000; B =50',...
    'fontname','.vntime','color','b','fontsize',12)

subplot(2,2,4)
x = randn(1,100000); hist(x,50)
ylabel('N_i','fontsize',14); xlabel('(d)','fontsize',14)
title('Tr­êng hîp: N=100.000; B =50',...
    'fontname','.vntime','color','b','fontsize',12)

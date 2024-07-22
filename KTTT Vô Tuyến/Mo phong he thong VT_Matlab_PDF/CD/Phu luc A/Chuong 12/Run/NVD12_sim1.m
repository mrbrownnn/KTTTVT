% file: NVD12_sim1.m
clc;
clear all;
close all;
x           = 0.1:0.1:2;
n           = length(x);
backoff     = 0.0;
%====================================
y           = NVD12_salehs_model(x,backoff,n);
%=====================================
subplot(2,1,1)
pin         = 10*log10(abs(x));
pout        = 10*log10(abs(y));
plot(pin,pout); grid;
xlabel('C南g su厎 v發 [dB]','fontname','.Vntime','color','b','fontsize',12);
ylabel('C南g su厎 ra [dB]','fontname','.Vntime','color','b','fontsize',14);
subplot(2,1,2)
plot(pin,(180/pi)*unwrap(angle(y))); grid;
xlabel('C南g su厎 v發 [dB]','fontname','.Vntime','color','b','fontsize',12);
ylabel('D溡h pha [桅]','fontname','.Vntime','color','b','fontsize',14);
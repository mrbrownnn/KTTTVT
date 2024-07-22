% File: NVD8_welchp.m
clc;
clear all;
close all;
fs  = 16;
x   = random_binary(1024,fs)+i*random_binary(1024,fs);
h8_10 = figure(1)
set(h8_10,'color','c');
set(h8_10,'Name','H8.10: NVD');
for nwin=1:4
   nwindow  = nwin*1024;
   [pxx,f]  = pwelch(x,nwindow,[],[],fs);
   pxx      = pxx/sum(sum(pxx));
   n2       = length(f)/2;
   pxxdB    = 10*log10(pxx/pxx(1));
   
   ptheory  = sin(pi*f+eps)./(pi*f+eps);
   ptheory  = ptheory.*ptheory;
   ptheorydB = 10*log10(ptheory/ptheory(1));
   
   subplot(2,2,nwin)   
   plot(f(1:n2),pxxdB(1:n2),f(1:n2),ptheorydB(1:n2));
%    plot(f(1:n2),pxxdB(1:n2));
   ylabel('PSD [dB]','fontname','.vntime','fontsize',16);
   xx = ['ChiÒu dµi cöa sæ = ',num2str(nwindow)];
   xlabel(xx,'fontname','.vntime','fontsize',14)
   axis([0 8 -50, 10]); grid;
end 
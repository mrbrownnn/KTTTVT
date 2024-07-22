% File NVD16_CISQPSK.m
clc;
clear all;
close all;

Eb      = 20:2:32; No = -50;				% Eb and Noin dBm
ChannelAttenuation = 70;					% channel attenuation in dB
EbNodB  = (Eb-ChannelAttenuation)-No;	    % Eb/No in dB 
EbNo    = 10.^(EbNodB./10);					% Eb/No in linear units
BER_T   = 0.5*erfc(sqrt(EbNo));       	    % BER (theoretical)
N       = ones(size(BER_T))*2000;			% set =2000 for all runs
CISBias = 1+(EbNo/20);						% set CIS bias
BER_CIS = zeros(size(Eb)); 				    % initialize BER vector

for k=1:length(Eb)        					% main loop starts here
  BER_CIS(k)    = NVD16_CISQPSKrun(N(k),Eb(k),...
  No,ChannelAttenuation,0,0,0,0,CISBias(k));
  disp(['Thuc hien ',num2str(k*100/length(Eb)),'    %  Mo phong']);
end
semilogy(EbNodB,BER_CIS,'o',EbNodB,2*BER_T,'-');
xlabel('Eb/No (dB)','fontname','.vntime','color','b','fontsize',12);
ylabel('BER','fontname','.vntime','color','b','fontsize',14);
grid;
title('KÕt qu¶ m« pháng lÊy mÉu quan träng truyÒn thèng CIS ®iÓm h×nh','fontname','.vntime','color','b','fontsize',14)
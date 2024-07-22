% File: NVD10_MCQPSKber.m
clc;
clear all;
close all;

Eb          = 22:0.5:26;                % Eb (dBm)
No          = -50;                      % No (dBm/Hz)
ChannelAttenuation = 70;                % Channel attenuation in dB
EbNodB      = (Eb-ChannelAttenuation)-No;% Eb/No in dB
EbNo        = 10.^(EbNodB./10);         % Eb/No in linear units
BER_T       = 0.5*erfc(sqrt(EbNo)); 	% BER (theoretical)
N           = round(100./BER_T);       	% Symbols to transmit
BER_MC      = zeros(size(Eb)); 			% Initialize BER vector

%====================
% Main Loop
%====================
for k=1:length(Eb)
  BER_MC(k) = NVD10_MCQPSKrun(N(k),Eb(k),No,ChannelAttenuation,0,0,0,0);
  disp(['Thuc hien ',num2str(k*100/length(Eb)),'% Mo phong']);
end
semilogy(EbNodB,BER_MC,'o',EbNodB,2*BER_T,'-')
xlabel('Eb/No [dB]','fontname','.vntime');
ylabel('BER','fontname','.vntime'); 
legend('uoc tinh BER MC ','BER ly thuyet'); grid;
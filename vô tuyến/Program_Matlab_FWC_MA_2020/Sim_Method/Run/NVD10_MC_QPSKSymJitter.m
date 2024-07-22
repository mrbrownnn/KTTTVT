% File: NVD10 _MCQPSKSymJitter.m
clc;
clear all;
close all;
SymJitter   = 0:0.02:0.2;
Eb          = 24;               	% Eb (dBm)
No          = -50;              	% No (dBm/Hz)
ChannelAttenuation = 70; 			% channel attenuation in dB
EbNo        = 10.^((Eb-ChannelAttenuation-No)/10); 
BER_T       = 0.5*erfc(sqrt(EbNo)*ones(size(SymJitter)));
N           =round(100./BER_T); 
BER_MC      = zeros(size(SymJitter)); 

for k=1:length(SymJitter)
  BER_MC(k) = NVD10_MCQPSKrun(N(k),Eb,No,ChannelAttenuation,0,SymJitter(k),0,0);
  disp(['Thuc hien ',num2str(k*100/length(SymJitter)),' % Mo phong']);
end
semilogy(SymJitter,BER_MC,'o',SymJitter,2*BER_T,'-')
xlabel('§é lÖch chuÈn lçi ®Þnh thêi ký hiÖu (ký hiÖu)','fontname','.vntime'); 
ylabel('BER','fontname','.vntime'); 
legend('BER uoc tinh MC','BER ly thuyet'); grid;
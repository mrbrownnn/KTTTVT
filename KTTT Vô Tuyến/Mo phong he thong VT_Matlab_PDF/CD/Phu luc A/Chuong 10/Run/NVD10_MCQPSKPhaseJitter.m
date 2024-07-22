% File: NVD10 _MCQPSKPhaseJitter.m

clc;
clear all;
close all;
PhaseBias   = 0;    PhaseJitter = 0:2:30;
Eb          = 24;   No          = -50;          % Eb (dBm) and No (dBm/Hz)
ChannelAttenuation              = 70; 			% dB
EbNo    = 10.^((Eb-ChannelAttenuation-No)/10); 
BER_T   = 0.5*erfc(sqrt(EbNo)*ones(size(PhaseJitter)));
N       = round(100./BER_T); 
BER_MC  = zeros(size(PhaseJitter)); 

for k=1:length(PhaseJitter)
  BER_MC(k) = NVD10_MCQPSKrun(N(k),Eb,No,ChannelAttenuation,0,0,...
    PhaseBias,PhaseJitter(k));
  disp(['Thuc hien ',num2str(k*100/length(PhaseJitter)),' % Mo phong']);
end
semilogy(PhaseJitter,BER_MC,'o',PhaseJitter,2*BER_T,'-')
xlabel('§é lÖch chuÈn lçi pha (®é)','fontname','.vntime'); 
ylabel('BER','fontname','.vntime'); 
legend('uoc tinh BER MC','BER ly thuyet');
grid;
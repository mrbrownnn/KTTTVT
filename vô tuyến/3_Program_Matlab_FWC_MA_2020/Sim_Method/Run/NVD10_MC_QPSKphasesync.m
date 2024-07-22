% File: NVD10_MCQPSKphasesync.m

PhaseError  = 0:10:90; 				% Phase Error at Receiver
Eb = 24;     No = -50;     	       	% Eb (dBm) and No (dBm/Hz)
ChannelAttenuation = 70; 			% dB
EbNo    = 10.^((Eb-ChannelAttenuation-No)/10); 
BER_T   = 0.5*erfc(sqrt(EbNo)*ones(size(PhaseError)));
N       = round(100./BER_T); 
BER_MC  = zeros(size(PhaseError)); 
for k=1:length(PhaseError)
  BER_MC(k) = NVD10_MCQPSKrun(N(k),Eb,No,ChannelAttenuation,0,0,...
    PhaseError(k),0);
  disp(['Thuc hien ',num2str(k*100/length(PhaseError)),'% Mo phong']);
end
semilogy(PhaseError,BER_MC,'o',PhaseError,2*BER_T,'-')
xlabel('Phase Error (Degrees)','fontname','.vntime'); 
ylabel('Bit Error Rate','fontname','.vntime'); 
legend('uoc tinh BER MC','BER ly thuyet'); grid; 
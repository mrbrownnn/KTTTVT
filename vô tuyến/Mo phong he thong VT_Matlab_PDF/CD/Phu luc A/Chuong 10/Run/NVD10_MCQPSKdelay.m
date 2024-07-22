% function NVD10_MCQPSKdelay.m

clear all;
close all;

Eb = 23; No = -50;				% Eb (dBm) and No (dBm/Hz)
ChannelAttenuation = 70;		% channel attenuation in dB
N = 1000;                        
delay = -0.1:0.1:0.5;                  
EbNo = 10.^(((Eb-ChannelAttenuation)-No)/10);
BER_MC = zeros(size(delay));       
for k=1:length(delay)            
  BER_MC(k) = c10_MCQPSKrun(N,Eb,...
       No,ChannelAttenuation,delay(k),0,0,0);
  disp(['Thuc hien ',...
       num2str(k*100/length(delay)),'% Mo phong']);
end
BER_T = 0.5*erfc(sqrt(EbNo))*ones(size(delay)); % Theoretical BER

semilogy(delay,2*BER_T,delay,BER_MC,...
        '--rs','LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',7);
xlabel('TrÔ (Ký hiÖu)','Fontname','.VnTime','color','b','Fontsize',14);
ylabel('BER', 'Fontname','.VnTime','color','b','Fontsize',14); 
title(['M« pháng BER-MC theo trÔ cho hÖ thèng QPSK víi suy hao kªnh = ',...
    num2str(ChannelAttenuation),' dB'],'FontName','.VnTime','color','b','FontSize',14);
legend('BER Ly thuyet','Uoc tinh BER MC');grid;
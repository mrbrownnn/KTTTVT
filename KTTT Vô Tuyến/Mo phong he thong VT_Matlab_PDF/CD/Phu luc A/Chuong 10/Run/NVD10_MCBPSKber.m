% function NVD10_MCBPSKber
% % File: c10_MCBPSKber.m

clear all;
close all;
EbNodB      = 0:8;
z           = 10.^(EbNodB/10);
delay       = 5;
BER         = zeros(1,length(z));
Errors      = zeros(1,length(z));
BER_T       = q(sqrt(2*z));
N           = round(20./BER_T);
FilterSwitch = 1;

for k=1:length(z)
   N(k) = max(1000,N(k));
   [BER(k),Errors(k)] = NVD10_MCBPSKrun(N(k),z(k),delay,FilterSwitch);
end
semilogy(EbNodB,BER_T,EbNodB,BER,...
        '--rs','LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',7);
title(['M« pháng MC-BER theo SNR cho hÖ thèng BFSK víi TrÔ = ',num2str(delay),...    
    ],'FontName','.VnTime','color','b','FontSize',14);
xlabel(' E_b/N_0 dB','FontName','.VnTime','color','b','FontSize',14);
ylabel('BER','FontName','.VnTime','color','b','FontSize',16);
legend('Tham chieu AWGN','He thong nghien cuu');
grid on;
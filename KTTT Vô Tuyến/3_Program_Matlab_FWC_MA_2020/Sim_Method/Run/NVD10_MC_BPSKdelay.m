% File: NVD10_MCBPSKdelay.m
clc;
clear all;
close all;

EbNodB      = 6;
z           = 10.^(EbNodB/10);
delay       = 0:8;
BER         = zeros(1,length(delay));
Errors      = zeros(1,length(delay));
BER_T       = q(sqrt(2*z))*ones(1,length(delay));
N           = round(100./BER_T);
FilterSwitch = 1;

for k=1:length(delay)
   [BER(k),Errors(k)] = NVD10_MCBPSKrun(N(k),z,delay(k),FilterSwitch);
end

semilogy(delay,BER_T,'-',delay,BER,...
        '--rs','LineWidth',3,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',9);
grid on;
xlabel('Tr‘','Fontname','.VnTime','FontSize',12);
ylabel('BER','Fontname','.VnTime','FontSize',14);
title(['Kh∂o s∏t BER theo tr‘ vÌi E_b/N_0 = ',num2str(EbNodB),' dB'],...
    'Fontname','.VnTime','Color','b','FontSize',14);
legend('AWGN Reference','System Under Study')
% file: NVD3_sna
clc;
clear all;
close all;
k           = 50;
nsamp       = 50000;		    % total frequency samples
snrdb       = zeros(1,17);      % initialize memory
x           = 4:20;
for m = 4:20
    signal  = 0; noise = 0;     % initialize sum values
    f_fold  = k*m/2;		    % folding frequency
    for j = 1:f_fold
        term    = (sin(pi*j/k)/(pi*j/k))^2;
        signal  = signal+term;
    end
    for j = (f_fold+1):nsamp
        term    = (sin(pi*j/k)/(pi*j/k))^2;
        noise   = noise+term;
    end
    snrdb(m-3)  = 10*log10(signal/noise);
end
plot(x,snrdb,...
        '--rs','LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',7);
xlabel('Sè mÉu trªn ký hiÖu','FontName','.VnTime','color','b','FontSize',14);
ylabel('(SNR)_a','FontName','.VnTime','color','b','FontSize',14);
title(['TØ lÖ tÝn hiÖu trªn t¹p ©m chång phæ ®èi víi ®Þnh d¹ng xung ch÷ nhËt khi k= ',num2str(k),...
    ],'FontName','.VnTime','color','b','FontSize',14);
grid on;
clear all;
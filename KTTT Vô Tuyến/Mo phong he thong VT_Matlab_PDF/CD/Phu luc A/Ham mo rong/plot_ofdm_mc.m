% function plot_ofdm_mc(handles)
clear all;
close all;
t = -2*pi:0.01:2*pi;
y = sin(pi*t)./(pi*t);
for k = 1:5
    plot(t+k,y);
    hold on;
end
for k = 1:5
    plot(t+2*k,y);
    hold on;
end
title('HiÖu qu¶ phæ tÇn OFDM','FontName','.Vntime','FontSize',14,'Color','b');
xlabel('TÇn sè','FontName','.Vntime','FontSize',12,'Color','b');
ylabel('Biªn ®é phæ','FontName','.Vntime','FontSize',12,'Color','b');
grid on;
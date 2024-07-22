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
title('Hi�u qu� ph� t�n OFDM','FontName','.Vntime','FontSize',14,'Color','b');
xlabel('T�n s�','FontName','.Vntime','FontSize',12,'Color','b');
ylabel('Bi�n �� ph�','FontName','.Vntime','FontSize',12,'Color','b');
grid on;
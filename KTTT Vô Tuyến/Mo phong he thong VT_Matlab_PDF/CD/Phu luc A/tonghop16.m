% function tonghop16
clc;
clear all;
close all;

x   =   10*rand(1,500)-5;
y   =   10*rand(1,500)-5;

subplot(2,1,1)
plot(x,y,'k+');
xlabel('X');
ylabel('Y');
subplot(2,1,2)
xlabel('C�c m�u ���c x� l�','fontname','.vntime');
ylabel('��c t�nh di�n t�ch','fontname','.vntime');
ylim([0 6]);
xlim([0 500]);
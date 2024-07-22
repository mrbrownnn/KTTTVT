% function y = NVD4B_sim3
% File NVD4B_sim3.m = CS15qa.m
clc;
clear all;
close all;
%=====================================
df  =   0.01;
fs  =   10;
ts  =   1/fs;
t   =   [-5:ts:5];
%=======================================
x1  =   zeros(size(t));
x1(41:51)   =   t(41:51)+1;
x1(52:61)   =   ones(size(x1(52:61)));

x2         =    zeros(size(t));
x2(51:71)  =    x1(41:61);

[X1,x11,df1]    =   fftseq(x1,ts,df);
[X2,x21,df2]    =   fftseq(x2,ts,df);

X11 =   X1/fs;
X21 =   X2/fs;

f   =  [0:df1:df1*(length(x11)-1)]-fs/2;
%=======================================
h1_15 = figure
set(h1_15,'color','c','Name','H1.17. Simulation Results of NVD4B_sim3 Program: NVD');
%=================
subplot(2,2,2);
plot(f,fftshift(abs(X21)),'b','LineWidth',4);
xlabel('TÇn sè H_z','FontName','.VnTime','color','b','FontSize',12)
ylabel('|X_1(f)| \equiv |X_2(f)|','FontName','.VnTime','color','r','FontSize',12)
title('Phæ biªn ®é X_1(f) & X_2(f)',...
    'FontName','.VnTime','color','b','FontSize',14);
grid on
legend('X_1(f) \equiv X_2(f)');
%=================
subplot(2,2,[1,3]);
plot(t,x1,'-.b',t,x2,'r','LineWidth',3);
axis([-5 5 -1 2]);
xlabel('Thêi gian','FontName','.VnTime','color','b','FontSize',14)
ylabel('x_1(t);x_2(t)','FontName','.VnTime','color','b','FontSize',18)
title('D¹ng sãng cña x_1(t) & x_2(t)',...
    'FontName','.VnTime','color','b','FontSize',16);
grid on
legend('x_1(t)','x_2(t)');
%=================
subplot(2,2,4);
plot (f(500:525),fftshift(angle(X11(500:525))),'-.b',f(500:525),fftshift(angle(X21(500:525))),'r',...
    'LineWidth',3);
xlabel('TÇn sè H_z','FontName','.VnTime','color','b','FontSize',12);
ylabel('\theta (radian)','FontName','.VnTime','color','r','FontSize',14);
title('Phæ pha \theta cña X_1(f) , X_2(f)',...
    'FontName','.VnTime','color','b','FontSize',14);
grid on
legend('\theta_1','\theta_2',2);
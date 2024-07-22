function k = CS14qa
clc;
close all;
clear all;
n       =   [-20:1:20];
x       =   0.5*(sinc(n/2)).^2; % fourier series coefficients of x(t) vector.
ts      =   1/40;               % Sampling interval
t       =   [-0.5:ts:1.5];      % Time vector
% Impluse response
fs      =   1/ts;
h       =   [zeros(1,20),t(21:61),zeros(1,20)];
% Transfer function
H       =   fft(h)/fs;
df      =   fs/80;              % frequency resolution
f       =   [0:df:fs]-fs/2;
% Rearrange H
H1      =   fftshift(H);
y       =   x.*H1(21:61);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h1 = figure(1)
set(h1,'color','g');
set(h1,'Name','Designed by Eng. Nguyen Viet Dam');
subplot(2,1,1);
    plot(f,abs(H1));
    xlabel('TÇn sè H_z','FontName','.VnTime','color','b','FontSize',8)
    ylabel('|H(f)|','FontName','.VnTime','color','b','FontSize',12)
    title('Hµm truyÒn ®¹t cña hÖ thèng LTI',...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on    
subplot(2,1,2);
    stem(f,abs(H1));
    xlabel('n','FontName','.VnTime','color','b','FontSize',8)
    ylabel('|H(n)|','FontName','.VnTime','color','b','FontSize',12)
    title('§é lín cña H(n/2)',...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on
    
h2 = figure(2)
set(h2,'color','g');
set(h2,'Name','Designed by Eng. Nguyen Viet Dam');    
subplot(2,1,1);    
    stem(n,abs(x));
    xlabel('n','FontName','.VnTime','color','b','FontSize',8)
    ylabel('|x_n|','FontName','.VnTime','color','b','FontSize',12)
    title('Phæ rêi r¹c cña tÝn hiÖu vµo',...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on
    
subplot(2,1,2);    
    stem(n,abs(y));
    xlabel('n','FontName','.VnTime','color','b','FontSize',8)
    ylabel('|y_n|','FontName','.VnTime','color','b','FontSize',12)
    title('Phæ rêi r¹c cña tÝn hiÖu ra',...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h3 = figure(3)
set(h3,'color','g');
set(h3,'Name','Designed by Eng. Nguyen Viet Dam');    
subplot(2,2,1:2);
    stem(f,abs(H1));
    xlabel('n','FontName','.VnTime','color','b','FontSize',8)
    ylabel('|H(n)|','FontName','.VnTime','color','b','FontSize',12)
    title('§é lín cña H(n/2)',...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on

subplot(2,2,3);
    stem(n,abs(x));
    xlabel('n','FontName','.VnTime','color','b','FontSize',8)
    ylabel('|x_n|','FontName','.VnTime','color','b','FontSize',12)
    title('Phæ rêi r¹c cña tÝn hiÖu vµo',...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on
    
subplot(2,2,4);
    stem(n,abs(y));
    xlabel('n','FontName','.VnTime','color','b','FontSize',8)
    ylabel('|y_n|','FontName','.VnTime','color','b','FontSize',12)
    title('Phæ rêi r¹c cña tÝn hiÖu ra',...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on

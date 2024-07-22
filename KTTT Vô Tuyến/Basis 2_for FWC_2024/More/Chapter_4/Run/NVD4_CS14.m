% function k = NVD4_CS14
% file NVD4_CS14.m

clc;
close all;
clear all;
%===================================
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

%===============================
h1 = figure(1)
set(h1,'color','c','Name','H4.20 NVD');
subplot(2,1,1);
    plot(f,abs(H1));
    xlabel('TÇn sè H_z','FontName','.VnTime','FontSize',12)
    ylabel('|H(f)|','FontName','.VnTime','FontSize',16)
    title('Hµm truyÒn ®¹t cña hÖ thèng LTIV',...
        'FontName','.VnTime','FontSize',14);
    grid on    
subplot(2,1,2);
    stem(f,abs(H1),'.k');
    xlabel('n','FontName','.VnTime','FontSize',14)
    ylabel('|H(n)|','FontName','.VnTime','FontSize',16);
    title('Biªn ®é cña H(n/2)',...
        'FontName','.VnTime','FontSize',14);
    grid on
%===============================
h4_23 = figure(2)
set(h4_23,'color','g','Name','H4.23: NVD');
subplot(2,2,1:2);
    stem(f,abs(H1),'.k');
    xlabel('n','FontName','.VnTime','FontSize',14)
    ylabel('|H(n)|','FontName','.VnTime','FontSize',16)
    title('Biªn ®é cña H(n/2)',...
        'FontName','.VnTime','FontSize',14);
    grid on
subplot(2,2,3);
    stem(n,abs(x),'.k');
    xlabel('n','FontName','.VnTime','FontSize',14)
    ylabel('|x_n|','FontName','.VnTime','FontSize',16)
    title('Phæ rêi r¹c cña tÝn hiÖu vµo: |x_n|',...
        'FontName','.VnTime','color','r','FontSize',12);
    grid on    
subplot(2,2,4);
    stem(n,abs(y),'.k');
    xlabel('n','FontName','.VnTime','FontSize',14)
    ylabel('|y_n|','FontName','.VnTime','FontSize',16)
    title('Phæ rêi r¹c cña tÝn hiÖu ra: |y_n|',...
        'FontName','.VnTime','color','r','FontSize',12);
    grid on
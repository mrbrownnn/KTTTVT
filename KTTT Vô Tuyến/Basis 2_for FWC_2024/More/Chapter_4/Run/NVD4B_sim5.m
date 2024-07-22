% function y = NVD4B_sim5
% File NVD4B_sim5.m = CS17.m

clc;
clear all;
close all;
%=====================
fs      = 5;                    % Frequency resolution
ts      = 1/fs;                 % sampling frequency
df      = 0.01;                 % Sampling interval
t       = [-5:ts:5];            % Time vector
x       = zeros(1,length(t));   % Input signal initiation

%======================
x(16:26)    = t(16:26)+2;
x(27:31)    = 2*ones(1,5);
x(32:41)    = 2 + 2*cos(0.5*pi*t(32:41));
x(42:46)    = 2*ones(1,5);
xx          = []
% xx_tt       = [zeros(1,16) t(16:26)+2 2*ones(1,5) 2+2*cos(0.5*pi*t(32:41)) 2*ones(1,5) zeros(1,4)];
xx_tt=[zeros(1,16),...
    t(16:26)+2,...
    2*ones(1,5),...
    2+2*cos(0.5*pi*t(32:41)),...
    2*ones(1,5),...
    zeros(1,4)];
%======================
% part 1
[X,x1,df1]  = fftseq(x,ts,df);                      % Spectrum of the input
f           = [0:df1:df1*(length(x1)-1)] - fs/2;    % Frequency vector
X1          = X/fs;                                 % Scaling
%======================
% part 2: Filter transfer function
H       = [ones(1,ceil(1.5/df1)),...
    zeros(1,length(X) - 2*ceil(1.5/df1)),...
    ones(1,ceil(1.5/df1))];
Y       = X.*H;             % Output spectrum
y1      = ifft(Y);          % Output of Filter
%======================
% part 3: LTI system impluse response 
h       = [zeros(1,ceil(5/ts)),...
    t(ceil(5/ts)+1:ceil(6/ts)),...
    ones(1,ceil(7/ts)-ceil(6/ts)),...
    zeros(1,51-ceil(7/ts))]
y2      = conv(h,x);

%======================
%======================
h1_21 = figure(1)
set(h1_21,'color','c','Name','H1.21-H1.24. Simulation Results of NVD4B_sim5 Program: NVD');
%===================
subplot(221);
tt      = t-0.2;
plot(tt,xx_tt,'b','LineWidth',3);
xlabel('Thêi gian','fontname','.vntime','color','b','Fontsize',12);
ylabel('x(t)','fontname','.vntime','color','b','Fontsize',14);
axis([min(tt) max(tt) min(xx_tt)-0.2 max(xx_tt)+0.4]);
title('TÝn hiÖu x(t) ®Çu vµo bé läc','fontname','.vntime','color','b','Fontsize',12);
grid on;
%=====================
subplot(223);
plot(f,fftshift(abs(X1)),'r','LineWidth',3);
xlabel('TÇn sè Hz','fontname','.vntime','color','r','Fontsize',12);
ylabel('|X(f)|','fontname','.vntime','color','r','Fontsize',14);
axis([min(f) max(f) min(fftshift(abs(X1)))-0.2 max(fftshift(abs(X1)))+0.4]);
title('Phæ biªn ®é cña x(t)','fontname','.vntime','color','r','Fontsize',14);
grid on;
%======================
subplot(222);
y1p =abs(y1(1:length(t)));
plot(t,abs(y1(1:length(t))),'k','LineWidth',3);
title('TÝn hiÖu ra bé läc: Tr­êng hîp 1','fontname','.vntime','color','k','Fontsize',12);
xlabel('Thêi gian','fontname','.vntime','color','k','Fontsize',12);
ylabel('y_1(t)','fontname','.vntime','color','k','Fontsize',14);
axis([min(t) max(t) min(y1p)-0.2 max(y1p)+0.4]);
grid on;
%======================
subplot(224);
t2  =[-10:ts:10];
plot([-10:ts:10],y2,'g','LineWidth',3);
title('TÝn hiÖu ra bé läc: Tr­êng hîp 2','fontname','.vntime','color','k','Fontsize',12);
xlabel('Thêi gian','fontname','.vntime','color','k','Fontsize',12);
ylabel('y_2(t)','fontname','.vntime','color','k','Fontsize',14);
axis([min(t2) max(t2) min(y2)-0.2 max(y2)+0.4]);
grid on;
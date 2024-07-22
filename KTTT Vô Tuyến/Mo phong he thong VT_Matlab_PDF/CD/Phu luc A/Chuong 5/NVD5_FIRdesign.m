% File: NVD5_FIRdesign.m
clc;
clear all;
close all;

L       = input('Enter 2L+1 total points (30) = ');         % 2L+1 total points
lam     = input(' normalized cutoff frequency (0.3) = ');   % normalized cutoff frequency
m       = -L:1:L;                                           % vector of points
bp      = sin(pi*lam*(m+eps))./(pi*(m+eps));                % impulse response

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% processing & display
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot impulse response
figure(1);
stem(0:2*L,bp,'.');
xlabel('Ch� s� m�u','fontname','.Vntime','fontsize',12);
ylabel('��p �ng xung kim','fontname','.Vntime','fontsize',12);
title(['��p �ng xung kim: T�ng s� m�u =',num2str(2*L+1),...
    '; D�ch L = ',num2str(L),' m�u'],'fontname','.Vntime','color','b','fontsize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot amp and phase response
figure(2);
a   = 1; 
freqz(bp,a);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
% unwindowed amp response
subplot(2,1,1)
[H w]       = freqz(bp,a);
plot(w/pi,abs(H)); grid;
xlabel('T�n s� (chu�n h�a theo t�n s� Nyquist = f_s/2)','fontname','.Vntime','fontsize',12)
ylabel('|H(f)|','fontname','.Vntime','fontsize',16);
title('��p �ng bi�n �� kh�ng ���c c�a s� h�a','fontname','.Vntime','color','b','fontsize',14)

% windowed amp response
subplot(2,1,2)
w       = 0.54+0.46*cos(pi*m/L);			% Hamming window
wbp     = bp.*w;    						% apply window
wbp_w   =   wbp;
[H w]   = freqz(wbp,a);
plot(w/pi,abs(H)); grid;
xlabel('T�n s� (chu�n h�a theo t�n s� Nyquist = f_s/2)','fontname','.Vntime','fontsize',12)
ylabel('|H(f)|','fontname','.Vntime','fontsize',16);
title('��p �ng bi�n �� ���c c�a s� h�a','fontname','.Vntime','color','b','fontsize',14);

%%%% Comaparision: Implulse response bettwen windowed & Unwindowed
figure(4);
subplot(2,1,1);
stem(0:2*L,bp,'.');
xlabel('Ch� s� m�u','fontname','.Vntime','fontsize',12);
ylabel('��p �ng xung kim','fontname','.Vntime','fontsize',12);
title('��p �ng xung kim kh�ng ���c c�a s�:','fontname','.Vntime','color','b','fontsize',14)
subplot(2,1,2);
stem(wbp_w,'.');
xlabel('Ch� s� m�u','fontname','.Vntime','fontsize',12);
ylabel('��p �ng xung kim','fontname','.Vntime','fontsize',12);
title('��p �ng xung kim:','fontname','.Vntime','color','b','fontsize',14);
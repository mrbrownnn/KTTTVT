% file: NVD5_ellipexan.m

clc;
clear all;
close all;
%=======================
% setup parameter
%=======================
fs          = 100;						% set sampling frequency
fc          = 20;						% set cuttoff frequency
f           = 0:0.1:50;					% define frequency vector
%=======================
% Main program
%=======================
[b,a]       = ellip(5,1,20,2*pi*fc,'s');% synthesize elliptic filter
h           = freqs(b,a,2*pi*f);		% amp. resp. of analog filter
[bz1,az1]   = impinvar(b,a,fs);			% impulse invariant digital filter
h1          = freqz(bz1,az1,f,fs);		% amplitude response of above
[bz2,az2]   = bilinear(b,a,fs);			% bilinear z filter (not prewarped)
h2          = freqz(bz2,az2,f,fs);		% amplitude response of above
[bz3,az3]   = bilinear(b,a,fs,fc);		% bilinear z filter (prewarped)
h3          = freqz(bz3,az3,f,fs);		% amplitude response of above
%=======================
% Display results
%=======================
subplot(2,1,1);
plot(f,abs(h),f,abs(h1));
xlabel('TÇn sè - Hz','fontname','.Vntime','color','b','fontsize',12);
ylabel('§¸p øng biªn ®é','fontname','.Vntime','color','b','fontsize',14);
title('So s¸nh c¸c ®¸p øng biªn ®é: Nguyªn mÉu t­¬ng tù vµ bÊt biÕn xung kim',...
    'fontname','.Vntime','color','b','fontsize',12);
legend('Nguyen mau tuong tu','Bat bien xung kim');
subplot(2,1,2);
plot(f,abs(h2),f,abs(h3));
xlabel('TÇn sè - Hz','fontname','.Vntime','color','b','fontsize',12);
ylabel('§¸p øng biªn ®é','fontname','.Vntime','color','b','fontsize',14);
title('So s¸nh c¸c ®¸p øng biªn ®é hai bé läc biÕn ®æi z song tuyÕn: kh«ng lµm mÐo tÇn sè vµ lµm mÐo tÇn sè',...
    'fontname','.Vntime','color','b','fontsize',12);
legend('Khong lam meo truoc','Lam meo truoc');
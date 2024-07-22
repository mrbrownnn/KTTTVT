% File: NVD7_uni2ray
clc;
clear all;							% be safe
close all;

n           = input('Nhap so diem = ');

varR        = 3;        			% set pdf parameter
u           = rand(1,n);			% generate U
y_exp       = sqrt(-2*varR*log(u)); % transformation
[N_samp,r]  = hist(y_exp,20);       % get histogram parameters

subplot(2,1,1);
bar(r,N_samp,1);				    % plot histogram
ylabel('S� m�u','fontname','.Vntime','fontsize',12);
xlabel('Bi�n ��c l�p - x','fontname','.Vntime','fontsize',12);
title(['Chuy�n ��i t� ph�n b� ��u sang Rayleigh: S� �i�m = ',...
    num2str(n,15)],'fontname','.vntime','color','b','fontsize',12);

subplot(2,1,2)
term1 = r.*r/2/varR;				% exponent
ray = (r/varR).*exp(-term1);	    % Rayleigh pdf
del_r = r(3)-r(2);				    % determine bin width
p_hist = N_samp/n/del_r;		    % probability from histogram
plot(r,ray,'k',r,p_hist,'ok')	    % compare results
ylabel('M�t �� x�c su�t','fontname','.Vntime','fontsize',12);
xlabel('Bi�n ��c l�p - x','fontname','.Vntime','fontsize',12);
legend('pdf dung',' Cac mau tu histogram',1);
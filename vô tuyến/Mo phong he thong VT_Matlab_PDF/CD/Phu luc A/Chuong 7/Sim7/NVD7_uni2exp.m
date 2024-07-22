% File: NVD7_uni2exp
clc;
close all;
clear all								% be safe

n       = input('Nhap so diem = ');
b       = 3;							% set pdf parameter
u       = rand(1,n);					% generate U
y_exp   = -log(u)/b;				    % transformation

[N_samp,x] = hist(y_exp,20);		    % get histogram parameters

%====================
% Display results
%====================
subplot(2,1,1)
bar(x,N_samp,1)						    % plot histogram
ylabel('SË m…u','fontname','.Vntime','fontsize',14);
xlabel('Bi’n ÆÈc lÀp - x','fontname','.Vntime','fontsize',12);
title(['Ph≠¨ng ph∏p chuy”n ÆÊi tı ß“u sang MÚ: SË Æi”m = ',...
    num2str(n,15)],'fontname','.vntime','color','b','fontsize',12);
subplot(2,1,2)
y           = b*exp(-3*x);				% calculate pdf
del_x       = x(3)-x(2);			    % determine bin width
p_hist      = N_samp/n/del_x;		    % probability from histogram
plot(x,y,'k',x,p_hist,'ok');			% compare
ylabel('MÀt ÆÈ x∏c su t','fontname','.Vntime','fontsize',14);
xlabel('Bi’n ÆÈc lÀp - x','fontname','.Vntime','fontsize',12);
legend('pdf dung','Cac mau tu histogram',1);
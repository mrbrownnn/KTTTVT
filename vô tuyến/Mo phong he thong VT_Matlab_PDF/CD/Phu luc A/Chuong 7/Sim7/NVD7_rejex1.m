% File: NVD7_rejex1.m
%
clc;
clear all;
close all;

R       = 7;							% default value of R
M       = 4/pi;							% value of M
N       = input('Nhap so diem dau vao N=  ');
fx      = zeros(1,N);					% array of output samples
u1      = rand(1,N); u2 = rand(1,N);	% generate u1 and u2
v1      = R*u1;							% generate v1
v2      = (M/R)*rand(1,N);				% generate v2 (g(x))
kpts    = 0;							% initialize counter
%============================================
for k=1:N
   if v2(k)<(M/(R*R))*sqrt(R*R-v1(k)*v1(k));
      kpts      = kpts+1;			% increment counter
      fx(kpts)  = v1(k);   			% save output sample
   end
end
fx          = fx(1:kpts);
[N_samp,x]  = hist(fx,20);					% get histogram parameters

%============================================
subplot(2,1,1);
bar(x,N_samp,1)     						% plot histogram
ylabel('S� m�u','fontname','.vntime','fontsize',12)
xlabel('Bi�n ��c l�p - x','fontname','.vntime','fontsize',12);
title(['Ph��ng ph�p lo�i b�: S� �i�m ���c ch�p nh�n = ',num2str(kpts,15),...
    ';  v� N = ',num2str(N,15)],'fontname','.vntime','color','b','fontsize',12);
subplot(2,1,2)
yt      = (M/R/R)*sqrt(R*R-x.*x);				% calculate pdf
del_x   = x(3)-x(2);							% determine bin width
p_hist  = N_samp/kpts/del_x;					% probability from histogram
plot(x,yt,'k',x,p_hist,'ok')				% compare
ylabel('M�t �� x�c su�t','fontname','.vntime','fontsize',12)
xlabel('Bi�n ��c l�p - x','fontname','.vntime','fontsize',12)
legend('pdf dung','Cac mau tu histogram',3)
text = ['So diem duoc chap nhan la: ',...
      num2str(kpts,15),' &  N = ',num2str(N,15),'.'];
disp(text);
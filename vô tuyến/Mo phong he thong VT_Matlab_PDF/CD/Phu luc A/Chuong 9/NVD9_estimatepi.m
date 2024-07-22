% File: NVD9_estimatepi
clc;
clear all;
close all;
m   =input('    Nhap so thi nghiem (5) M=   ');
n   =input('    Nhap so phep thu tren thi nghiem (2500) N=     ');
z   =zeros(1,m);
data    = zeros(n,m);
for j=1:m
    x   =rand(1,n);
    y   =rand(1,n);
    k   =0;
    for i=1:n
        if x(i)^2+y(i)^2 <= 1		% Fall inside pie slice?
            k       =k+1;
        end
        data(i,j)   = 4*(k/i);		% jth estimate of pi
    end
    z(j)    = data(n,j);				% Store data
end
plot(data,'k')						% Plot curves
xlabel('Sã phÐp th­','fontname','.vntime');
ylabel('­íc tÝnh pi','fontname','.vntime');
title('¦íc tÝnh pi theo ph­¬ng ph¸p Monte Carlo','fontname','.vntime','fontsize',14)
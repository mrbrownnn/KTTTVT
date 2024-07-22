% File NVD7_LCGperiod.m
clc;
clear all;

a       = input('Nhap a > ');
c       = input('Nhap c > ');
m       = input('Nhap m > ');
seed    = input('Nhap seed > '); 

n       =1;
ix      = rem((seed*a+c),m);
while  (ix~=seed)&(n<m+2) 
   n    = n+1;
   ix   = rem((ix*a+c),m);
end
if n>m
   disp('Khoa vong.')
else
   text     = ['Chu ky la ',num2str(n,15),'.'];
   disp(text)
end
% File: c7_LCDemo2
clc;
clear all;

%============================
m       = 2048; 
c       = 1;
seed    = 1;

a1      = 65;
a2      = 1229;
ix1     = 1;
ix2     = 1;

x1 = zeros(1,m); 
x2 = zeros(1,m);
%============================
for i=1:m
   ix1      = rem((ix1*a1+c),m);
   x1(i)    = ix1;
   ix2      = rem((ix2*a2+c),m);
   x2(i)    = ix2;
end
%============================
% calculate Durbin parameters
D1  = NVD7_Durbin(x1);
D2  = NVD7_Durbin(x2);

% calculate correlation
rho1    = 1 - D1/2;
rho2    = 1 - D2/2;
text1   = ['Gia tri cua D1 =   ',num2str(D1),'     &      rho1 = ',num2str(rho1),'.'];
text2   = ['Gia tri cua D2 =   ',num2str(D2),'     &      rho2 = ',num2str(rho2),'.'];   
disp(text1);
disp(text2);
% File: NVD7_LCDemo1.m

%========================
% default values of m and c
m       = 2048;     
c       = 1;
seed    = 1;
% multiplier values
a1      = 65;
a2      = 1229;
% initialize algorithm
ix1     = seed;
ix2     = seed;
% initialize arrays
x1      = zeros(1,m);
x2      = zeros(1,m);
%========================
for i=1:m
   ix1      = rem((ix1*a1+c),m);
   x1(i)    = ix1/m;
   ix2      = rem((ix2*a2+c),m);
   x2(i)    = ix2/m;
end
%========================
subplot(1,2,1)
y1          = [x1(1,2:m),x1(1,1)];
plot(x1,y1,'.')
title('Bi�u �� t�n x� ��i v�i a_1 = 65','fontname','.vntime')
subplot(1,2,2);
y2          = [x2(1,2:m),x2(1,1)];
plot(x2,y2,'.');
title('Bi�u �� t�n x� ��i v�i a_2 = 1229','fontname','.vntime','color','b');
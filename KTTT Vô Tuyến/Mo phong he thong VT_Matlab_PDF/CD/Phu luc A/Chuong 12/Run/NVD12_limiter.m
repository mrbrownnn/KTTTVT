% file: NVD12_limiter
clc;
clear all;
close all;
x   = -10:0.1:10;						% input voltage vector
M   = 1;								% output limiting value
m   = 1;								% inut limiting value
s   = [0.5 1.0 10.0];					% vector of shape factors 
for k = 1:201
   xx   = x(k);
   num  = M*sign(xx);
   for kk = 1:3
      xxx       = (m/abs(xx))^s(kk);
      den       = (1+xxx)^(1/s(kk));
      y(k,kk)   = num/den;
   end
end
plot(x,y(:,1),'k-',x,y(:,2),'k:',x,y(:,3),'k--');
grid
xlabel('ßi÷n ∏p vµo','fontname','.Vntime','color','b','fontsize',12);
ylabel('ßi÷n ∏p ra','fontname','.Vntime','color','b','fontsize',12);
title('C∏c Æ∆c t›nh bÈ giÌi hπn','fontname','.Vntime','color','b','fontsize',13);
legend('s=0.5','s=1.0','s=10.0',2);
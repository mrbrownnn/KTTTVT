function [] = dqplot(xd,xq)
% File: dqplot.m
lx      = length(xd);
t       = 0:lx-1;
nt      = t/(lx-1);
nxd     = xd(1,1:lx);
nxq     = xq(1,1:lx);

subplot(211)
plot(nt,nxd);
a       = axis;
axis([a(1) a(2) 1.5*a(3) 1.5*a(4)]);
title('TÝn hiÖu kªnh I vµ Q cña pi/4DQPSK','fontname','.vntime','color','b','fontsize',16);
xlabel('Thêi gian chuÈn hãa','fontname','.vntime','fontsize',12);
ylabel('Thµnh ph©n I','fontname','.vntime','color','b','fontsize',12);
subplot(212)
plot(nt,nxq);
a   = axis;
axis([a(1) a(2) 1.5*a(3) 1.5*a(4)]);
xlabel('Thêi gian chuÈn hãa','fontname','.vntime','fontsize',12);
ylabel('Thµnh ph©n Q','fontname','.vntime','color','b','fontsize',12);
subplot(111)
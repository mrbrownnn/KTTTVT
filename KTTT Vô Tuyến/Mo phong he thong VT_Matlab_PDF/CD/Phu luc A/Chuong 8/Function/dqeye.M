function [] = dqeye(xd,xq,m)
% File: dqeye.m
lx = length(xd);                % samples in data segment
kcol = floor(lx/m);             % number of columns
xda = [0,xd]; xqa = [0,xq];     % append zeros
for j = 1:kcol                  % column index
    for i = 1:(m+1)             % row index
        kk = (j-1)*m+i;         % sample index
        y1(i,j) = xda(kk);
        y2(i,j) = xqa(kk);
    end
end
subplot(211)                    % direct channel
plot(y1);
title('BiÓu ®å m¾t trªn trôc I & Q cña pi/4DQPSK','fontname','.vntimeH','color','b','fontsize',14);
xlabel('ChØ sè mÉu','fontname','.vntime','color','b','fontsize',12);
ylabel('Thµnh phÇn I ','fontname','.vntime','color','b','fontsize',12);

subplot(212)                    % quadrature channel
plot(y2);
xlabel('ChØ sè mÉu','fontname','.vntime','color','b','fontsize',12);
ylabel('Thµnh phÇn Q ','fontname','.vntime','color','b','fontsize',12);
subplot(111)                    % restore
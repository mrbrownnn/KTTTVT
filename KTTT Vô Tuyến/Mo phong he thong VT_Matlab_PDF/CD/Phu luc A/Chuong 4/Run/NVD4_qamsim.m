% file NVD4_qamsim
clc;
clear all;
close all;
%================================================================
% setup parameter
%================================================================
levelx      = input('So muc tren thanh phan I > ');
levely      = input('So muc tren thanh phan Q > ');
m           = input('So ky hieu > ');
n           = input('So mau tren ky hieu > ');
bw          = input('Do rong bang thong bo loc, 0<bw<1 > ');
%================================================================
% Main Program
%================================================================
[xd,xq]     = qam(levelx,levely,m,n);
[b,a]       = butter(6,bw);			% determine filter coefficients
yd          = filter(b,a,xd);		% filter Inphase coefficient
yq          = filter(b,a,xq);		% filter Quadrature coefficient
%================================================================
%===================================
% Process & Display results
%===================================
subplot(2,2,1)						% first pane
plot(xd,xq,'o')						% unfiltered scatterplot
a           = 1.4;
maxd        = max(xd);
maxq        = max(xq);
mind        = min(xd);
minq        = min(xq);
axis([a*mind a*maxd a*minq a*maxq])
axis equal
xlabel('x_I','fontname','.Vntime','fontsize',14); 
ylabel('x_Q','fontname','.Vntime','fontsize',14);
title('Chﬂm sao t›n hi÷u kh´ng bﬁ l‰c','fontname','.Vntime','fontsize',12)
%============
subplot(2,2,2)						% second pane
plot(yd,yq)							% filtered scatterplot
axis equal;
xlabel('x_I','fontname','.Vntime','fontsize',14);
ylabel('x_Q','fontname','.Vntime','fontsize',14);
title('Chﬂm sao t›n hi÷u bﬁ l‰c','fontname','.Vntime','fontsize',12)
%============
sym     = 30;						% number of symbols in time plot
nsym    = (0:sym*n)/n;				% x axis vector for time plots
subplot(2,2,3)						% third pane 
plot(nsym(1:sym*n),yd(1:sym*n))	    % filtered direct component 
xlabel('Chÿ sË k˝ hi÷u','fontname','.Vntime','fontsize',12);
ylabel('x_I','fontname','.Vntime','fontsize',14);
title('Thµnh ph«n I bﬁ l‰c','fontname','.Vntime','fontsize',12);
%============
subplot(2,2,4)						% fourth pane
plot(nsym(1:sym*n),yq(1:sym*n))	    % filtered quadrature component
xlabel('Chÿ sË k˝ hi÷u','fontname','.Vntime','fontsize',12);
ylabel('x_Q','fontname','.Vntime','fontsize',14);
title('Thµnh ph«n Q bﬁ l‰c','fontname','.Vntime','fontsize',12);
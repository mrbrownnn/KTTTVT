function y = cs11qa


close all;
clear all;
t   =   -2:6/1000:2;
N   =   input('Nhap so hai =    ');
c0  =   0.5;
w0  =   pi;
xN  =   c0*ones(1,length(t));  % DC Compoment

for k=1:2:N                     % Odd function
    theta = ((-1)^((k-1)/2)-1)*pi/2;
    xN = xN + 2/k/pi*cos(k*w0*t + theta);
end

h1 = figure(1)
set(h1,'color','g');
set(h1,'Name','Designed by Eng. Nguyen Viet Dam');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,1:2);
plot(1:length(xN),xN);
xlabel('Th�i gian t','FontName','.VnTime','color','b','FontSize',9);
ylabel('x_N(t)','FontName','.VnTime','color','b','FontSize',12);
title(['Kh�o s�t d�ng s�ng t�n hi�u x_N(t) khi s� hai N = ',num2str(N)],'FontName','.VnTime','color','b','FontSize',12);
grid on;
% hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n       =   [-N:1:N];
x_n1    =   0.5*sinc(n/2)
x_n2    =   0.5*abs(sinc(n/2));
subplot(2,2,3);
stem(n,x_n1);
xlabel('Th�i gian n','FontName','.VnTime','color','b','FontSize',9);
ylabel('x_n','FontName','.VnTime','color','b','FontSize',14);
title(['Ph� v�ch c�a t�n hi�u x_N(t) khi N = ',num2str(N)],'FontName','.VnTime','color','b','FontSize',9);

subplot(2,2,4)
stem(n,x_n2);
xlabel('Th�i gian n','FontName','.VnTime','color','b','FontSize',9);
ylabel('|x_n|','FontName','.VnTime','color','b','FontSize',14);
title(['Ph� v�ch c�a t�n hi�u x_N(t) khi N = ',num2str(N)],'FontName','.VnTime','color','b','FontSize',9);
grid on;
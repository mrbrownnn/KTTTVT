function y = NVD4B_sim1
%file NVD4B_sim1.m

% close all;
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

%==========================================
h1 = figure(1)
set(h1,'color','c','Name','H4B.1.3: NVD');

subplot(2,2,1:2);
plot(1:length(xN),xN,'LineWidth',2);
xlabel('Thêi gian','FontName','.VnTime','FontSize',12);
ylabel('x_N(t)','FontName','.VnTime','FontSize',16);
title(['D¹ng sãng tÝn hiÖu x_N(t) khi sè hµi N = ',...
    num2str(N)],'FontName','.VnTime','FontSize',14);
grid on;

n       =   [-N:1:N];
x_n1    =   0.5*sinc(n/2);
x_n2    =   0.5*abs(sinc(n/2));
subplot(2,2,3);
stem(n,x_n1,'.k','LineWidth',2);
xlabel('n','FontName','.VnTime','FontSize',14);
ylabel('x_n','FontName','.VnTime','FontSize',16);
axis([min(n) max(n) min(x_n1)-0.1 max(x_n1)+0.2])
title(['Phæ v¹ch cña tÝn hiÖu x_N(t) khi N = ',...
    num2str(N)],'FontName','.VnTime','FontSize',12);


subplot(2,2,4)
stem(n,x_n2,'.k','LineWidth',2);
xlabel('n','FontName','.VnTime','FontSize',14);
ylabel('|x_n|','FontName','.VnTime','FontSize',16);
title(['Phæ v¹ch cña tÝn hiÖu x_N(t) khi N = ',...
    num2str(N)],'FontName','.VnTime','FontSize',12);
axis([min(n) max(n) min(x_n2)-0.1 max(x_n2)+0.2])
grid on;
%===============================================
h2 = figure(2);     % Compared figure
set(h2,'color','g','Name','H4B.1.3: NVD');
subplot(211)
plot(1:length(xN),xN,'r','LineWidth',3);
xlabel('Thêi gian','FontName','.VnTime','FontSize',12);
ylabel('x_N(t)','FontName','.VnTime','FontSize',16);
title(['D¹ng sãng tÝn hiÖu x_N(t) khi sè hµi N=',num2str(N)],'FontName','.VnTime','FontSize',14);
grid on;

subplot(212)
plot(1:length(xN),xN,'LineWidth',1.5);
xlabel('Thêi gian','FontName','.VnTime','FontSize',12);
ylabel('x_N(t)','FontName','.VnTime','FontSize',16);
title('So s¸nh d¹ng sãng tÝn hiÖu x_N(t) khi sè hµi kh¸c nhau','FontName','.VnTime','FontSize',14);
grid on;
hold on;
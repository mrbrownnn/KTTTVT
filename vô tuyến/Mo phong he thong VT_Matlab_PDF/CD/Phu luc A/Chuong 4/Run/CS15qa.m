function y = CS15qa

df  =   0.01;
fs  =   10;
ts  =   1/fs;
t   =   [-5:ts:5];

x1  =   zeros(size(t));
x1(41:51)   =   t(41:51)+1;
x1(52:61)   =   ones(size(x1(52:61)));

x2         =    zeros(size(t));
x2(51:71)  =    x1(41:61);

[X1,x11,df1]    =   fftseq(x1,ts,df);
[X2,x21,df2]    =   fftseq(x2,ts,df);

X11 =   X1/fs;
X21 =   X2/fs;

f   =  [0:df1:df1*(length(x11)-1)]-fs/2;

h1 = figure(1)
set(h1,'color','g');
set(h1,'Name','Designed by Eng. Nguyen Viet Dam');
plot(f,fftshift(abs(X21)));
xlabel('TÇn sè H_z','FontName','.VnTime','color','b','FontSize',8)
ylabel('|X_1(f)| / |X_2(f)|','FontName','.VnTime','color','b','FontSize',12)
title('Phæ biªn ®é X_1(f) & X_2(f) t­¬ng øng víi x_1(t) & x_2(t)',...
    'FontName','.VnTime','color','b','FontSize',12);
grid on

h2 = figure(2)
set(h2,'color','g');
set(h2,'Name','Designed by Eng. Nguyen Viet Dam');

subplot(2,1,1)
plot(t,x1,t,x2,'r');
axis([-5 5 -1 2]);
xlabel('Thêi gian','FontName','.VnTime','color','b','FontSize',8)
ylabel('x_1(t)/x_2(t)','FontName','.VnTime','color','b','FontSize',12)
title('Quan hÖ d¹ng sãng tÝn hiÖu x_1(t) & x_2(t)',...
    'FontName','.VnTime','color','b','FontSize',12);
grid on

subplot(2,1,2);
plot (f(500:525),fftshift(angle(X11(500:525))),f(500:525),fftshift(angle(X21(500:525))),'r');
xlabel('TÇn sè H_z','FontName','.VnTime','color','b','FontSize',8);
ylabel('Arg (radian)','FontName','.VnTime','color','b','FontSize',12);
title('Phæ pha cña X_1(f) , X_2(f)',...
    'FontName','.VnTime','color','b','FontSize',12);
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h3 = figure(3)
set(h3,'color','g');
set(h3,'Name','Designed by Eng. Nguyen Viet Dam');    

subplot(2,2,2);
plot(f,fftshift(abs(X21)));
xlabel('TÇn sè H_z','FontName','.VnTime','color','b','FontSize',8)
ylabel('|X_1(f)| / |X_2(f)|','FontName','.VnTime','color','b','FontSize',12)
title('Phæ biªn ®é X_1(f) & X_2(f)',...
    'FontName','.VnTime','color','b','FontSize',12);
grid on

subplot(2,2,[1,3]);
plot(t,x1,t,x2,'r');
axis([-5 5 -1 2]);
xlabel('Thêi gian','FontName','.VnTime','color','b','FontSize',8)
ylabel('x_1(t)/x_2(t)','FontName','.VnTime','color','b','FontSize',12)
title('D¹ng sãng cña x_1(t) & x_2(t)',...
    'FontName','.VnTime','color','b','FontSize',12);
grid on

subplot(2,2,4);
plot (f(500:525),fftshift(angle(X11(500:525))),f(500:525),fftshift(angle(X21(500:525))),'r');
xlabel('TÇn sè H_z','FontName','.VnTime','color','b','FontSize',8);
ylabel('Arg (radian)','FontName','.VnTime','color','b','FontSize',12);
title('Phæ pha cña X_1(f) , X_2(f)',...
    'FontName','.VnTime','color','b','FontSize',12);
grid on
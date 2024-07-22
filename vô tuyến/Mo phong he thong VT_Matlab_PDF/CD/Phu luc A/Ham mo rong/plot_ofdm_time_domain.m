Ts =1;
f = 0;
N=10000;
t = 0:1/N:1;
%t2 =0:1/1000:0.2;
%t2 = t2*200;
%k = length(t2);
%%%%%%
y1 = cos(2*pi*(f+10)*t); 
y11 =abs(fft(y1))/500; 
%%%%%%
y2 = cos(2*pi*(f+20)*t);
y22 =abs(fft(y2))/500;
%%%%%%
y3 = cos(2*pi*(f+30)*t);
y33 =abs(fft(y3))/500;
%%%%%%
y4 = cos(2*pi*(f+40)*t);
y44 =abs(fft(y4))/500;
%%%%%%
y5 = y1 + y2 + y3 + y4;
y55 = abs(fft(y5))/500;
subplot(4,2,1);
plot(t(1:1000),y1(1:1000));
subplot(5,2,2);
plot(y11);
xlim([2 50]);
subplot(5,2,3);
plot(t,y2);
subplot(5,2,4);
plot(y22);
xlim([2 50]);
subplot(5,2,5);
plot(t,y3);
subplot(5,2,6);
plot(y33);
xlim([2 50]);
subplot(5,2,7);
plot(t,y4);
subplot(5,2,8);
plot(y44);
xlim([2 50]);
subplot(5,2,9);
plot(t(1:1000),y5(1:1000));
subplot(5,2,10);
plot(y55);
xlim([2 50]);

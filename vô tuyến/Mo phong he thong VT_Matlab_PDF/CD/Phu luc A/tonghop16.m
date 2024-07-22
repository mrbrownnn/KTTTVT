% function tonghop16
clc;
clear all;
close all;

x   =   10*rand(1,500)-5;
y   =   10*rand(1,500)-5;

subplot(2,1,1)
plot(x,y,'k+');
xlabel('X');
ylabel('Y');
subplot(2,1,2)
xlabel('C¸c mÉu ®­îc xö lý','fontname','.vntime');
ylabel('¦íc tÝnh diÖn tÝch','fontname','.vntime');
ylim([0 6]);
xlim([0 500]);
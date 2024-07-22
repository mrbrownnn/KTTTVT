% File: NVD3_upsamplex
clc;
clear all;
close all;

M       = 6;                        % upsample factor
h       = NVD3_lininterp(M);		% imp response of linear interpolator
t       = 0:10;                     % time vector
tu      = 0:M*10;                   % upsampled time vector
x       = sin(2*pi*t/10);           % original samples
xu      = NVD3_upsamp(x,M); 		% upsampled sequence
xi      = conv(h,xu);
%%=====================================
%% Display results
%%=====================================
subplot(3,1,1)
stem(t,x,'k.')
ylabel('x[k]','FontName','.VnTime','color','b','FontSize',14);
title(['Upsampling v� n�i suy khi M= ',num2str(M),...
    '; �� d�i x[k]= ',num2str(length(x)),...
    '; �� d�i x_u[k]= ',num2str(length(xu)),...
    '; �� d�i x_i[k]= ',num2str(length(xi)),...
    ],'FontName','.VnTime','color','b','FontSize',12);
subplot(3,1,2)
stem(tu,xu,'r.')
ylabel('x_u[k]','FontName','.VnTime','color','b','FontSize',14);
subplot(3,1,3)
stem(xi,'b.')
ylabel('x_i[k]','FontName','.VnTime','color','b','FontSize',14);
clear all;
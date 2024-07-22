% File: c7_PNSim.n
clc
clear all;
close all;

pntaps          = [0 0 1 0 0 0 0 0 0 1];   	% shift register taps
pninitial       = [0 0 0 0 0 0 0 0 0 1];   	% initial shift register state
pndata          = zeros(1,1023);			% initialize output vector

samp_per_sym = input('Nhap so mau/ky hieu (1 or 5) =     ');
% samp_per_sym    = 5;						% samples per symbol

pnregister      = pninitial;				% initialize shift register
n               = 0;						% initialize counter
kk              = 0;						% set terminator indicator

while kk == 0
   n            = n+1;							% increment counter
   pndata(1,n)  = pnregister(1,1);				% save output
   feedback     = rem((pnregister*pntaps'),2);	% calculate feedback
   pnregister   = [feedback,pnregister(1,1:9)];	% increment register   
   if pnregister == pninitial
       kk       = 1;
   end		% reset termination
end
text    = ['Chu ky =    ',num2str(n,15),'.'];

disp(text)										% display period
pndata  = hold_in(pndata,samp_per_sym);         % replicate data %%%%% hold_in
kn      = n*samp_per_sym;						% length of output vector	
pndata  = 2*pndata - 1;							% make output +/- one
a       = fft(pndata);
b       = a.*conj(a);							% PSD of data
Rm      = real(ifft(b))/kn;						% autocorrelation
x1      = (0:length(Rm)-1)/samp_per_sym;
x2      = 0:100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,1)
plot(x1,Rm,'.k'); 
ylabel('R[m]','fontname','.vntime','fontsize',12);
title(['Chu�i PN: s� m�u tr�n k� hi�u l� = ',num2str(samp_per_sym),...
    ';  Chu chu k� = ',num2str(n,15)],'fontname','.vntime','color','b','fontsize',12);

subplot(3,1,2)
stem(x2,Rm(1:101),'.k');
ylabel('R[m] m�t ph�n','fontname','.vntime','color','b','fontsize',10);

subplot(3,1,3)
stem(x2,pndata(1:101),'.k');
ylabel('100 ��u ra ��u ti�n','fontname','.vntime','fontsize',10);
axis([0 100 -1.5 1.5]);
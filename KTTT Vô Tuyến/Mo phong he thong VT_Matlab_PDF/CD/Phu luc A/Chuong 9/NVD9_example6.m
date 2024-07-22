% File: NVD9_example6.m
clc;
clear all;
close all;

mean    = sqrt(pi)*(0.5-q((sqrt(2))));  % result
int2    = sqrt(pi/2)*(0.5-q(2));		% 2nd integral
varx    = int2-mean*mean;				% variance of estimate
stdx    = sqrt(varx);					% standard deviation
alpha   = 0.1;							% for 90% confidece interval
%====================================
nsum    = 0;							% initialize nsum
nppseg  = 1000;							% samples per segment
nseg    = 100;							% number of segments
est     = zeros(1,nseg);				% initialize vector
%====================================
for j=1:nseg							% increment segment
   ui   = rand(1,nppseg);				% uniform samples
   gui  = sum(exp(-ui.*ui));		    % integrand samples
   nsum = nsum+gui;						% sum samples
   est(j) = nsum/(j*nppseg);   		    % normalize
end										% end loop
%====================================
nn      = nppseg*(1:nseg);				% sample index
ub      = mean+stdx*qinv(alpha/2)./sqrt(nn);% upper bound
lb      = mean-stdx*qinv(alpha/2)./sqrt(nn);% lower bound
meanv   = mean*ones(1,nseg);			% exact result
si      = 1:nseg;						% seg. index for plot
plot(si,est,'k-',si,meanv,'k--',si,ub,'k:',si,lb,'k:')
xlabel('SË Æoπn','fontname','.vntime');
ylabel('≠Ìc t›nh t›ch ph©n','fontname','.vntime');

legend('Gia tri uoc tinh','Gia tri dung','Gioi han tren ','Gioi han duoi');
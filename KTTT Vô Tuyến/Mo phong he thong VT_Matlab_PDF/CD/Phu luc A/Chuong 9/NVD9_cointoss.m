% File: NVD9_cointoss.m
clc;
clear all;
close all;
M   = 2000;				    % number of experiments
N   = 500;					% Number of tosses / experiment
H   = zeros(1,M);           % Initialize array
H_theor = zeros(1,M);	    % Initialize array
for j=1:M
   A        = rand(1,N);
   heads    = 0;
   for k=1:N
      if A(k)<=0.2
         heads = heads+1;
      end
   end
   H(j)     = heads;
end
H_max   = max(H); H_min = min(H);
r       = H_min:H_max;
[Nb]    = hist(H,r);
%==========
for k=H_min:H_max
   H_theor(k) = M*nkchoose(N,k)*((0.2)^k)*((0.8)^(N-k));
end
subplot(2,1,1)
hist(H,r)
xlabel('Sè mÆt ngöa','fontname','.vntime')
ylabel('Sè lÇn xuÊt hiÖn','fontname','.vntime');
title('KÕt qu¶ cña thÝ nghiÖm tung ®ång xu','fontname','.vntime','color','b','fontsize',14)
subplot(2,1,2)
plot(r,Nb,'ok',r,H_theor(1,H_min:H_max),'k')
xlabel('Sè mÆt ngöa','fontname','.vntime');
ylabel('Sè lÇn xuÊt hiÖn','fontname','.vntime');
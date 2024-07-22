function [logpsd,freq,ptotal,pmax] = NVD12_log_psd(x,n,ts)

y   = zeros(1,n);

h   = waitbarqa(0,'Ch­¬ng tr×nh ®ang tÝnh PSD');
for k=1:n
	freq(k)     =(k-1-(n/2))/(n*ts);
   y(k)         = x(k)*((-1.0)^k);
   waitbarqa(k/n)
end;
v           = fft(y)/n;
psd         = abs(v).^2;
pmax        = max(psd);
ptotal      = sum(psd);
logpsd      = 10*log10(psd/pmax);
%===============================
% Truncate negative values at -60 dB
%===============================
for k =1:n
	if(logpsd(k)<-60.0)
      logpsd(k) =-60.0;
	end
end
close(h)
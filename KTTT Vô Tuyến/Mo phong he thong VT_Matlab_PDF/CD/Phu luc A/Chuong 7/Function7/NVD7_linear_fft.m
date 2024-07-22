function [fftx,freq] = NVD7_linear_fft(x,n,ts)

% File: NVD7_linear_fft.m
% This function takes n (must be even) time domain samples (real or complex)
% and finds the PSD by taking (fft/n)^2. The two sided spectrum is
% produced by shifting the PSD. The array freq provides the appropriate
% frequency values for plotting purposes.
% By taking 10*log10(psd/max(psd)) the psd is  normalized. Values beow 60db 
% are set equal to -60 dB.

y           =   zeros(1,n);
for k=1:n
	freq(k) = (k-1-(n/2))/(n*ts);
   y(k)     = x(k)*((-1.0)^(k+1));
end;
fftx        = fft(y)/n;
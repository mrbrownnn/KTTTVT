function [x] = NVD13_mpsk_pulses(M,nsymbols,nsamples)

% This function genrates a random MPSK  complex NRZ waveform of 
% length nsymbols; Each symbol is sampled at a rate of nsamples/bit

u       = rand(1,nsymbols);rinteger= round ((M*u)+0.5);
phase   = pi/M+((rinteger-1)*(2*pi/M));
for m=1:nsymbols
   for n=1: nsamples
      index         =   (m-1)*nsamples + n;
      x(1,index)    =   exp(i*phase(m));
   end
end
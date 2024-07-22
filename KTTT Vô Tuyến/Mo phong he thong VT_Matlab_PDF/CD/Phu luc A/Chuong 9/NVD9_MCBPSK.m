% File: NVD9_MCBPSK.m
clc;
clear all;
close all;
snrdB_min   = -3; snrdB_max = 8;	    % SNR (in dB) limits 
snrdB       = snrdB_min:1:snrdB_max;
Nsymbols    = input('Nhap so ky hieu > ');
snr         = 10.^(snrdB/10);			% convert from dB
h           = waitbarqa(0,'LÆp SNR');
len_snr     = length(snrdB);

for j=1:len_snr                         % increment SNR
   waitbarqa(j/len_snr)
   sigma    = sqrt(1/(2*snr(j)));	    % noise standard deviation
   error_count = 0;
   for k=1:Nsymbols                     % simulation loop begins
      d     = round(rand(1));			% data
      x_d   = 2*d - 1;                  % transmitter output
      n_d   = sigma*randn(1);		    % noise
      y_d   = x_d + n_d;				% receiver input
      if y_d > 0                        % test condition
         d_est = 1;                     % conditional data estimate
      else
         d_est = 0;                     % conditional data estimate
      end
      if (d_est ~= d)
         error_count = error_count + 1;	% error counter
      end
   end									% simulation loop ends
   errors(j) = error_count;		        % store error count for plot
end
close(h)
ber_sim     = errors/Nsymbols;		    % BER estimate
ber_theor   = erfc(sqrt(1*snr))/2;	    % theoretical BER
semilogy(snrdB,ber_theor,snrdB,ber_sim,'o')
axis([snrdB_min snrdB_max 0.0001 1])
xlabel('SNR [dB]','fontname','.vntime')
ylabel('BER','fontname','.vntime')
legend('Ly thuyet','Mo phong');
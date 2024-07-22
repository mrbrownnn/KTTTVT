%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================

function y = FWC_Rayleigh_Channel(T, N, fd)

if (N/T <= 2*fd)
    error('Sampling criteria N/T <= 2*fd not met.'); 
end

% Construct frequency response of Doppler filter
f       = (1/T)*[(0:ceil(N/2)-1)  ((ceil(N/2):N-1) - N)]';
H       = (abs(f) < fd)./sqrt(1 - f.^2.*(abs(f) < fd)/fd^2);
H       = sqrt(N*H/sum(H));
% Construct Rayleigh fading process
x       = randn(N,1);             % Gaussian noise with unit energy per sample
y       = real(ifft(H.*fft(x)));
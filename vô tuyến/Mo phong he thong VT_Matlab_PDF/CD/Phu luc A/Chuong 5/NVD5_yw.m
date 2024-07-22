% Program: c5_yw.m

order = 20,								% degree of polynomials
f = [0 0.1 0.12 0.23 0.25 0.35 0.37 1];	% frequency points
amp = [1 1 0 0 1 1 0 0];				% amplitude response
[b,a] = yulewalk(order,f,amp);			% synthesize filter
freqz(b,a)								% display results
% End of script file.
% nvd_freqz
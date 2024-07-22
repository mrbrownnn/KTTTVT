% ****************************************************************
% Program autocorr.m: Autocorrelation function of a sequence
% ****************************************************************

function [out] = MA_05_autocorr(indata, tn)


% ****************************************************************
% indata : input sequence
% tn     : number of period
% out    : autocorrelation data
% ****************************************************************

if nargin < 2
    tn = 1;
end

ln  = length(indata);
out = zeros(1,ln*tn);

for ii=0:ln*tn-1
    out(ii+1) = sum(indata.*shift(indata,ii,0));
end
%******************************** end of file ********************************
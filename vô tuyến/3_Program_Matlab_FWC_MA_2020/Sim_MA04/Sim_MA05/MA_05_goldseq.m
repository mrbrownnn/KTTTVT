%--------------------------------------------------------------------------
% Program MA_05_goldseq.m: The generation function of Gold sequence
%--------------------------------------------------------------------------

function [gout] = MA_05_goldseq(m1, m2, n)


% ****************************************************************
% m1 : M-sequence 1
% m2 : M-sequence 2
% n  : Number of output sequence(It can be omitted)
% gout : output Gold sequence
% ****************************************************************

if nargin < 3
    n = 1;
end

gout = zeros(n,length(m1));

for ii=1:n
    gout(ii,:) = xor(m1,m2);
    m2         = MA_05_shift(m2,1,0);
end

%******************************** end of file ********************************
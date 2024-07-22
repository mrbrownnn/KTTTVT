function h=rcos(k,m,beta)
% File: rcos.m

% k - samples per symbol
% m - delay is mT
% beta - bandwidth factor
%

beta    = beta;
n       = 0:2*m*k;
z       = (n/k)-m+eps;
t1      = cos(beta*pi*z);
t2      = sin(pi*z)./(pi*z);
t3      = 1-4*beta*beta*z.*z;
h       = t2.*t1./(t3);
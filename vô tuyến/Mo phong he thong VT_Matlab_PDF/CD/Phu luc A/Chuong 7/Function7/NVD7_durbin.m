function D = NVD7_durbin(x)
% File: NVD7_Durbin
N       = length(x);			% length of input vector
y       = x-mean(x);			% remove dc
ydiff   = y(2:N)-y(1:(N-1));	% numerator summand
Num     = sum(ydiff.*ydiff);	% numerator factor of D 
Den     = sum(y.*y);			% denominator factor of D
D       = Num/Den;				% Durbin factor
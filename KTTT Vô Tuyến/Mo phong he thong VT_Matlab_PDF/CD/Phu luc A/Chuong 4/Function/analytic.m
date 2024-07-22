function z=analytic(x)
%   z=analytic(x)
%ANALYTIC Return the analytic signal corresponding to signal x
%
z = hilbert(x);
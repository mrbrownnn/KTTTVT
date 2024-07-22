function out=nkchoose(n,k)

% File: nkchoose.m
% Computes n!/k!/(n-k)!

a   = sum(log(1:n));		% ln of n!
b   = sum(log(1:k));		% ln of k!
c   = sum(log(1:(n-k)));	% ln of (n-k)!
out = round(exp(a-b-c));	% result

function out=NVD8_nkchoose(n,k)
% File: NVD8_nkchoose.m
% Computes n!/k!/(n-k)!
a   = sum(log(1:n));		% ln of n!
b   = sum(log(1:k));		% ln of k!
c   = sum(log(1:(n-k)));	% ln of (n-k)!
out = round(exp(a-b-c));	% result
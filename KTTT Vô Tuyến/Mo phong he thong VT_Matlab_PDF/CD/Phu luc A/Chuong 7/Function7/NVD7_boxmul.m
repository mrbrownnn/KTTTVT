function [out1,out2]=NVD7_boxmul(N)
% File: NVD7_boxmul.m
u1      = rand(1,N);					% generate first uniform RV
u2      = rand(1,N);					% generate second uniform RV
ray     = sqrt(-2*log(u1));				% generate Rayleigh RV
out1    = ray.*cos(2*pi*u2);			% first Gaussian output
out2    = ray.*sin(2*pi*u2);			% second Gaussian output
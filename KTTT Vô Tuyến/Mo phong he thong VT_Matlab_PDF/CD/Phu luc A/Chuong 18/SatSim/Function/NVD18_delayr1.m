function [xout] =   NVD18_delayr1(xin,ndelay)

% File: delayr1.m

n       = max(max(size(xin)));
if (ndelay==0)
   xout =xin;
else
   xx   = zeros(1,ndelay); 
   xout = [xx xin(1,1:n-ndelay)];
end
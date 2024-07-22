function [y] = NVD14_linear_interp(x,m)
% File: linear_interp.m
% This function takes the elements in a colium(row) vector x and 
% produces linearly interpolated vlaues in array y.
% Interpolation factor is m

nx          = max(max(size(x)));
for n=1:nx
   data     = x(n);
   for nn = 1:m
      index     = (n-1)*m+nn;
      y(index)  = data;
   end
end
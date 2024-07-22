function [out1,out2] = NVD7_polar(N)

% File: NVD7_polar.m

u1      = rand(1,N);    u2  = rand(1,N);    % generate uniform RVs
v1      = 2*u1-1;       v2  = 2*u2-1;       % make uniform in -1 to +1
outa    = zeros(1,N);   outb = zeros(1,N);  % allocate memory
j       = 1;								% initialize counter

for i=1:N
   s(i)     = v1(i)^2 + v2(i)^2;		% generate s
   if s(i) < 1                          % test
      j     = j+1;                  	% incremant counter
      a(i)  = sqrt((-2*log(s(i)))/s(i));      
      outa(j) = a(i)*v1(i);             % first Gaussian RV
      outb(j) = a(i)*v2(i);             % second Gaussian RV
   end
end     
out1 = outa(1,1:j); out2 = outb(1,1:j); % truncate arrays
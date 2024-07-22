function [y] = NVD12_salehs_model(x,backoff,n)

y       = zeros(1,n)*(1.0+i*1.0);
a1      = 2.1587; b1 = 1.15;
a2      = 4.0; b2 = 2.1;
c       = 10^(backoff/20);
for k=1:n
    ain         = c*abs(x(k));
    thetain(k)  = angle(x(k));
    aout        = a1*ain/(1+b1*ain^2);
    thetapm(k)  = a2*ain^4/(1+b2*ain^2);
    thetaout(k) = thetain(k)+thetapm(k);
    y(k)        = aout*exp(i*thetaout(k));
end
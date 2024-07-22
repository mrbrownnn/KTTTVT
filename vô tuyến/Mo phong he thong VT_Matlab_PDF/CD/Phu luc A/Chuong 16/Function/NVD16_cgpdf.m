function value = NVD16_cgpdf(x,mean,sigma)

variance    =sigma.^2;
value       =(exp((((real(x)-mean).^2)+...
    ((imag(x)-mean).^2))/(-2*variance)))/(2*pi*variance);
% File: NVD8_snrsim.m

clc;
clear all;
close all;
kpts    = 1024;             % FFT Block size
k       = 1:kpts;			% sample index vector
fd      = 2;				% desired signal frequency
fi      = 8;				% interference frequency
Ax = 80; Ayd = 20; Ayi =4;  % amplitudes
phase   = pi/4;             % phase shift
nstd    = 0.8;				% noise standard deviation
%=================
% program
%=================
theta   = 2*pi*k/kpts;			% phase vector
x       = Ax*sin(fd*theta);	    % desired signal
yd      = Ayd*sin(fd*theta-pi/4);% desired signal at receiver input
yi      = Ayi*sin(fi*theta);	% interference
noise   = nstd*randn(1,kpts);	% noise at receiver input
yy      = yd+yi+noise;			% receiver input
[gain,delay,px,py,rxy,rho,snrdb] = NVD8_snrmse(x,yy);
%=================
% display results
%=================
cpx = ['Gia tri cua Px la:  ',num2str(px),'.'];
cpy = ['Gia tri cua Py la:  ',num2str(py),'.'];
cgain = ['Gia tri cua do loi la:    ',num2str(gain),'.'];
cdel = ['Gia tri cua tre la:    ',num2str(delay),'.'];
csnrdb = ['Gia tri cua SNR la:  ',num2str(snrdb),' dB.'];
disp(' ')
disp(cpx)
disp(cpy)
disp(cgain)
disp(cdel)
disp(csnrdb)
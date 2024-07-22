% function NVD6_pllpre

clc;
close all;
clear all;	% be safe
%=======================================
% Setup parameter
%=======================================
disp(' ');
fdel    = input('   Nhap buoc nhay tan so dau vao Hz (40):      ');
fn      = input('   Nhap tan so dao dong tu do cua vong Hz (10):    ');
lambda  = input('   Nhap lambda (0.1):                          ');

disp(' ')
disp('Chap nhan gia tri mac dinh:    ');
disp('      zeta = 1/sqrt(2) = 0.707,');
disp('      fs = 200*fn, and');
disp('      tstop = 1');
dtype = input(' Chon y neu chap nhan; chon n thi phai nhap cac gia tri: > ','s');

if dtype == 'y'     % default values
    zeta1   = 1/sqrt(2);
    fs      = 200*fn;
    tstop   = 1;
else                % New values
    zeta1   = input('Nhap he so giam soc cua vong (zeta1):      ');
    fs      = input('Nhap tan so lay mau (fs) Hz:                ');
    tstop   = input('Nhap thoi gian mo phong (tstop):           ');
end

%=============================
% tstop   = 0.8;
% fs      = 5000;
%============================
npts    = fs*tstop+1;           % number of simulation points
t       = (0:(npts-1))/fs;      % default time vector
nsettle = fix(npts/10);         % set nsettle time as 0.1*npts
tsettle = nsettle/fs;           % set tsettle
%=============================
% establish the loop input frequency and phase deviations.
%=============================
fin     = [zeros(1,nsettle),fdel*ones(1,npts-nsettle)];
phin    = [zeros(1,nsettle),2*pi*fdel*t(1:(npts-nsettle))];
disp(' ') % insert blank line
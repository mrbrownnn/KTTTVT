% file: NVD14_threeray.m
clc;
clear all;
close all;
%=================================
% Default parameters
NN = 256;				% number of symbols
tb = 0.5;				% bit time
fs = 16;                % samples/symbol
ebn0db = [1:2:14];      % Eb/N0 vector

%===============================
% Establish QPSK signals
x   = NVD14_random_binary(NN,fs)+i*NVD14_random_binary(NN,fs);

%===============================
% Input powers and delays
Scennario = input('Chon kich ban kenh so 1-6 (theo bang 4.1): ');
if Scennario==1         % Validation: AWGN
    p0      = 1;
    p1      = 0;
    p2      = 0;
    delay   = 0;    
elseif Scennario==2     % Ricean flat fadinh
    p0      = 1;
    p1      = 0.2; 
    p2      = 0;
    delay   = 0;
elseif Scennario==3     % Ricean flat fadinh
    p0      = 1; 
    p1      = 0;
    p2      = 0.2;
    delay   = 0;
elseif Scennario==4     % Ricean frequency selective fadinh
    p0      = 1;
    p1      = 0;
    p2      = 0.2;
    delay   = 8;
elseif Scennario==5     % Rayleigh flat fadinh
    p0      = 0;
    p1      = 1; 
    p2      = 0.2;
    delay   = 0;
else                    % Rayleigh frequency selective fadinh
    p0      = 0;
    p1      = 1; 
    p2      = 0.2;
    delay   = 8;    
end

delay0 = 0; delay1 = 0; delay2 = delay;

%=================================================
% Set up the Complex Gaussian (Rayleigh) gains

gain1 = sqrt(p1)*abs(randn(1,NN) + i*randn(1,NN));
gain2 = sqrt(p2)*abs(randn(1,NN) + i*randn(1,NN));
for k = 1:NN
   for kk=1:fs
      index             = (k-1)*fs+kk;
      ggain1(1,index)   = gain1(1,k);
      ggain2(1,index)   = gain2(1,k);
   end
end

y1  = x;
for k=1:delay2 
   y2(1,k)              = y1(1,k)*sqrt(p0);
end
for k=(delay2+1):(NN*fs)
   y2(1,k)              = y1(1,k)*sqrt(p0) + ...
       y1(1,k-delay1)*ggain1(1,k)+...
       y1(1,k-delay2)*ggain2(1,k);
end
%======================================
% Matched filter
b = ones(1,fs); b = b/fs; a = 1;
y = filter(b,a,y2);
% End of simulation 
%========================================================
%=======================================
% Use the semianalytic BER estimator. The following sets 
% up the semi analytic estimator. Find the maximum magnitude 
% of the cross correlation and the corresponding lag.
[cor lags]      = NVD14_vxcorr(x,y);
[cmax nmax]     = max(abs(cor));
timelag         = lags(nmax);
theta           = angle(cor(nmax))
y               = y*exp(-i*theta); 		% derotate 
%----------------------------
% Noise BW calibration
%----------------------------
hh      = impz(b,a); 
ts      = 1/16;
nbw     = (fs/2)*sum(hh.^2);
%---------------------------
% Delay the input, and do BER estimation on the last 128 bits. 
% Use middle sample. Make sure the index does not exceed number 
% of input points. Eb should be computed at the receiver input. 
%----------------------------
index   = (10*fs+8:fs:(NN-10)*fs+8);
xx      = x(index);
yy      = y(index-timelag+1);
[n1 n2] = size(y2); ny2=n1*n2;
eb      = tb*sum(sum(abs(y2).^2))/ny2;
eb      = eb/2;
[peideal,pesystem] = NVD14_qpsk_berest(xx,yy,ebn0db,eb,tb,nbw);
%=======================================
figure
semilogy(ebn0db,peideal,'-o',ebn0db,pesystem,'r+-');
xlabel('E_b/N_0 (dB)','fontname','.Vntime','color','b','fontsize',12);
ylabel('X¸c suÊt lçi P_e','fontname','.Vntime','color','b','fontsize',14);
title(['M« pháng hiÖu n¨ng BER cho kÞch b¶n kªnh sè: ',...
    num2str(Scennario)],'fontname','.Vntime','color','b','fontsize',14)
axis([0 14 10^(-10) 1]);
legend('AWGN','Multipath');
grid
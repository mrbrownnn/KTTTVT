% File: NVD18_nlsat.m

% File: c18_nlsat.m

clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Frequently adjusted parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mode_select = input('Chon che do mo phong: 1 de phe chuan; 2 de nghien cuu anh huong tap am va phi tuyen    ')

if Mode_select==1
    %%%%%%%%%%%%%%%%%%%%%
    % carrier amplitudes
    %%%%%%%%%%%%%%%%%%%%%
    a1  = 1.0;
    a2  = 0.0; 
    a3  = 0.0;
    a4  = 0.0;
    a5  = 0.0;
    a6  = 0.0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TWT input backoff in dB
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    ibo =-20;    
else
    %%%%%%%%%%%%%%%%%%%%%
    % carrier amplitudes
    %%%%%%%%%%%%%%%%%%%%%
    a1  = 1.0;
    a2  = 1.0; 
    a3  = 1.0;
    a4  = 1.0;
    a5  = 0.0;
    a6  = 1.0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TWT input backoff in dB
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    ibo = -5;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Default parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R       = 1;        tsymbol = 1/R;				% symbol rate/time
df      = 1.244;								% carrier spacing
beta    = 0.2;									% beta
nsamples    = 64;								% samples / symbol
nsymbols    = 256;								% total symbols
ncorr       = 64;								% symbols for correlation
nstart      = 64;								% BER start (symbol #) 
ebn0db      = 0:1:8;							% ebno vector in dB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tb = tsymbol/2; 
fs = nsamples*R;
ts = 1/fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up frequency, delays, and phase offsets for the six FDM signals.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f1      = (df/2); 
f2      = f1+df;
f3      = f2+df;
f4      =-f1;
f5      =-f2;
f6      =-f3;
delay1  = 0; 
delay2  = 8;
delay3  = 16;
delay4  = 32;
delay5  = 40;
delay6  = 50;
phase1  = 0.0; 
phase2  = pi/64; 
phase3  = pi/32;
phase4  = pi/48;
phase5  = pi/16; 
phase6  = pi/40;
omega1  = 2*pi*f1;
omega2  = 2*pi*f2;
omega3  = 2*pi*f3;
omega4  = -omega1; 
omega5  = -omega2; 
omega6  = -omega3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin Simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carrier 1 is demodulated, so set it up first.
% Genereate the first QPSK impulse sequence and convert to NRZ.
% Note that in vector x, the first nsample/2-1 samples are zero.
%      
M       = 4;											% QPSK
[xin1]  = NVD18_mpsk_impulses(M,nsymbols,nsamples);    % QPSK impulse is middle sample
b       = ones(1,nsamples); 
x       = filter(b,1,xin1);       					% NRZ QPSK waveform samples 
nduration   = 8;									% duration of impw in symbols
[imp1,impw] = NVD18_sqrc_time(R,beta,nsamples,nduration);
txout1      = filter(imp1,1,xin1);					% SQRC filtered Chanel 1 signal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
% Generate 5 other QPSK impulse sequences 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xin2] = NVD18_mpsk_impulses(M,nsymbols,nsamples);
[xin3] = NVD18_mpsk_impulses(M,nsymbols,nsamples);
[xin4] = NVD18_mpsk_impulses(M,nsymbols,nsamples);
[xin5] = NVD18_mpsk_impulses(M,nsymbols,nsamples);
[xin6] = NVD18_mpsk_impulses(M,nsymbols,nsamples);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
% Stagger the inputs to make them unsynchronized to minimize envelope transitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
[xin2] = NVD18_delayr1(xin2,delay2);
[xin3] = NVD18_delayr1(xin3,delay3);
[xin4] = NVD18_delayr1(xin4,delay4);
[xin5] = NVD18_delayr1(xin5,delay5);
[xin6] = NVD18_delayr1(xin6,delay6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SQRC filter the five symbol waveforms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
txout2 = filter(imp1,1,xin2);
txout3 = filter(imp1,1,xin3);
txout4 = filter(imp1,1,xin4);
txout5 = filter(imp1,1,xin5);
txout6 = filter(imp1,1,xin6); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modulate all six carriers and generate txout
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KNN     = 1:nsymbols*nsamples;
txout1  = a1*txout1.*exp(i*omega1*KNN*ts)*exp(i*phase1);
txout2  = a2*txout2.*exp(i*omega2*KNN*ts)*exp(i*phase2);
txout3  = a3*txout3.*exp(i*omega3*KNN*ts)*exp(i*phase3);
txout4  = a4*txout4.*exp(i*omega4*KNN*ts)*exp(i*phase4);
txout5  = a5*txout5.*exp(i*omega5*KNN*ts)*exp(i*phase5);
txout6  = a6*txout6.*exp(i*omega6*KNN*ts)*exp(i*phase6);    
txout   = txout1+txout2+txout3+txout4+txout5+txout6; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input MUX filter (Normalized BW = 4.5 Hz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bmi ami]   = butter(4,4.5/(fs/2));
imuxout     = filter(bmi,ami,txout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TWTA Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('NVD18_twt_data1');
twtdata     = data;                             % Get TWTA Data
ampout      = NVD18_twt_model(imuxout,twtdata,ibo);   % TWT model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output MUX filter (Normalized BW = 4.5 Hz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bmo amo]   = butter(4,4.5/(fs/2));
omuxout     = filter(bmo,amo,ampout);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot (if desired) TWTA input and output PSD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
psdflag = 1;						            % omit psd calculation if desired
if psdflag==1
   nfft             = (nsymbols/2)*nsamples;nmax=nsymbols*nsamples;
   temp(1:nfft)     = imuxout(nfft+1:nmax);
   [logpsd,freq,ptotal,pmax]    = NVD18_log_psd(temp,4096,ts);   
   figure;
   subplot(2,1,1);
   plot(freq,logpsd);
   axis([-10 10 -40 0]);
   title('M�t �� ph� c�ng su�t PSD ��u v�o TWTA','fontname','.Vntime','color','b','fontsize',12);
   xlabel('T�n s� ','fontname','.Vntime','color','b','fontsize',12);
   ylabel('PSD','fontname','.Vntime','color','b','fontsize',12); 
   grid;
   
   temp(1:nfft) = ampout(nfft+1:nmax);
   [logpsd,freq,ptotal,pmax] = NVD18_log_psd(temp,4096,ts);
   subplot(2,1,2)
   plot(freq,logpsd);
   axis([-10 10 -40 0]);
   title('M�t �� ph� c�ng su�t PSD ��u ra TWTA','fontname','.Vntime','color','b','fontsize',12); 
   xlabel('T�n s�','fontname','.Vntime','color','b','fontsize',12);
   ylabel('PSD','fontname','.Vntime','color','b','fontsize',12);
   grid;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute eb at the input to the RX filter for a single carrier 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n1 n2]     = size(omuxout); nxx=n1*n2;
eb          = 0.5*tb*sum(sum(abs(omuxout).^2))/nxx;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
% Compute eb for one carrier only
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eb          = eb*(a1*a1)/(a1*a1+a2*a2+a3*a3+a4*a4+a5*a5+a6*a6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demodulate: Frequency shift the first carrier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ydemod      = omuxout.*exp(-i*omega1*KNN*ts);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% Receive SQRC filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nduration   = 16;
[imp2,impw] = NVD18_sqrc_freq_nosinc(R,beta,nsamples,nduration);
y           = filter(imp2,1,ydemod);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% Simulation is complete. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up BER estimator.
%
hh          = impz(imp2,1); ts=1/fs;
nbw         = (fs/2)*sum(abs(hh).^2)			% noise BW of the receiver
corlength   = ncorr*nsamples;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find the maximum magnitude of the cross correlation
% and find the lag corresponding to it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[cor lags]  = NVD18_vxcorr(x(1:corlength),y(1:corlength));
cmax        = max(max(abs(cor))); 
nmax        = find(abs(cor)==cmax);
timelag     = -lags(nmax);
corrmag     = cmax; 
theta       = -angle(cor(nmax));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y           = y*exp(-i*theta);					% derotate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay the input, and do BER estimation starting with nstart.
% Make sure the index does not exceed number of input points.
% eb is the true (real) signal power computed at the RX input.
% Decision time is the mid sample in each bit + timing_offset.
%
maxindex    = nsymbols*nsamples-(3*nsamples/2)-timelag;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Index is the array of pointers to mid points of each symbol
% Start BER estimation at nstart (skip the first few symbols).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index       = ((nstart)*nsamples+(nsamples/2):nsamples:maxindex);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timelag1    = timelag+(nsamples/2);        % middle sample decision statistics
xx          = x(index);      					% first symbol in x is first nsample/2
yy          = y(index+timelag1+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QPSK BER estimation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[peideal,pesystem]  = NVD18_qpsk_berest(xx,yy,ebn0db,eb,tb,nbw);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(1,2,1)
yscale              = 1.5*max(real(yy));
plot(yy,'+')
xlabel('Th�nh ph�n ��ng pha I','fontname','.Vntime','color','b','fontsize',12);
ylabel('Th�nh ph�n vu�ng pha Q','fontname','.Vntime','color','b','fontsize',12);
grid;
axis([-yscale yscale -yscale yscale])

subplot(1,2,2)
semilogy(ebn0db,peideal,'-.',ebn0db,pesystem); grid;
xlabel('E_b/N_0','fontname','.Vntime','color','b','fontsize',12);
ylabel('BER','fontname','.Vntime','color','b','fontsize',12);
legend('Ly tuong','He thong');
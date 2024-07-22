% NVD_MIMO_VBLAST_4QAM
% This Program compares V-BLAST/ZF/MAP, V-BLAST/ZF and ML.
% (M,N)=(4,12) and 4-QAM modulation.
% For each Eb/N0 value, we perform F iteration.

clear all;
close all;

% 4 point QAM is used
partition           =   [0];
xcodebook           =   [-1,1];
ycodebook           =   xcodebook;

for i1=1:size(xcodebook,2)
    for i2=1:size(xcodebook,2)
        constellation((i1-1)*2+i2)=xcodebook(i1)+j*ycodebook(i2); % constellation
    end
end

Eb  =   1;          % bit energy for this constellation

F   =   [1000, 1000, 1000, 1000, 5000, 10000, 100000];      % no of trials at a given noise level

M   =   4;         % No of transmitter antennas % Note 4
N   =   12;        % No of receiver antennas    % Note 12

Es      = 2*sum(xcodebook * xcodebook')/size(xcodebook,2);      % average symbol energy per antenna
Eb      = Es/(2*log2(size(xcodebook,2)));                       % transmitted bit energy per antenna
EbN0    = -12:2:0;
N0      = Eb./10.^(EbN0/10);    % Noise power
randn('state',12);              % initialize state of function for repeatability
rand('state',12);               % initialize state of function for repeatability
h               = waitbarqa(0,'M« pháng SER cho tõng gi¸ trÞ cña SNR');

for T   =1:length(EbN0)     % T loop; choose SNR level
    tic
    waitbarqa(T/length(EbN0));
    
    % V-BLAST/ZF algorithm
    er          =   0; % block error event counter
    bler(T)     =   0; % block error rate
    
    % V-BLAST/ZF/MAP algorithm
    zer         =   0; % block error event counter
    zbler(T)    =   0; % block error rate
    
    % ML rule
    mler        =   0;
    mlbler(T)   =   0;
    
    for f=1:F(T) % f loop
        a       =   randsrc(M,1,xcodebook)  +   j*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M) +   j*randn(N,M)) / sqrt(2);    % rayleigh fading
        v       =   (randn(N,1)+j*randn(N,1))* sqrt(N0(T)/2);
        r       =   H*a+v;
        
        %Copy r and H for ML Receiver
        mlH     =   H;
        mlr     =   r;
        
        %Copy r and H for V-BLAST/ZF/MAP Receiver
        zH      =   H;
        zr      =   r;
        
        % V-BLAST/ZF algorithm begins
        k       =   zeros(1,M);
        G       =   pinv(H);
        for i=1:M %i loop
            for J=1:M
                n(J)    =   (norm(G(J,:)))^2;
            end
            for t=1:i-1
                n(k(t)) =   Inf;
            end
            [ Y,I]      =   min(n);
            k(i)        =   I;
            w           =   G(I,:);
            y           =   w*r;
            [ o,n1]     =   quantiz(real(y),partition,xcodebook);
            [ o,n2]     =   quantiz(imag(y),partition,ycodebook);
            b(I)        =   n1+j*n2;
            r           =   r-b(I)*H(:,I);
            H(:,I)      =   0;
            G           =   pinv(H);
        end % end i loop
        
        if sum(abs(a-b.')) ~=0
            er          =   er+1;
        end % V-BLAST with ZF algorithm ends
        
        % V-BLAST/ZF/MAP algorithm starts
        G               =   pinv(zH);
        u               =   zeros(M,1);      % outputs in each channel
        p               =   zeros(1,M);
        zk              =   zeros(1,M);
        ahat            =   zeros(1,M);      % decisions in each channel
        
        for i=1:M % i loop
            u           =   G*zr;
            for J=1:M                
                if size(find(zk==J),2) == 0 % exclude J that have been decided earlier
                    [ o,n1]     =   quantiz(real(u(J)),partition,xcodebook);
                    [ o,n2]     =   quantiz(imag(u(J)),partition,ycodebook);
                    n(J)        =   N0(T)*(norm(G(J,:)))^2;
                    
                    % decision for J'th channel
                    ahat(J)     =   n1+j*n2;
                    
                    % calculate decision reliability probabilities
                    numerat     =   exp(-(1/n(J))*(abs(ahat(J)-u(J)))^2); % numerator of pij
                    denom       =   0; % denominator of pij
                    for i1=1:size(constellation,2)
                        denom   =   denom + exp(-(1/n(J))*(abs(constellation(i1)-u(J)))^2);
                    end
                    p(J)        =   numerat/denom;
                else % if J has already been processed
                    p(J)        =   -1;
                end
            end
            [ Y,I]              =   max(p);
            zk(i)               =   I;
            zb(I)               =   ahat(I);
            zr                  =   zr-zb(I)*zH(:,I);
            zH(:,I)             =   0;
            G                   =   pinv(zH);        
        end % end i loop
        
        if sum(abs(a-zb.'))~=0
            zer                 =   zer+1;
        end
        
        % ML algorithm begins
        c                       =   constellation;
        val                     =   Inf;
        for n=1:4
            for m=1:4
                for k=1:4
                    for g=1:4
                        d       =   [c(n),c(m),c(k),c(g) ]';
                        if norm(mlr-mlH*d)<val
                            mla =   [c(n),c(m),c(k),c(g) ]';
                            val =   norm(mlr-mlH*d);
                        end
                    end
                end
            end
        end
        
        if sum(abs(a-mla)) ~=0
            mler        =   mler+1;
        end

    end % end f loop
    
    bler(T)             =   (er) / F(T);    % for V-BLAST/ZF
    zbler(T)            =   (zer) / F(T);   % for V-BLAST/ZF/MAP
    mlbler(T)           =   (mler) / F(T);  % for ML
    toc
end % end T loop
close(h);
%==========================================================================
figure

semilogy(EbN0,mlbler,'-+r')
xlabel('Eb/No (dB)','fontsize',14); ylabel('SER','fontsize',18);
hold on;
semilogy(EbN0,zbler,'-db');
hold on;
semilogy(EbN0,bler,'-or');
hold off;
legend('ML','V-BLAST/ZF/MAP','V-BLAST/ZF');
grid on;

title(['M« pháng MIMO-VBLAST: §iÒu chÕ 4-QAM;  Sè Anten ph¸t=    ',...
    num2str(M),' ;     Sè Anten thu= ',num2str(N)],...
    'FontName','.VnTime','color','b','FontSize',18);
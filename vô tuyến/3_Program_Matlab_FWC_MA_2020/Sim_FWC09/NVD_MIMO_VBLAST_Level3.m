%  NVD_MIMO_VBLAST_Level3

% Test of V-BLAST/ZF, V-BLAST/LLSE, V-BLAST/ZF/MAP and V-BLAST/ZF/MAP
% algorithms with M transmitter and N receiver antennas. The modulation is 16-QAM.
% At each iteration, a new realization of H is used. T stands for SNR level and there are
% totally F iteration for each choice of T.

clear all;
close all;

% 16 point QAM is used
partition       =   [ -2,0,2 ];
xcodebook       =   [-3,-1,1,3 ];
ycodebook       =   xcodebook;

for i1=1:size(xcodebook,2)
    for i2=1:size(xcodebook,2)
        constellation((i1-1)*4+i2)  =   xcodebook(i1)+j*ycodebook(i2);
    end
end


M               =   8; % no of transmitter antennas % 8
N               =   12; % no of receiver antennas   % 12

Es          = 2*sum(xcodebook * xcodebook')/size(xcodebook,2); % average symbol energy per antenna
Eb          = Es/(2*log2(size(xcodebook,2))); % transmitted bit energy per antenna
EbN0        = -10:2:8;
N0          = Eb./10.^(EbN0/10); % Noise power

randn('state',12); % initialize state of function for repeatability
rand('state',12); % initialize state of function for repeatability

F               =   100000; % no of trials at a given noise level

h               =   waitbarqa(0,'M« pháng SER cho tõng gi¸ trÞ cña SNR');

for T=1:length(EbN0)            % T loop; choose SNR level
    tic
    waitbarqa(T/length(EbN0));
    
    % V-BLAST/ZF algorithm
    er      =   0; % block error event counter
    bler(T) =   0; % block error rate
    
    % V-BLAST/LLSE algorithm
    mer         =   0; % block error event counter
    mbler(T)    =   0; % block error rate
    
    % V-BLAST/ZF/MAP algorithm
    zer         =   0; % block error event counter
    zbler(T)    =   0; % block error rate
    %45:
    
    % V-BLAST/LLSE/MAP algorithm
    ser         =   0; % block error event counter
    sbler(T)    =   0; % block error rate
    
    for f=1:F
        a       =   randsrc(M,1,xcodebook)+j*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M)+j*randn(N,M)) / sqrt(2);
        v       =   (randn(N,1)+j*randn(N,1))* sqrt((N0(T)/2));
        r       =   H*a+v;
        %Copy r and H for V-BLAST/LLSE Receiver
        mH      =   H;
        mr      =   r;
        
        % 60: Copy r and H for V-BLAST/ZF/MAP Receiver
        zH      =   H;
        zr      =   r;
        
        %Copy r and H for V-BLAST/LLSE/MAP Receiver
        sH      =   H;
        sr      =   r;
        
        % 68: V-BLAST/ZF algorithm begins
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
        
        % 94: V-BLAST/LLSE Algorithm starts
        k       =   zeros(1,M);
        W       =   Es*mH'*pinv(Es*mH*mH'+N0(T)*eye(N)); % Es=ro/M
        
        for i=1:M
            for J=1:M
                n(J)    =   (norm(W(J,:)))^2;
            end
            for t=1:i-1
                n(k(t)) =   Inf;
            end
            [ Y,I]      =   min(n);
            k(i)        =   I;
            my          =   W(I,:)*mr;
            [ o,n1]     =   quantiz(real(my),partition,xcodebook);
            [ o,n2]     =   quantiz(imag(my),partition,ycodebook);
            mb(I)       =   n1+j*n2;
            mr          =   mr-mb(I)*mH(:,I);
            mH(:,I)     =   0;
            W           =   Es*mH'*pinv(Es*mH*mH'+N0(T)*eye(N));
        end % end i loop
        if sum(abs(a-mb.')) ~=0
            mer         =   mer+1;
        end % V-BLAST/LLSE Algorithm ends
        % 120:  V-BLAST/ZF/MAP algorithm starts
        G               =   pinv(zH);
        u               =   zeros(M,1); % outputs in each channel
        p               =   zeros(1,M);
        zk              =   zeros(1,M);
        ahat            =   zeros(1,M); % decisions in each channel
        
        for i=1:M % i loop
            u   = G*zr;
            for J=1:M
                if size(find(zk==J),2) == 0 % exclude J that have been decided earlier
                    [ o,n1]     =   quantiz(real(u(J)),partition,xcodebook);
                    [ o,n2]     =   quantiz(imag(u(J)),partition,ycodebook);
                    n(J)        =   N0(T)*(norm(G(J,:)))^2;
                    
                    % 134: % decision for J'th channel
                    ahat(J)     =   n1+j*n2;
                    % calculate decision reliability probabilities
                    numerat     =   exp(-(1/n(J))*(abs(ahat(J)-u(J)))^2); % numerator of pij
                    denom =0; % denominator of pij
                    for i1=1:size(constellation,2)
                        denom   =   denom + exp(-(1/n(J))*(abs(constellation(i1)-u(J)))^2);
                    end
                    p(J)        =   numerat/denom;
                else % if J has already been processed
                    p(J)        =   -1;
                end
            end
            [ Y,I]      =   max(p);
            zk(i)       =   I;
            zb(I)       =   ahat(I);
            zr          =   zr-zb(I)*zH(:,I);
            zH(:,I)     =   0;
            G           =   pinv(zH);
        end % end i loop
        if sum(abs(a-zb.')) ~=0
            zer         =   zer+1;
        end
        
        % 160: % V-BLAST/LLSE/MAP algorithm
        G               =   Es*sH'*pinv(Es*sH*sH'+N0(T)*eye(N));
        u               =   zeros(M,1); % outputs in each channel
        p               =   zeros(1,M);
        k               =   zeros(1,M);
        ahat            =   zeros(1,M); % decisions in each channel
        for i=1:M % i loop
            u = G*sr;
            for J=1:M
                if size(find(k==J),2) == 0 % exclude J that have been decided earlier
                    [ o,n1] =   quantiz(real(u(J)),partition,xcodebook);
                    [ o,n2] =   quantiz(imag(u(J)),partition,ycodebook);
                    n(J)    =   N0(T)*(norm(G(J,:)))^2;
                    % 174: % decision for J'th channel
                    ahat(J) =   n1+j*n2;
                    
                    % calculate reliability probabilities
                    % calculate decision reliability probabilities
                    numerat =   exp(-(1/n(J))*(abs(ahat(J)-u(J)))^2); % numerator of pij
                    denom   =   0; % denominator of pij
                    
                    for i1=1:size(constellation,2)
                        denom = denom + exp(-(1/n(J))*(abs(constellation(i1)-u(J)))^2);
                    end
                    p(J)    =   numerat/denom;
                else % if J has already been processed
                    p(J)    =   -1;
                end
            end
            [ Y,I]      =   max(p);
            k(i)        =   I;
            sb(I)       =   ahat(I);
            sr          =   sr-sb(I)*sH(:,I);
            sH(:,I)     =   0;
            G           =   Es*sH'*pinv(Es*sH*sH'+N0(T)*eye(N));
        end % end i loop
        if sum(abs(a-sb.')) ~=0
            ser         =   ser+1;
        end
    end % end f loop
    bler(T)         =   (er) / F;   % 'V-BLAST/ZF'
    mbler(T)        =   (mer) / F;  % 'V-BLAST/LLSE'
    zbler(T)        =   (zer) / F;  % 'V-BLAST/ZF/MAP'
    sbler(T)        =   (ser) / F;  % 'V-BLAST/LLSE/MAP'
    toc
end % end of T loop
save NVD_MIMO_VBLAST_Level3.mat;
close(h);
d   =   length(EbN0);
figure
semilogy(EbN0(1:d),bler(1:d),'-+r');  hold on;
semilogy(EbN0(1:d),mbler(1:d),'-db'); hold on;
semilogy(EbN0(1:d),zbler(1:d),'-or'); hold on;
semilogy(EbN0(1:d),sbler(1:d),'-*b'); hold off;

xlabel('Eb/No (dB)','FontSize',14); 
ylabel('SER','FontSize',18); 
title(['M« pháng MIMO-VBLAST: §iÒu chÕ 16QAM;  Sè Anten ph¸t=    ',...
    num2str(M),' ;     Sè Anten thu= ',num2str(N)],...
    'FontName','.VnTime','color','b','FontSize',18);
legend('V-BLAST/ZF','V-BLAST/LLSE','V-BLAST/ZF/MAP','V-BLAST/LLSE/MAP');
grid on;
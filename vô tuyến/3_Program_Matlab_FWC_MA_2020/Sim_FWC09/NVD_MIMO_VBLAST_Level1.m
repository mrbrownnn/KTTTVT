% NVD_MIMO_VBLAST_Level1
% SER of V-BLAST, ZF and LLSE receivers for (M,N)=(8,12) and 16-QAM modulation.
% For each Eb/N0 value, we perform 10.000 iteration.

clear all;
close all;

% 16 point QAM is used
partition       =   [ -2,0,2 ];
xcodebook       =   [-3,-1,1,3 ];
ycodebook       =   xcodebook;
M               =   8;                  % no of transmitter antennas 8 (2)
N               =   12;                 % no of receiver antennas   12 (4)

Es              =   2*sum(xcodebook * xcodebook')/size(xcodebook,2); % average symbol energy per antenna
Eb              =   Es/(2*log2(size(xcodebook,2))); % transmitted bit energy per antenna
EbN0            =   -10:2:20;
N0              =   Eb./10.^(EbN0/10); % Noise power

%17
F               =   1000; % no of trials at a given noise level

h               = waitbarqa(0,'M« pháng SER cho tõng gi¸ trÞ cña SNR');
for T=1:length(EbN0) % T loop; choose SNR level
    tic
    waitbarqa(T/length(EbN0));
    
    % 21 % V-BLAST/ZF algorithm
    er          =   0; % block error event counter
    bler(T)     =   0; % block error rate
    
    % 25: % V-BLAST/LLSE algorithm
    mer         =   0; % block error event counter
    mbler(T)    =   0; % block error rate
    
    % 29: % ZF algorithm
    zer         =   0; % block error event counter
    zbler(T)    =   0; % block error rate
    
    % 33: % LLSE algorithm
    ser         =   0; % block error event counter
    sbler(T)    =   0; % block error rate
    
    for f=1:F
        a       =   randsrc(M,1,xcodebook)+j*(randsrc(M,1,ycodebook));
        H       =   (randn(N,M)+j*randn(N,M)) / sqrt(2);     % rayleigh fading
        v       =   (randn(N,1)+j*randn(N,1))* sqrt(N0(T)/2);
        r       =   H*a+v;
        
        % 44: %Copy r and H for ZF Receiver
        zH      =   H;
        zr      =   r;
        
        % 48: %Copy r and H for LLSE Receiver
        sH      =   H;
        sr      =   r;
        
        % 52: %Copy r and H for VBLAST/LLSE
        mH      =   H;
        mr      =   r;
        % 56: % V-BLAST/ZF algorithm begins
        k       =   zeros(1,M);
        G       =   pinv(H); % Note W=H+
        
        for i=1:M %i loop
            for J=1:M
                n(J)    =   (norm(G(J,:)))^2;
            end
            
            for t=1:i-1
                n(k(t)) =   Inf;
            end
            
            [ Y,I]  =   min(n);
            k(i)    =   I;
            w       =   G(I,:);
            y       =   w*r;
            [ o,n1] =   quantiz(real(y),partition,xcodebook);
            [ o,n2] =   quantiz(imag(y),partition,ycodebook);
            b(I)    =   n1+j*n2;
            r       =   r-b(I)*H(:,I);
            H(:,I)  =   0;
            G       =   pinv(H);
            
        end % end i loop
        
        if sum(abs(a-b.')) ~=0
            er      =   er+1;
        end % V-BLAST with ZF algorithm ends
        
        % 81: % V-BLAST/LLSE Algorithm starts
        k           =   zeros(1,M);
        W           =   Es*mH'*pinv(Es*mH*mH'+N0(T)*eye(N)); % Es=ro/M
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
        
        % 106: % ZF Algorithm begins
        zb      =   zeros(1,M);
        zG      =   pinv(zH);           % Note FUNCTION pinv of MATLAB
        zy      =   zG*zr;
        for J=1:M
            [ o,n1(J)]      =   quantiz(real(zy(J)),partition,xcodebook);
            [ o,n2(J)]      =   quantiz(imag(zy(J)),partition,ycodebook);
        end

        zb(1:M)             =   n1(1:M)+j*n2(1:M);
        if sum(abs(a-zb.')) ~=0
            zer     =   zer+1;
        end % ZF Algorithm ends
        
        % 121: % LLSE Receiver
        sy          =   Es*sH'*pinv(Es*sH*sH'+N0(T)*eye(N))*sr;
        for J=1:M
            [ o,n1(J)]  =   quantiz(real(sy(J)),partition,xcodebook);
            [ o,n2(J)]  =   quantiz(imag(sy(J)),partition,ycodebook);
        end
        
        sb      =   n1+j*n2;
        if sum(abs(a-sb.')) ~=0
            ser =   ser+1;
        end
    end % end f loop
    
    bler(T)     =(er) / F;
    mbler(T)    =(mer) / F;
    zbler(T)    =(zer) / F;
    sbler(T)    =(ser) / F;
    toc
end % end of T loop
close(h);

figure
semilogy(EbN0,bler,'-dr'); hold on;
semilogy(EbN0,mbler,'-+b'); hold on;
semilogy(EbN0,zbler,'-*r'); hold on;
semilogy(EbN0,sbler,'-ob'); hold on;
xlabel('E_b/N_0 (dB)','FontSize',14);
ylabel('SER','FontSize',18);
title(['M« pháng MIMO-VBLAST:§iÒu chÕ 4-QAM;  Sè Anten ph¸t=    ',...
    num2str(M),' ;     Sè Anten thu= ',num2str(N)],...
    'FontName','.VnTime','color','b','FontSize',18);
legend('V-BLAST/ZF','V-BLAST/LLSE','ZF','LLSE');
grid on;

%==========================================================================
%=================== Sim_FWC_02_02_BER_BPSK_AWGN ==========================
%==========================================================================

clc; clear; close all;

%==========================================================================
SNRindB         = 0:1:9;           % signal to noise ratio dB
SNR             = 10.^(SNRindB/10);
Eb              = 1;                % energy per bit
sgma            = Eb./sqrt(2*SNR);  % sigam, standard deviation of noise is 
                                    % noisepower = sgma.^2
NumBits         = 10^7;             % Number of Bits
%==========================================================================
    % Theoretical error rate
        % Calculation for error Probability: Orthogonal
        % theo_Orthogonal_err_prb   = Qfunct(sqrt(SNR));
        theo_Orthogonal_err_prb     = 0.5 *erfc(sqrt(SNR/2));
        % Calculation for error Probability: Antipodal signal
        % theo_Antipodal_err_prb    = Qfunct(sqrt(2*SNR));
        theo_Antipodal_err_prb      = 0.5 *erfc(sqrt(SNR));    
%==========================================================================
    % Simulated error rate
h               = waitbar(0,'Please wait...');
% minTime = Inf;
tic
for j=1:length(SNR)
    tStart = tic;  % TIC, pair 2  
    waitbar(j/length(SNRindB));
    dsource_1           = 0.5*(sign(rand(1,NumBits)-0.5)+1);        
    numoferr    = 0;
    for i=1:NumBits
        % Generation of the binary data source and Pass AWGN channel
        temp = rand;        % Uniform radom variable over (0,1)
        if (temp<0.5),
            dsource(i)  =1;                 % With probability 1/2 source output is 1
            X           = sgma(j)*randn(1);
            Y           = -sqrt(Eb) + X;    % 1 with enrery is -sqrt(Eb); and pass AWGN channel
        else
            dsource(i)  = 0;                % With probability 1/2 source output is 0
            X           = sgma(j)*randn(1);
            Y           = sqrt(Eb) + X;     % 0 with enrery is +sqrt(Eb); and pass AWGN channel
        end        
        % detector follows/Decission
        if (Y<0)
            decis(i)   = 1;   % Decission is '1'
        else
            decis(i)   = 0;   % Decission is '0'
        end;
    end;
    numoferr        = sum(decis~=dsource);
    smld_err_prb(j) = numoferr/NumBits; % Probability of error estimate     
    %-------------------------
    tElapsed = toc(tStart);                     % TOC, pair 2  
%     minTime = min(tElapsed, minTime)
end;

SimTime = max(tElapsed)

close(h);

%==========================================================================
    save Sim_FWC_02_02_BER_BPSK_AWGN.mat;
%==========================================================================
h1 = figure(1);
% set(h1,'color','c');
set(h1,'Name','Sim_FWC_02_02_BER_BPSK_AWGN');
subplot(121)
    G = semilogy(SNRindB,smld_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
    set(G,'LineWidth',[1.5]);        
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('\bf X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',18);
    title(['M« pháng BER hÖ thèng BPSK trong kªnh AWGN; N_s_i_m_b_i_t = ',num2str(NumBits),' bits ',...
        ],'FontName','.VnTime','color','r','FontSize',14);
    LT = legend('   M« pháng ','   TÝnh to¸n');
    set(LT,'FontName','.VnTime','FontSize',16);    
    AX=gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 0.2]);
    grid on
    text(2,7e-5,'M« h×nh hãa vµ m« pháng',...
        'FontName','.VnTimeh','Color','b','FontSize',14);    
    text(0.5,min(theo_Antipodal_err_prb),'TÝnh chÝnh x¸c cña kÕt qu¶ m« pháng, x¸c nhËn vµ phª chuÈn m« h×nh',...
        'FontName','.VnTimeh','Color','r','FontSize',9.9)

subplot(122)
    G = semilogy(SNRindB,theo_Orthogonal_err_prb,'-vr');
    G = semilogy(SNRindB,theo_Orthogonal_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
    set(G,'LineWidth',[1.5]);        
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',18);
    title('So s¸nh x¸c suÊt lçi bit hÖ thèng BPSK trùc giao vµ ®èi cùc trong kªnh AWGN',...
        'FontName','.VnTime','color','b','FontSize',15);
    LT = legend('   Trùc giao','    §èi cùc');
    set(LT,'FontName','.VnTime','FontSize',16,'fontweight','normal','fontAngle','normal');
    AX = gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 0.2]);
    grid on;
    text(2,7e-5,'TÝnh to¸n so s¸nh hiÖu n¨ng','FontName','.VnTimeh','Color','b','FontSize',14);
    
    
%==========================================================================
% Measure multiple time spans simultaneously using two pairs of tic/toc calls. To do this,
% measure the minimum and average time to compute a summation of Bessel functions:

% REPS = 1000;   minTime = Inf;   nsum = 10;
% tic;  % TIC, pair 1
% 
% for i=1:REPS
%    tStart = tic;  % TIC, pair 2  
%    total = 0;
%    for j=1:nsum 
%       total = total + besselj(j,REPS);
%    end
% 
%    tElapsed = toc(tStart);  % TOC, pair 2  
%    minTime = min(tElapsed, minTime);
% end
% averageTime = toc/REPS;  % TOC, pair 1  
%==========================================================================
%================ Sim_MA_04_DS_BPSK_CDMA_Jamer ============================
%===========  To simulate a BPSK/DS-SS communication system ===============
%==========================================================================

clc;
clear all;
close all;

%--------------------------------------------------------------------------

% A PN sequence
    g       = [2 5];
    code1   = MA_04_png(g);       % code1

% Another PN sequence
    g       = [2 3 4 5];
    code2   = MA_04_png(g);       % code2
    Nc      = length(code1);    % PN code length (Number of chips per message bit)
    b       = 1; 
    M       = 2^b;

% Bit/Symbol/Chip time     
    Tb  = 1; 
    Ts  = b*Tb; 
    Tc  = Tb/Nc;
    
% Sampling Period (subinterval in Tc)    
    N   = 8; 
    T   = Tc/N;
    
% Number of samples in one symbol    
    NNc     = N*Nc;
    Ns      = b*NNc;
    
% Energy of signal waveform   
    Es      = 2; 
    sqEs    = sqrt(Es);
    
% Set of symbols    
    ss      = [0 1]; 
    wc      = 4*Nc*pi/Tb;  
    t       = [0:Ns-1]*T;  
    s2sT    = sqrt(2/Ts);
    
% Caculation for BER
SNRbdBt     = 0:1:10;
pobet       = MA_04_prob_error(SNRbdBt,'PSK',b,'BER');

% Simulation for BER
SNRbdBs     = 1:10;     % note [6 7]; 
PJ          = 0.01;    % 0.01 Jam power
MaxIter     = 20000;    % Note 20000

for i_DS = 1:2                  % DS coding or not    
    
    if i_DS==1, 
        code1s  = ones(1,Ns); % No DS 
    else
        % data_sig    = ones(N,1);
        % PN1         = 2*code1-1;
        % code1s  = reshape(data_sig*PN1,1,Ns); % PN-DS coding        
        code1s  = reshape(ones(N,1)*(2*code1-1),1,Ns); % PN-DS coding
    end
    %----------------------------------
    for m =1:M % (Possibly PN-coded) BPSK signal waveforms
        sw(m,:) = sqEs*s2sT*(ss(m)*2-1)*code1s.*cos(wc*t);  % 0/1 -> -1/1
    end
    
    suT = s2sT*T*[code1s.*cos(wc*t); -code1s.*sin(wc*t)];
    
    %----------------------------------
    for i_SNR=1:length(SNRbdBs)     % Range of SNRdB
        
        SNRbdB  = SNRbdBs(i_SNR);
        SNRb    = 10^(SNRbdB/10);
        sigma2  = (Es/b)/SNRb;
        sgmsT   = sqrt(sigma2/T);
        Jamming_amp = sqrt(PJ/T);
        y           = zeros(1,Ns);  % Buffer size amounting to 1 symbol time
        nobe        = 0;            % Number of bit errors        
        
        %-----------------------------
        
        for k=1:MaxIter            
            
            %transmitted signal       
            i = ceil(rand*M); 
            s = ss(i);
            for m1=1:b*Nc       % Operation per symbol interval Ts
                for m =1:N      % Operation per chip interval Tc
                    mi          = (m1-1)*N+m; 
                    tmp         = wc*((k-1)*Ns+mi-1)*T; 
                    intfrnc     = cos(tmp);                     % Interference
                    rNs         = sw(i,mi) +sgmsT*randn + Jamming_amp*intfrnc;
                    y(1,:)      = [y(1,2:Ns) suT(1,mi)*rNs];    % Inside correlator  
                end
            end
            ycsk    = sum(y');  % Sampled correlator output - DTR input
            
            % Detector(DTR)
            lmin    = (ycsk(1)>0)+1;
            D       = ss(lmin);
            nobe    = nobe+sum(s~=D); 
            if nobe>100, 
                break; 
            end
        end
        pobe(i_DS,i_SNR) = nobe/(k*b);
    end
end

save Sim_MA_04_DS_BPSK_CDMA_Jamer.mat;

    fprintf('\n SNRbdB= %5.2f   %5.2f (Jamming power=%5.2f)', SNRbdBs,PJ);
    fprintf('\n    BER= %6.4f  %6.4f (Without PN coding)', pobe(1,:));
    fprintf('\n    BER= %6.4f  %6.4f (With PN coding)\n', pobe(2,:));

figure(1)
    G = semilogy(SNRbdBt,pobet,'-.d',SNRbdBs,pobe(1,:),'-ob',SNRbdBs,pobe(2,:),'-^');
    set(G,'LineWidth',1.5);
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('\bf X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',18);    
    AX  = gca;
    set(AX,'FontSize',14);
    T = title(['M« pháng x¸c suÊt lçi hÖ thèng DS-CDMA/BPSK; C«ng suÊt nhiÔu ph¸ = ',num2str(PJ),' W',...
        '; N_S_I_M =',num2str(MaxIter),' lÇn']);        
    set(T,'FontName','.VnTime','color','b','FontSize',16');
    LT = legend('TÝnh to¸n theo hµm Q(x)','M« pháng kh«ng dïng m· PN','M« pháng dïng m· PN');
    set(LT,'FontName','.VnTime','FontSize',14');
    grid on;
    
%     text(2,7e-5,'M« h×nh hãa vµ m« pháng',...
%         'FontName','.VnTimeh','Color','b','FontSize',14);    
%     text(0.5,min(theo_Antipodal_err_prb),'TÝnh chÝnh x¸c cña kÕt qu¶ m« pháng, x¸c nhËn vµ phª chuÈn m« h×nh',...
%         'FontName','.VnTimeh','Color','r','FontSize',9.9)
%==========================================================================
%===================  Sim_MA_05_SER_DS_CDMA ===============================
%============= Simulation program to realize DS-CDMA system ===============
%==========================================================================

clc;
clear all;
close all;

%**************************** Preparation part ****************************

sr   = 256000.0;                      % symbol rate
ml   = 2;                             % number of modulation levels:                            %  NOTE
                                      % 2 for QPSK; 4 for 16QAM
br   = sr * ml;                       % bit rate
nd   = 100;                           % number of symbol    % 100                         
ebn0 = 0:3:15;                        % Eb/No [dB]

%************************** Filter initialization *************************

irfn   =  21;                              % number of filter taps
IPOINT =  8;                               % number of oversample
alfs   =  0.5;                             % roll off factor
[xh]   = MA_05_hrollfcoef(irfn,IPOINT,sr,alfs,1);% T FILTER FUNCTION
[xh2]  = MA_05_hrollfcoef(irfn,IPOINT,sr,alfs,0);% R FILTER FUNCTION

%********************** Spreading code initialization *********************

user  = [1 4 7];                       % number of users
seq   = 1;                             % 1:M-sequence  2:Gold  3:Orthogonal Gold                %  NOTE
stage = 3;                             % number of stages
ptap1 = [1 3];                         % position of taps for 1st
ptap2 = [2 3];                         % position of taps for 2nd
regi1 = [1 1 1];                       % initial value of register for 1st
regi2 = [1 1 1];                       % initial value of register for 2nd

%**************************************************************************
%**************************** START SIMULATION ****************************
%**************************************************************************

nloop   = 1000;                                    % simulation number of times                 % 1000
noe2    = zeros (length(user),length(ebn0));       % noe2(jj,j) = sum(sum(abs(data-demodata)));
nod2    = zeros (1,length(user));
noe     = zeros (length(user),length(ebn0));       % noe(jj,j)  = noe(jj,j) + noe2(jj,j);
nod     = zeros (length(user),length(ebn0));       % nod(jj,j)  = nod(jj,j) + nod2(jj,j);
ber     = zeros (length(user),length(ebn0));       % ber(jj,j)

for jj = 1:length(user)
    
    %******************** Generation of the spreading code ****************
    switch seq
        case 1      % M-sequence
            code = MA_05_mseq(stage,ptap1,regi1,user(jj));
        case 2      % Gold sequence
            m1   = MA_05_mseq(stage,ptap1,regi1);
            m2   = MA_05_mseq(stage,ptap2,regi2);
            code = MA_05_goldseq(m1,m2,user(jj));
        case 3      % Orthogonal Gold sequence
            m1   = MA_05_mseq(stage,ptap1,regi1);
            m2   = MA_05_mseq(stage,ptap2,regi2);
            code = [MA_05_goldseq(m1,m2,user(jj)),zeros(user(jj),1)];
    end
    
    code = code * 2 - 1;
    clen = length(code);
    
    %************************** Fading initialization *********************
    
    rfade  = 1;                           % Rayleigh fading 0:nothing 1:consider                %  NOTE
    itau   = [0,8];                       % delay time
    dlvl1  = [0.0,40.0];                  % attenuation level
    n0     = [6,7];                       % number of waves to generate fading
    th1    = [0.0,0.0];                   % initial Phase of delayed wave
    itnd1  = [3001,4004];                 % set fading counter
    now1   = 2;                           % number of directwave + delayed wave
    tstp   = 1 / sr / IPOINT / clen;      % time resolution
    fd     = 160;                         % doppler frequency [Hz]
    flat   = 1;                           % flat Rayleigh environment
    itndel = nd * IPOINT * clen * 30;     % number of fading counter to skip
    
    for j=1:length(ebn0)
        
        data        = [];
        demodata    = [];
        
        for ii=1:nloop   
            
            %************************ Transmitter *************************
            data = rand(user(jj),nd*ml) > 0.5;
            [ich, qch]  = MA_05_qpskmod(data,user(jj),nd,ml);     % QPSK modulation
            [ich1,qch1] = MA_05_spread(ich,qch,code);             % spreading
            [ich2,qch2] = MA_05_compoversamp2(ich1,qch1,IPOINT);  % over sampling
            [ich3,qch3] = MA_05_compconv2(ich2,qch2,xh);          % filter
            
            if user(jj) == 1                                % transmission
                ich4 = ich3;
                qch4 = qch3;
            else
                ich4 = sum(ich3);
                qch4 = sum(qch3);
            end
            
            %*********************** Fading channel ***********************
            
            if rfade == 0
                ich5 = ich4;
                qch5 = qch4;
            else
                [ich5,qch5] = MA_05_sefade(ich4,qch4,itau,... % fading channel
                    dlvl1,th1,n0,itnd1,now1,length(ich4),tstp,fd,flat);
                itnd1 = itnd1 + itndel;
            end
            
            %************************* Receiver ***************************
            
            spow    = sum(rot90(ich3.^2 + qch3.^2)) / nd;     % attenuation Calculation
            attn    = sqrt(0.5 * spow * sr / br * 10^(-ebn0(j)/10));
            
            [ich6,qch6] = MA_05_comb2(ich5,qch5,attn);              % Add White Gaussian Noise (AWGN)
            [ich7,qch7] = MA_05_compconv2(ich6,qch6,xh2);           % filter
            
            sampl = irfn * IPOINT + 1;
            ich8  = ich7(:,sampl:IPOINT:IPOINT*nd*clen+sampl-1);
            qch8  = qch7(:,sampl:IPOINT:IPOINT*nd*clen+sampl-1);
            
            [ich9, qch9]    = MA_05_despread(ich8,qch8,code);             % despreading
            demodata        = MA_05_qpskdemod(ich9,qch9,user(jj),nd,ml);  % QPSK demodulation
            
            %*******************Bit Error Rate (BER) **********************
            
            noe2(jj,j) = sum(sum(abs(data-demodata)));
            nod2(jj)   = user(jj) * nd * ml;
            noe(jj,j)  = noe(jj,j) + noe2(jj,j);
            nod(jj,j)  = nod(jj,j) + nod2(jj);    
            ber(jj,j)  = noe(jj,j)/nod(jj,j); % BER of User [1 4 7], 3 User
            % 1:M-sequence; 2:Gold; 3:Orthogonal Gold
            
        end % number of loop: index is ii
    end % number of ebn0 index is j
end % number of user index is jj

%==========================================================================
if rfade==0  % AWGN
    if seq ==1      % M-sequence
        save sim_ds_cdma_Mseq_awgn.mat;        
    elseif seq ==2  % Gold
        save sim_ds_cdma_Goldseq_awgn.mat;        
    else            % Orthogonal Gold
        save sim_ds_cdma_OrthGoldseq_awgn.mat;
    end    
else        % Fading channel: Rayleigh    
    if seq ==1      % M-sequence
        save sim_ds_cdma_Mseq_rayleigh.mat;
    elseif seq ==2  % Gold
        save sim_ds_cdma_Goldseq_rayleigh.mat;
    else            % Orthogonal Gold
        save sim_ds_cdma_OrthGoldseq_rayleigh.mat;
    end    
end

num_fig =1;
Presentation_Sim_MA_05(ber,ebn0,rfade,seq,num_fig);

%==========================================================================
% figure(1)
% %%%%-----------------------------------------------------------------------
% %%%%-----------------------------------------------------------------------
% semilogy(ebn0,ber(1,:),'-s',ebn0,ber(2,:),'-h',ebn0,ber(3,:),'-o','LineWidth',3);
% xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',14);
% ylabel('X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',14);
% 
% if rfade==0     % AWGN
%     if seq ==1
%         title(['M« pháng BER cho DS-SS-CDMA/QPSK; trong kªnh AWGN; dïng m· M; Num_U_s_e_r= ',num2str(user)],...
%             'FontName','.VnTime','color','b','FontSize',12);
%     elseif seq ==2
%         title(['M« pháng BER cho DS-SS-CDMA/QPSK; trong kªnh AWGN; dïng m· Gold; Num_U_s_e_r= ',num2str(user)],...
%             'FontName','.VnTime','color','b','FontSize',12);        
%     else
%         title(['M« pháng BER cho DS-SS-CDMA/QPSK; trong kªnh AWGN; dïng m· Gold trùc giao; Num_U_s_e_r= ',num2str(user)],...
%             'FontName','.VnTime','color','b','FontSize',12);        
%     end
%     k = legend('Sè ng­êi dïng =1','Sè ng­êi dïng =4','Sè ng­êi dïng = 7');
% else            % Fading channel: Rayleigh
%     if seq ==1
%         title(['M« pháng BER cho DS-SS-CDMA/QPSK;trong kªnh pha®inh Rayleigh; dïng m· M; Num_U_s_e_r= ',num2str(user)],...
%             'FontName','.VnTime','color','b','FontSize',12);
%     elseif seq ==2
%         title(['M« pháng BER cho DS-SS-CDMA/QPSK;trong kªnh pha®inh Rayleigh; dïng m· Gold; Num_U_s_e_r= ',num2str(user)],...
%             'FontName','.VnTime','color','b','FontSize',12);        
%     else
%         title(['M« pháng BER cho DS-SS-CDMA/QPSK;trong kªnh pha®inh Rayleigh; dïng m· Gold trùc giao; Num_U_s_e_r= ',num2str(user)],...
%             'FontName','.VnTime','color','b','FontSize',12);        
%     end
%     k = legend('Sè ng­êi dïng =1','Sè ng­êi dïng =4','Sè ng­êi dïng = 7');
% end
% set(k,'FontName','.VnTime','FontSize',16');
% grid on;
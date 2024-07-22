%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================

clc;
clear all;
close all;

%==========================================================================
SNRindB         = 0:1:9;           % signal to noise ratio dB
SNR             = 10.^(SNRindB/10);
Eb              = 1;                % energy per bit
sgma            = Eb./sqrt(2*SNR);  % sigam, standard deviation of noise is 
                                    % noisepower = sgma.^2
Block_size      = 10^2;
Num_Block       = 200;
NumBits         = Num_Block*Block_size; % Number of Bits

mode_Sim        = 2;
Codding_Type    = 2;

if mode_Sim ==2
    if Codding_Type == 1
        k0      = 1;
        G       = [1 1 1; 1 0 1];
        GT      = 1;
    elseif Codding_Type == 2        
        k0      = 1;
        G       = [1 1 1 1 0 0 1; 1 0 1 1 0 1 0];
        GT      = 2;
    else
        k0      = 2;
        G       = [0 0 1 0 1 0 0 1;0 0 0 0 0 0 0 1;1 0 0 0 0 0 0 1];
        GT      = 3;
    end
end
%==========================================================================
% Theoretical error rate
% Calculation for error Probability: Antipodal signal same as SIMULATION 
theo_Antipodal_err_prb      = 0.5 *erfc(sqrt(SNR));
%==========================================================================
% Simulated error rate
h   = waitbar(0,'Please wait...');
tic
for j=1:length(SNR)
    Start_sim = tic;
    waitbar(j/length(SNRindB));
    numoferr_tot        = 0;
    for k=1:Num_Block
        % Generation of the binary data Block
        dsource_1           = 0.5*(sign(rand(1,Block_size)-0.5)+1);        
        %------------------------------------------------------------------
        if mode_Sim ==2
            dsource             = FWC_COV_Encoder(G,k0,dsource_1);            
        else
            dsource             = dsource_1;            
        end
        %------------------------------------------------------------------
        numoferr_block      = 0;        
        for i = 1:length(dsource)
            %  Pass AWGN channel            
            if dsource(i)==1,
                X           = sgma(j)*randn(1);
                Y           = -sqrt(Eb) + X;
            else
                X           = sgma(j)*randn(1);
                Y           = sqrt(Eb) + X;
            end
            % detector follows/Decission
            if (Y<0)
                decis(i)   = 1;   % Decission is '1'
            else
                decis(i)   = 0;   % Decission is '0'
            end;
        end; % Block_size        
        %------------------------------------------------------------------
        if mode_Sim==2
            decoder_output  = FWC_COV_Dencoder(G,k0,decis);            
        else
            decoder_output  =  decis;
        end
        %------------------------------------------------------------------        
        numoferr_tot    = sum(decoder_output~=dsource_1)+ numoferr_tot;
    end
    smld_err_prb(j)     = numoferr_tot/NumBits;         % Probability of all error block
    Sim_Elapsed = toc(Start_sim);                     % TOC, pair 2  
end
close(h);
SimTime = max(Sim_Elapsed);
%==========================================================================
if mode_Sim==1
    save Sim_FWC_02_02_BER_BPSK_AWGN_NoCC.mat;
else
    if Codding_Type==1
        save Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G1.mat;
    elseif Codding_Type==2
        save Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G2.mat;
    else
        save Sim_FWC_02_02_BER_BPSK_AWGN_NCC_G3.mat;
    end
end

h1 = figure(1);
set(h1,'Name',' Programmed by Nguyen Viet Dam PTIT: 07-2007');    
    G = semilogy(SNRindB,smld_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
    set(G,'LineWidth',1.5);
    AX = gca;
    set(AX,'FontSize',14);
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('X�c su�t l�i Pe','FontName','.VnTime','color','b','FontSize',18);
    grid on;
    
if mode_Sim ==2
    title(['M� ph�ng BER h� th�ng BPSK trong k�nh AWGN c� v� kh�ng c� m� h�a k�nh; S� bit m� ph�ng N_b_i_t= ',...
        num2str(NumBits),' bits '],'FontName','.VnTime','color','b','fontweight','normal','FontSize',16);
    LT = legend(['BER: \it Kh�ng m� h�a k�nh'],['BER: \it C� m� h�a k�nh, \bf G', num2str(GT)]);
    set(LT,'fontname','.vntime','fontsize',18);
    AX=gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 1]);
    grid on
    
    text(1,7e-5,'M� h�nh h�a v� m� ph�ng hi�u n�ng c�c b� m� h�a k�nh',...
        'FontName','.VnTimeh','Color','r','FontSize',14);    
    text(0.5,min(theo_Antipodal_err_prb),'T�nh ch�nh x�c c�a k�t qu� m� ph�ng, x�c nh�n v� ph� chu�n m� h�nh',...
        'FontName','.VnUniverseH','Color','b','FontSize',22);
else % NoCC
    title(['M� ph�ng BER h� th�ng BPSK trong k�nh AWGN; S� bit m� ph�ng N_b_i_t= ',num2str(NumBits),' bits ',...
        ],'FontName','.VnTime','color','b','FontSize',16);
    LT = legend('M� ph�ng','T�nh to�n');
    set(LT,'fontname','.vntime','fontsize',18);
    AX=gca;
    set(AX,'FontSize',14);
    axis([min(SNRindB) max(SNRindB), 1e-5 1]);
    grid on
    
    text(2.5,7e-5,'M� h�nh h�a v� m� ph�ng',...
        'FontName','.VnTimeh','Color','r','FontSize',14);    
    text(0.5,min(theo_Antipodal_err_prb),'T�nh ch�nh x�c c�a k�t qu� m� ph�ng, x�c nh�n v� ph� chu�n m� h�nh',...
        'FontName','.VnUniverseH','Color','b','FontSize',22);    
end


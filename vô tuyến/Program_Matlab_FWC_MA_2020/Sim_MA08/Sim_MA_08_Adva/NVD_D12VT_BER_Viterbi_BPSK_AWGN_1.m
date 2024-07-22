% function y = NVD_D12VT_BER_Viterbi_BPSK_AWGN_1

clc;
clear all;
close all;

%==========================================================================
SNRindB         = 0:1:9;           % signal to noise ratio dB
SNR             = 10.^(SNRindB/10);
Eb              = 1;                % energy per bit
sgma            = Eb./sqrt(2*SNR);  % sigam, standard deviation of noise is 
                                    % noisepower = sgma.^2
Block_size      = 50;
Num_Block       = 10000;
NumBits         = Num_Block*Block_size; % Number of Bits


k0      = 1;
G       = [1 1 1 1 0 0 1;1 0 1 1 0 1 0];

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
for j=1:length(SNR)
    waitbar(j/length(SNRindB));
    numoferr_tot        = 0;
    for k=1:Num_Block
        % Generation of the binary data Block
        dsource_1           = 0.5*(sign(rand(1,Block_size)-0.5)+1);
        dsource             = COV_Encoder(G,k0,dsource_1);
        numoferr_block  = 0;
        for i = 1:Block_size
            %  Pass AWGN channel            
            if dsource(i)==1,
                X           = sgma(j)*randn(1);
                Y           = -sqrt(Eb) + X;    % 1 with enrery is -sqrt(Eb); and pass AWGN channel
            else
                X           = sgma(j)*randn(1);
                Y           = sqrt(Eb) + X;     % 0 with enrery is +sqrt(Eb); and pass AWGN channel
            end
            % detector follows/Decission
            if (Y<0)
                decis(i)   = 1;   % Decission is '1'
            else
                decis(i)   = 0;   % Decission is '0'
            end;
            % Comparision for determine error and conter error
            if (decis(i)~=dsource(i))           % if it is an error, increase the error counter
                numoferr_block    = numoferr_block+1;
            end;            
        end; % Block_size
        decoder_output  = COV_Dencoder(G,k0,decis);
%         numoferr_tot    = numoferr_tot + numoferr_block;    % Probability of each error block
    end; % Num_Block
%     smld_err_prb(j)     = numoferr_tot/NumBits;             % Probability of all error block
end;
close(h);
%==========================================================================
% h1 = figure(1);
% set(h1,'color','c');
% set(h1,'Name',' Programmed by Nguyen Viet Dam PTIT');
% subplot(122)
%     G = semilogy(SNRindB,theo_Orthogonal_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
%     set(G,'LineWidth',[2.5]);        
%     xlabel('TØ sè tÝn hiÖu trªn t¹p ©m SNR [dB]','FontName','.VnTime','color','b','FontSize',12);
%     ylabel('X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',14);
%     title('Calculation/Comparision for error Probability: Orthogonal/Antipodal signal','FontName','.VnTime','color','b','FontSize',12);
%     legend('P_e_-_O_r_t_h_o_g_o_n_a_l','P_e_-_A_n_t_i_p_o_d_a_l');
%     grid on
% subplot(121)
%     G = semilogy(SNRindB,smld_err_prb,'-vr',SNRindB,theo_Antipodal_err_prb,'-ob');
%     set(G,'LineWidth',[2.5]);        
%     xlabel('TØ sè tÝn hiÖu trªn t¹p ©m SNR[dB]','FontName','.VnTime','color','b','FontSize',12);
%     ylabel('X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',14);
%     title(['M« pháng BER hÖ thèng BPSK trong kªnh AWGN; Sè bit m« pháng = ',num2str(NumBits),' bits ',...
%         ],'FontName','.VnTime','color','r','FontSize',12);
%     legend('Simulation','Calculation');
%     grid on
    

% % function output = COV_Encoder_Decoder
% 
% % G= input('Nhap ma tran G cho giai ma [1 0 1;1 1 1] =   ');
% % k= input('Nhap so dau vao dong thoi k cho bo giai ma = ');
% % channel_output= input('Nhap chuoi bit vao cho bo giai ma [0 1 1 0 1 1 1 1 0 1 0 0 0 1] = ');
% 
% %kiem tra de biet neu don cac bit 0 them la can thiet.
% k0      = 1;        %input('	Nhap k cho bo ma hoa                    = ');
% % G       = [1 0 1;1 1 1];         %input('	Nhap ma tran G cho bo ma hoa            = ');
% 
% G       = [1 1 1 1 0 0 1;1 0 1 1 0 1 0];         %input('	Nhap ma tran G cho bo ma hoa            = ');
% 
% 
% % iput    = [1 1 0 1 1 0 1 1 0 0 1 1 0 0 1 1 1 1 0 0 1];         %input('   Nhap chuoi bit thong tin vao bo ma hoa  = '); size(iput)=1x21
% 
% InfoBitLen  = 20;
% iput        = randint(1,InfoBitLen,2);
% 
% d_Haming    = 30; % ?
% 
% 
% %%%===============================
% %%% Eencoder ====================
% %%%===============================
% Encoder_output = COV_Encoder(G,k0,iput);
% 
% %%%===============================
% %%%% Pass channel
% %%%===============================
% 
% error_vector                = zeros(1,length(Encoder_output));
% MF1                         = round(length(Encoder_output)/d_Haming);
% error_index                 = MF1:MF1/2:length(Encoder_output);
% error_vector(error_index)   = 1; % same size of iput size(error_vector)=size(Encoder_output);
% channel_out                 = xor(Encoder_output,error_vector);
% 
% % %================================================================
% % error_vector                = ceil(randn(1,length(Encoder_output)))>0.1;
% % channel_out                 = xor(Encoder_output,error_vector);
% 
% 
% 
% % channel_out =   Encoder_output;
% 
% %%%===============================
% %%% De_encoder ===================
% %%%===============================
% decoder_output = COV_Dencoder(G,k0,channel_out);
% 
% [decoder_output,survivor_state,comulated_metric] = COV_Dencoder(G,k0,channel_out);
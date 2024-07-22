%==========================================================================
%=============  Sim_FWC_03_01_COV_Encoder_Decoder   =======================
%==========================================================================
% Bubprograme: NVD_COV_Dencoder(G,k0,channel_out)
% Subprograme: NVD_COV_Dencoder(G,k0,channel_out)


%--------------------------------------------------------------------------
    clc; clear; close all;
%--------------------------------------------------------------------------
% G = input('Nhap ma tran G cho giai ma [1 0 1;1 1 1] =   ');
% k = input('Nhap so dau vao dong thoi k cho bo giai ma = ');
% channel_output= input('Nhap chuoi bit vao cho bo giai ma [0 1 1 0 1 1 1 1 0 1 0 0 0 1] = ');

%kiem tra de biet neu don cac bit 0 them la can thiet.
k0      = 1;        %input('	Nhap k cho bo ma hoa                    = ');
% G       = [1 0 1;1 1 1];         %input('	Nhap ma tran G cho bo ma hoa            = ');

G       = [1 1 1 1 0 0 1;1 0 1 1 0 1 0];         %input('	Nhap ma tran G cho bo ma hoa            = ');


% iput    = [1 1 0 1 1 0 1 1 0 0 1 1 0 0 1 1 1 1 0 0 1];         %input('   Nhap chuoi bit thong tin vao bo ma hoa  = '); size(iput)=1x21

InfoBitLen  = 20;
iput        = randint(1,InfoBitLen,2);  % RANDI
d_Haming    = 30; % ?
%%%===============================
%%% Eencoder ====================
%%%===============================
Encoder_output = FWC_COV_Encoder(G,k0,iput);
%%%===============================
%%%% Pass channel
%%%===============================
% error_vector                = zeros(1,length(Encoder_output));
MF1                         = round(length(Encoder_output)/d_Haming);
error_index                 = MF1:MF1/2:length(Encoder_output);
error_vector(error_index)   = 1; % same size of iput size(error_vector)=size(Encoder_output);
channel_out                 = xor(Encoder_output,error_vector);

% %================================================================
% error_vector                = ceil(randn(1,length(Encoder_output)))>0.1;
% channel_out                 = xor(Encoder_output,error_vector);

% channel_out =   Encoder_output;

%%%===============================
%%% De_encoder ===================
%%%===============================
decoder_output = FWC_COV_Dencoder(G,k0,channel_out); 


% [decoder_output,survivor_state,comulated_metric] = COV_Dencoder(G,k0,channel_out);

disp('==========Cac ket qua:===================');

iput

Encoder_output

error_vector

channel_out

d_Haming

decoder_output

errors=sum(decoder_output~=iput)

BER = errors/length(iput)

disp('d_Haming/length(channel_out): t_corr= ')
t_corr = d_Haming/length(channel_out)
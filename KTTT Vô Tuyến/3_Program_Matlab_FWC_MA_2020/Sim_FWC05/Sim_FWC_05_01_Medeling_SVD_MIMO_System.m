%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================

% function NVD_D12VT_SVDMIMO_SystemMedeling

clc;
clear all;
close all;

N_Tx        = 8;        % Num of Tx anten
N_Rx        = 4;        % Num of Rx anten
fD          = 10;       % Doppler Frequency
N_symbol    = 100;     % No of symbol 2048
T_sim       = 0.1;      % Simulation Time

%==========================================================================
% Gaussian Distribution
H_Gausian           = zeros(N_Rx,N_Tx,N_symbol);
for k = 1:N_symbol
     H_Gausian(:,:,k)   = (randn(N_Rx,N_Tx) + i*randn(N_Rx,N_Tx))/sqrt(2);            
end
H_Gau           = zeros(N_Rx,N_Tx);
H_Gau           = H_Gausian(:,:,1);

%==========================================================================
% Rayleigh Distribution
H_Rayleigh      = zeros(N_Rx,N_Tx,N_symbol);
for m = 1:N_Rx    
    for n = 1:N_Tx
        H_Rayleigh(m,n,:) = (FWC_Rayleigh_Channel(T_sim,N_symbol,fD) ...
                    + i*FWC_Rayleigh_Channel(T_sim,N_symbol,fD))/sqrt(2);
    end    
end
H_Ray       = H_Rayleigh(:,:,1);

%==========================================================================
% SVD for MIMO channel and Dispaly

disp('      Ma tran kenh H');
H_Ray
disp('      Kich thuoc H');
disp(size(H_Ray))

disp('      Phan tich SVD cua H: [U, D, V] = svd(H)');

[U_Gau, D_Gau, V_Gau] = svd(H_Gau);
[U_Ray, D_Ray, V_Ray] = svd(H_Ray);

disp('      Ma tran tien ma hoa V ');
% disp(V);
V_Ray
disp('   Kich thuoc size(V)');
disp(size(V_Ray));

disp('      Ma tran hau ma hoa U ');
U_Ray
disp('   Kich thuoc size(U)');
disp(size(U_Ray));

disp('      Ma tran duong cheo D ');
D_Ray

disp('   Kich thuoc size(D)');
disp(size(D_Ray));

%==========================================================================
% % Modelling and Simulation for SVD-MIMO Systems
% % Step 1:
% X1 = 1:2;
% % Step 2:
% X2 = V_Ray*X1';
% % Step 3:
% X3 = V_Ray'*X2;
% % Step 4:
% X4 = D_Ray*X3;
% % Step 5:
% X5 = U_Ray*X4;
% % Step 6:
% X6 = U_Ray'*X5;
% 
% % Check for SVD MIMO modeling
% X6_Test = D_Ray*X1';
% 
% display ('Check for SVD MIMO modeling')
% 
% disp (X6);
% disp (X6_Test); 

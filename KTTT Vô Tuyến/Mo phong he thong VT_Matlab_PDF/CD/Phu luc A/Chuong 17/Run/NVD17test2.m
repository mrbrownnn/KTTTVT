% File: NVD17test2.m
clc;
clear all;
close all;

NVD17_cellularsetup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% location of BS (center cell is located at x=0,y=0)
% Loacation (angular)of the center of each cluster in the first tier
theta_N         = [pi/6 0 pi/6 asin(1/(2*sqrt(7)))];

% angular distance between the center cells of all 6 cluster in first tier
theta           = pi/3*[0:5]';
aux_1           = [1 0 2 3 0 0 4];
ind             = aux_1(cluster_size);

% loaction [x y] of the center cells of all cluster in the first tier
bs_position     = [sqrt(3*cluster_size)*r_cell*cos(theta +...
    theta_N(ind)) sqrt(3*cluster_size)*r_cell*sin(theta+theta_N(ind))];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Section 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determination of the sector to simulated in this snapshort 
%---------------------------------------
% --- select (randomly)a sector-------
%--------------------------------------
sector          = unidrnd(num_sectors(sec));
%----------------------------------------------------------------
%----- place the derirsed mobile within the select sector-------
des_user_beta = rand(1)*phi_BW(sec) + phi_center(sector,sec);
des_user_r  =sqrt(rand(1).*(r_cell^2));
%
% ----- place co-channel mobile within the selected sector of co_channel cell---
co_ch_user_beta = rand(6,1)*phi_BW(sec) + phi_center(sector,sec);
co_ch_user_r    = sqrt(rand(6,1))*(r_cell);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Section 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
des_user_position   = des_user_r*[cos(des_user_beta) sin(des_user_beta)];
co_ch_user_position = [co_ch_user_r.*cos(co_ch_user_beta) co_ch_user_r.*sin(co_ch_user_beta)]...
    + bs_position;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Section 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------
% --- DESIRED USER--------
m_S_fwd     = P_BS - 10*K*n_path*log10(des_user_r);
%
%=========================================
% ----- CO-CHANNEL USERS ----
% ----- Location of desired mobile with respect to co-channle cells ----
aux_01      = ((des_user_position(1)-bs_position(:,1)+ sqrt(-1)*des_user_position(2)-bs_position(:,2)));
beta_fwd    = angle(aux_01);
d_I_fwd     = abs(aux_01);
%--------------------------------------------------
% --- Computation of annten gain at co-channel cells
clear gain_fwd;
for k =1:n_co_ch_users
    if (beta_fwd(k)>=sector_min(sector,sec)) & (beta_fwd(k)< sector_max(sector,sec))
        gain_fwd(k) =in_beam;
    else
        gain_fwd(k) = out_beam;        
    end
end
% ----- comutation of mean values and standard deviation ---
m_I_fwd             = P_BS - 10*K*n_path*log10(d_I_fwd) + gain_fwd.';
sigma_I_fwd         = sigma_int*ones(length(m_I_fwd),1);

[m_I_total_fwd,sigma_I_total_fwd]   =   NVD17_wilkinson(m_I_fwd,sigma_I_fwd,corr_fwd);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Section 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- DESIRED USER ----
m_S_rev = P_MS - 10*K*n_path*log10(des_user_r);
%
% ----- CO-CHANNEL USERS---
% ------location of co-channl users----
aux_02      = (co_ch_user_position(:,1)+ sqrt(-1)*co_ch_user_position(:,2));
beta_rev    = angle(aux_02);
d_I_rev     = abs(aux_02);
%
%======================================================
% ----- computation of annten gain at center cell---
clear gain_rev;
for k =1:n_co_ch_users
    if (beta_rev(k)>=sector_min(sector,sec)) & (beta_rev(k)< sector_max(sector,sec))
        gain_rev(k)     =in_beam;
    else
        gain_rev(k)     = out_beam;        
    end
end
% ----- comutation of mean values and standard deviation ---
m_I_rev         = P_MS - 10*K*n_path*log10(d_I_rev) + gain_rev.';
sigma_I_rev     = sigma_int*ones(length(m_I_rev),1);
[m_I_total_rev,sigma_I_total_rev]   =   NVD17_wilkinson(m_I_rev,sigma_I_rev,corr_rev);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Section 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_SIR_fwd(1)        = m_S_fwd - m_I_total_fwd;
sigma_SIR_fwd(1)    = sqrt(sigma_S^2 + sigma_I_total_fwd^2 - 2*corr_fwd*sigma_S*sigma_I_total_fwd);

m_SIR_rev(1)        = m_S_rev - m_I_total_rev;
sigma_SIR_rev(1)    = sqrt(sigma_S^2 + sigma_I_total_rev^2 - 2*corr_rev*sigma_S*sigma_I_total_rev);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Section 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SIR_fwd_2(1) = normrnd(m_SIR_fwd(1),sigma_SIR_fwd(1));
SIR_rev_2(1) = normrnd(m_SIR_rev(1),sigma_SIR_rev(1))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Section 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
des_sig_spl_fwd     = normrnd(m_S_fwd,sigma_S);
int_sig_spl_fwd     = normrnd(m_I_fwd,sigma_I_fwd);

tot_int_sig_spl_fwd     = 10*log10(sum(10.^(int_sig_spl_fwd/10)));
SIR_spl_fwd_2B(1)       = des_sig_spl_fwd - tot_int_sig_spl_fwd;
des_sig_spl_rev         = normrnd(m_S_rev,sigma_S);
int_sig_spl_rev         = normrnd(m_I_rev,sigma_I_rev);
tot_int_sig_spl_rev     = 10*log10(sum(10.^(int_sig_spl_rev/10)));
SIR_spl_rev_2B(1)       = des_sig_spl_rev - tot_int_sig_spl_rev;
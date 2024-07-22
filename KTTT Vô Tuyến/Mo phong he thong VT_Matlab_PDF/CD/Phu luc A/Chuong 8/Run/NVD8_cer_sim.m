% File: NVD8_cersim.m
clc;
clear all;
close all;
zdB     = 0:0.1:10;				    % set Eb/No axis in dB
z       = 10.^(zdB/10);				% convert to linear scale
ber1    = q(sqrt(2*z));				% PSK result
ber2    = q(sqrt(12*2*z/23));		% CSER for (23,12) Golay code
ber3    = q(sqrt(11*z*2/15));		% CSER for (15,11) Hamming code
berg    = NVD8_cer2ber(2,23,7,3,ber2);	% BER for Golay code 
berh    = NVD8_cer2ber(2,15,3,1,ber3);	% BER for Hamming code
%======================
% plot results
%======================
semilogy(zdB,ber1,zdB,berg,zdB,berh);
xlabel('E_b/N_o dB','fontname','.Vntime');
ylabel('X¸c suÊt lçi bit','fontname','.Vntime');
title('So s¸nh hiÖu n¨ng BER gi÷a c¸c tr­êng hîp: kh«ng m· hãa; m· Golay; m· Hamming',...
    'fontname','.Vntime','fontsize',14);
legend('Khong ma hoa','Ma Golay(23,12)', 'Ma Hamming (15,11)');
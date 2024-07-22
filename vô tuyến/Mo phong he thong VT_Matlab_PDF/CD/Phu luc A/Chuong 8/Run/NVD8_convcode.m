% File NVD8_convcode.m

clc;
clear all;
close all;
zdB     = 2:0.1:10;		% set Eb/No axis in dB
z       = 10.^(zdB/10);	% convert to linear scale
puc     = Q(sqrt(2*z));	% uncoded BER
W       = exp(-z/2);
Num     = W.^5; 
Den     = 1-4*W+4*W.*W;
ps      = 0.5*Num./Den;
%================
% Display Results
%================
semilogy(zdB,puc,'-.',zdB,ps)
xlabel('E_b/N_o [dB]','fontname','.vntime')
ylabel('X�c su�t l�i bit','fontname','.vntime')
title('Gi�i h�n h�m truy�n ��t ��i v�i m� xo�n � l� m� 1/2',...
    'fontname','.Vntime','fontsize',14);
grid; legend('Khong ma hoa','Ma xoan ty le 1/2');
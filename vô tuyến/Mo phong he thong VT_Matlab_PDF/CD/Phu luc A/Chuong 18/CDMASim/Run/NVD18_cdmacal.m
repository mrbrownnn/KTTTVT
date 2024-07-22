% function NVD18_cdmacal
% Calibration Run: NVD18_cdmacal.m
clc;
clear all;
close all;

N       = 2000;         %input('Nhap so ky hieu mo phong > ');
EoN     = 0:8;          %input('Nhap vector Eb/No > ');
SF      = 7;

NumInterferers  = 0;
MPathDelay      = [0 3 4];
KfactordB       = 100;
len_EoN         = length(EoN);
BER             = zeros(1,len_EoN);

h = waitbarqa(0,'Xin vui lßng chê, ch­¬ng tr×nh ®ang ch¹y hiÖu chuÈn...');
% h   = waitbar(0,'Calibration Run');

for j=1:len_EoN
   EbNo = EoN(j);
   [BER(j),ErrorRun]    = NVD18_cdmasim(N,SF,EbNo,NumInterferers,MPathDelay,KfactordB);
   waitbar(j/len_EoN)
end

close(h)

z           = 10.^(EoN/10);
BERT        = q(sqrt(2*z));
semilogy(EoN,BER,...
        '--rs','LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',7);   
hold on;
semilogy(EoN,BERT,...
        '--rs','LineWidth',1,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','m',...
        'MarkerSize',5);

xlabel('E_b/N_0 dB','FontName','.VnTime','color','b','FontSize',12);
ylabel('X¸c suÊt lçi ký hiÖu P_E','FontName','.VnTime','color','b','FontSize',12);
title(['M« pháng ch¹y hiÖu chuÈn HÖ thèng CDMA víi tham sè:  SF= ',num2str(SF),...
     ';  N_s_y_m_b_o_l = ',num2str(N),...
    ],'FontName','.VnTime','color','b','FontSize',12);
grid on;
legend('BER','BER_T_e_s_t',3);
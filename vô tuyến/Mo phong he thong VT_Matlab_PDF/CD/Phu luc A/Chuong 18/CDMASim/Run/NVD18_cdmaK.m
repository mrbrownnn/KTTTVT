% File: NVD18_cdmaK.m: Note Kfactor
clc;
clear all;
close all;
N                   = input('Nhap so ky hieu mo phong (100000) > ');
EoN                 = 0:10;         % input('Enter Eb/No vector (0:10) > ');
KdB                 = [-20 0 20];   % input('Enter KfatordB vector [-20 0 20] > ');
SF                  = 7;
NumInterferers      = 0;
MPathDelay          = [0 3 4];
len_EoN             = length(EoN);
len_KdB             = length(KdB);
BER                 = zeros(len_KdB,len_EoN);
for i=1:len_KdB
   KfactordB = KdB(i);
   for j=1:len_EoN
      EbNo = EoN(j);
      [BER(i,j),ErrorRun] = NVD18_cdmasim(N,SF,EbNo,NumInterferers,MPathDelay,KfactordB);
      display = ['He so K [dB] = ',num2str(KfactordB),'  Eb/No = ',num2str(EbNo),'.'];
      disp(display)
   end
end
semilogy(EoN,BER,...
        '--rs','LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',7);
xlabel('E_b/N_0 dB','FontName','.VnTime','color','b','FontSize',12);
ylabel('X¸c suÊt lçi ký hiÖu P_E','FontName','.VnTime','color','b','FontSize',12);
title(['M« pháng HÖ thèng CDMA víi tham sè: HÖ sè K= ',num2str(KdB),...
     ';  N_s_y_m_b_o_l = ',num2str(N),...
    ],'FontName','.VnTime','color','b','FontSize',12);
grid;
legend('K = -20 dB','K = 0 dB','K = 20 dB');
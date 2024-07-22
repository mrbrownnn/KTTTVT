% File: NVD18_cdmaex1.m

clc;
clear all;
close all;

N           = 1000;         %input('Nhap so ky hieu mo phong (100 000) > ');
EoN         = 0:8;          %input('Nhap vector Eb/No (0:8) > ');
KdB         = [-20 0 20];   %input('Nhap vector he so K [dB] [-10 0 10] > ');
SF          = 7;
NumInterferers  = 0;
MPathDelay      = [0 3 4];
len_EoN         = length(EoN);
len_KdB         = length(KdB);

BER             = zeros(len_KdB,len_EoN);

for i=1:len_KdB
   KfactordB = KdB(i);
   for j=1:len_EoN
      EbNo                  = EoN(j);
      [BER(i,j),ErrorRun]   = NVD18_cdmasim(N,SF,EbNo,NumInterferers,MPathDelay,KfactordB);
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
grid;
title(['M« pháng x¸c suÊt lçi lµ hµm cña E_b/N_0 víi hÖ sè K lµm th«ng sè  K_f_a_c_t_o_r = [',num2str(KdB),...
     '] dB;   N_s_y_m_b_o_l = ',num2str(N),...
    ],'FontName','.VnTime','color','b','FontSize',12);
grid on;
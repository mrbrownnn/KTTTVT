%==========================================================================
%====================== Sim_FWC_01_2_PSD_Modulation =======================
%==========================================================================

clc;
clear;
close all;

% Tham so
% f       =   input ('Nhap ta so khao sat=');%linspace(-2000,2000,1500);
f       =   linspace(-2000,2000,1500);
Tb      =   0.002;%input('Nhap thoi gian bit=');%0.005;
Rb      =   1/Tb;
P       =   1;
A       =   1;
AA      =   A^2*Tb;
fc      =   600;        % Carrier Frequncy
Eb      =   P*Tb;

% PSD of BaseBand Signal
    PSD_BaseBand = AA*(sinc((f*Tb)).^2);

% PSD of M-PSK <=> PSD_M_BPSK = Eb*log2(M)*((sinc((f-fc)*Tb*log2(M))).^2)
    PSD_BPSK    = (Eb*log2(2))*((sinc((f-fc)*Tb*log2(2))).^2);
    PSD_QPSK    = (Eb*log2(4))*((sinc((f-fc)*Tb*log2(4))).^2);
    PSD_8_PSK   = (Eb*log2(8))*((sinc((f-fc)*Tb*log2(8))).^2);    
    % PSD double side
    PSD_BPSK_2    = (Eb*log2(2)/2)*(((sinc((f-fc)*Tb*log2(2))).^2) + ((sinc((f+fc)*Tb*log2(2))).^2));
    PSD_QPSK_2    = (Eb*log2(4)/2)*(((sinc((f-fc)*Tb*log2(4))).^2) + ((sinc((f+fc)*Tb*log2(4))).^2));
    PSD_8_PSK_2   = (Eb*log2(8)/2)*(((sinc((f-fc)*Tb*log2(8))).^2) + ((sinc((f+fc)*Tb*log2(8))).^2));    
    
% PSD of MSK: PSD_MSK = ((8*Eb)/pi)*((cos(2*pi(f-fc)*Tb))/(16*(Tb^2)*(f-fc).^2)-1)
    SF          = ((16*Eb)/(pi^2));
    Num         = (cos(2*pi*(f-fc)*Tb));
    Dum         = (16*(Tb^2)*(f-fc).^2)-1;    
    PSD_MSK     = SF*((Num./Dum).^2);    
    % PSD_MSK double side
    Num_2       = (cos(2*pi*(f+fc)*Tb));
    Dum_2       = (16*(Tb^2)*(f+fc).^2)-1;    
    PSD_MSK_2   = (SF/2)*(((Num./Dum).^2) + ((Num_2./Dum_2).^2));
    
figure(1)
subplot(2,1,1);
    plot(f,PSD_BaseBand,'b','LineWidth',3);
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD ��u v�o kh�i �i�u ch�','FontName','.VnTime','color','b','FontSize',14);    
    title(['M�t �� ph� c�ng su�t PSD c�a t�n hi�u ��u v�o kh�i �i�u ch� R_b =',num2str(Rb),'b/s'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;    
subplot(2,1,2);
    plot(f,PSD_BPSK,'b','LineWidth',3);
    hold on
    plot(f,PSD_QPSK,'g','LineWidth',3);
    hold on
    plot(f,PSD_8_PSK,'r','LineWidth',3);    
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD c�a BPSK-QPSK-8PSK','FontName','.VnTime','color','b','FontSize',14);    
    title(['So s�nh m�t �� ph� c�ng su�t PSD c�a t�n hi�u BPSK; QPSK; 8-PSK v�i t�c �� R_b =',num2str(Rb),'b/s',...
        '; T�n s� s�ng mang f_c =',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;
    L   = legend('PSD c�a BPSK','PSD c�a QPSK',...
        'PSD c�a 8PSK');
    set(L, 'fontname','.Vntime','fontsize',13);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
figure(2)
subplot(2,2,1:2);  
    plot(f,PSD_BaseBand,'b','LineWidth',3);
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD ��u v�o kh�i �i�u ch�','FontName','.VnTime','color','b','FontSize',14);    
    title(['M�t �� ph� c�ng su�t PSD c�a t�n hi�u ��u v�o kh�i �i�u ch� R_b =',num2str(Rb),'b/s'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;  

subplot(2,2,3);
    f1  =   (f-fc)*Tb;
    plot(f1,PSD_QPSK,'g','LineWidth',3);
    hold on
    plot(f1,PSD_MSK,'r','LineWidth',3);
    xlabel('T�n s� chu�n h�a (f-f_c)T_b','FontName','.VnTime','color','r','FontSize',12);
    ylabel('PSD c�a QPSK & MSK','FontName','.VnTime','color','b','FontSize',12);
    title(['So s�nh PSD c�a QPSK & MSK, R_b =',num2str(Rb),'b/s',...
        '; T�n s� s�ng mang f_c =',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;
    L   = legend('PSD c�a QPSK','PSD c�a MSK');
    set(L, 'fontname','.Vntime','fontsize',13);
    
subplot(2,2,4);
    plot(f,PSD_QPSK,'g','LineWidth',3);
    hold on
    plot(f,PSD_MSK,'r','LineWidth',3);
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD c�a QPSK & MSK','FontName','.VnTime','color','b','FontSize',12);    
    title(['So s�nh PSD c�a QPSK & MSK, R_b =',num2str(Rb),'b/s',...
        '; T�n s� s�ng mang f_c =',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;
    L   = legend('PSD c�a QPSK','PSD c�a MSK');
    set(L, 'fontname','.Vntime','fontsize',13);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% close all;
figure(3)
subplot(2,1,1);
    plot(f,PSD_BaseBand,'b','LineWidth',3);
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD ��u v�o kh�i �i�u ch�','FontName','.VnTime','color','b','FontSize',14);    
    title(['M�t �� ph� c�ng su�t PSD c�a t�n hi�u ��u v�o kh�i �i�u ch� R_b =',num2str(Rb),'b/s'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;    
subplot(2,1,2);
    plot(f,PSD_BPSK_2,'b','LineWidth',3);
    hold on
    plot(f,PSD_QPSK_2,'g','LineWidth',3);
    hold on
    plot(f,PSD_8_PSK_2,'r','LineWidth',3);    
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD c�a BPSK-QPSK-8PSK','FontName','.VnTime','color','b','FontSize',14);    
    title(['So s�nh m�t �� ph� c�ng su�t PSD c�a t�n hi�u BPSK; QPSK; 8-PSK v�i t�c �� R_b =',num2str(Rb),'b/s',...
        '; T�n s� s�ng mang f_c =',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;
    L   = legend('PSD c�a BPSK','PSD c�a QPSK',...
        'PSD c�a 8PSK');
    set(L, 'fontname','.Vntime','fontsize',13);

figure(4)
subplot(2,2,1:2);  
    plot(f,PSD_BaseBand,'b','LineWidth',3);
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',14);
    ylabel('PSD ��u v�o kh�i �i�u ch�','FontName','.VnTime','color','b','FontSize',14);    
    title(['M�t �� ph� c�ng su�t PSD c�a t�n hi�u ��u v�o kh�i �i�u ch� R_b =',num2str(Rb),'b/s'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;  

subplot(2,2,3);
    f1  =   (f-fc)*Tb;
    plot(f1,PSD_QPSK_2,'g','LineWidth',3);
    hold on
    plot(f1,PSD_MSK_2,'r','LineWidth',3);
    xlabel('T�n s� chu�n h�a (f-f_c)T_b','FontName','.VnTime','color','r','FontSize',12);
    ylabel('PSD c�a QPSK & MSK','FontName','.VnTime','color','b','FontSize',12);
    title(['So s�nh PSD c�a QPSK & MSK, R_b =',num2str(Rb),'b/s',...
        '; T�n s� s�ng mang f_c =',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;
    L   = legend('PSD c�a QPSK','PSD c�a MSK');
    set(L, 'fontname','.Vntime','fontsize',13);
    
subplot(2,2,4);
    plot(f,PSD_QPSK_2,'g','LineWidth',3);
    hold on
    plot(f,PSD_MSK_2,'r','LineWidth',3);
    xlabel('T�n s� [H_z]','FontName','.VnTime','color','b','FontSize',12);
    ylabel('PSD c�a QPSK & MSK','FontName','.VnTime','color','b','FontSize',12);    
    title(['So s�nh PSD c�a QPSK & MSK, R_b =',num2str(Rb),'b/s',...
        '; T�n s� s�ng mang f_c =',num2str(fc),'H_Z'],...
        'FontName','.VnTime','color','b','FontSize',12);
    grid on;
    L   = legend('PSD c�a QPSK','PSD c�a MSK');
    set(L, 'fontname','.Vntime','fontsize',13);  
%==========================================================================    
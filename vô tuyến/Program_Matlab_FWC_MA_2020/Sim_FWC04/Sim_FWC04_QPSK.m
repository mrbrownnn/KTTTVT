%==========================================================================
%=============  Sim_FWC_03_02_BPSK_AWGN_ChannelCode   =====================
%==========================================================================


clc;
clear all;
close all;
%%%%%%%%%%%%%% Set parameter for simulation
samp_bit        = 40;       % input('Nhap so mau/bit de MP (20) =    ');
T_bit           = 0.5;      % Bit time
Rb              = 1/T_bit;  
fc              = 2/T_bit;  % input('Nhap tan so song mang Hz (4) =   ');
N_bits          = 2000;     % input('Nhap tong so bit MP (1000) =  ');
I_plot          = input('   Chon khao sat:  1= Dang song; 2 = Pho; 3= Bieu do mat; 4 = Duong bao; 5 = Bieu do pha =    ');

if I_plot ==2    
    N_ave = 4;   % input('Nhap so pho de lay trung binh uoc tinh PSD (9)= ');        
end

data    = 0.5*(sign(rand(1,N_bits)-0.5)+1); % Generate for N_bits bits {0,1}
del_t   = T_bit/samp_bit;                   % space between samples of bit
s       = 2*data - 1;                       % Generate for N_bits bits {-1,+1}
L       = length(s);                        % length of data
psi     = zeros(1,L);                       % Generate for N_bits bits {null}
t       = 0:del_t :L*T_bit - del_t;         % simualtion time

%%==============================================
% Loop to repeat for phasor digrams
%%==============================================
% ====
tp      = 0:del_t:L*T_bit-del_t;
% ====
sigr    = [];
sigi    = [];
sig     = [];
s_t     = [];
xc      = [];
sigs    = [];
sig     = [];
y_sig   = [];
s_t     = s(ones(samp_bit,1),:); % Buld array whose columns are samp_bit long
s_t     = s_t(:)';               % Convert matrix where bit samples occupy columns to vector
T_sym   = 2*T_bit;
sigs    = s(ones(2*samp_bit,1),:); % Form array whose columns are the bits sampled samp_bit times
sigr    = sigs(:,1:2:L);    % Odd-indexed columns = Quadrature channel symbols
sigi    = sigs(:,2:2:L);    % Even-indexed columns = Inphase channel symbols
sigr    = (sigr(:))';       % Concatenate columns into row matrix
sigi    = (sigi(:))';       % Concatenate columns into row matrix

sig     = sqrt(0.5)*(sigr - i*sigi); % Form complex baseband signal for QPSK

sig_BB = sig;
%==============================================
N_sig       = length(sig);
freq_array  = [];
sig_pr      = [];
%==============================================
xc          = sig.*exp(i*2*pi*fc*tp);
%==============================================

if I_plot ==1 %% Dang song=====    
    x_m = 1.5;
    h_11 = figure(1);
        subplot(4,1,1);
        plot(t,s_t);
        axis([0 10 -x_m x_m]);
        xlabel('Thêi gian ','fontname','.Vntime','fontsize',12);
        ylabel('D÷ liÖu nèi tiÕp','fontname','.Vntime','fontsize',12);
        title('D¹ng sãng tÝn hiÖu QPSK','fontname','.Vntime','fontsize',18);
        grid on;   
    
    subplot(4,1,2);
        plot(tp,real(sig_BB));
        axis([0 10 -x_m x_m]);
        xlabel('Thêi gian','fontname','.Vntime','fontsize',12);
        ylabel('D÷ liÑu I ','fontname','.Vntime','fontsize',12);
        grid on;
    
    subplot(4,1,3);
        plot(tp,imag(sig_BB));
        axis([0 10 -x_m x_m]);
        xlabel('Thêi gian','fontname','.Vntime','fontsize',12);
        ylabel('D÷ liÖu Q','fontname','.Vntime','fontsize',12);
        grid on;
    
    subplot(4,1,4);
        plot(tp,real(xc));
        axis([0 10 -x_m x_m]);
        AX = gca;
        set(AX,'fontsize',14);
        xlabel('Thêi gian ','fontname','.Vntime','fontsize',12);
        ylabel('TÝn hiÖu ®iÒu chÕ ','fontname','.Vntime','fontsize',12);
        grid on;
    
    % h_12 = figure(2);
    % plot(tp(1:100),real(xc(1:100)));
    % axis([0 10 -x_m x_m]);
    % xlabel('Thêi gian ','fontname','.Vntime','fontsize',12);
    % ylabel('TÝn hiÖu ®iÒu chÕ ','fontname','.Vntime','fontsize',12);
    % title('D¹ng sãng tÝn hiÖu QPSK','fontname','.Vntime','fontsize',12);
    % grid on;
    
elseif I_plot==2 % Mat do pho cong suat PSD=========
    L_xc    = length(xc);
    LL      = fix(L_xc/N_ave);
    LLlog   = fix(log2(LL));
    LL      = 2^LLlog;
    fs      = 1/del_t;
    del_f   = fs/LL;    
    f       = 0:del_f:fs-del_f;         % f  = -fs-del_f:del_f:fs-del_f;
    xcp     = [];
    xcp     = xc(1:LL*N_ave);
    sig     = [];
    xc      = xcp;    
    xc_pr   = reshape(xc,LL,N_ave);
    Xc      = (fft(xc_pr))';            % size(Xc): note Xc & xc
    X_est   = sum(abs(Xc));
    psd     = 20*log10(X_est/max(X_est));    
    f_s     = 1/T_sym;                  % note
    
    plot(f,psd);
        axis([fc-10*f_s fc+10*f_s -50 0]);
        AX = gca;
        set(AX,'fontsize',14);
        xlabel('TÇn sè, Hz','fontname','.Vntime','fontsize',14);
        ylabel('MËt ®é phæ c«ng suÊt PSD, dB','fontname','.Vntime','fontsize',18);    
        title(['Phæ tÝn hiÖu QPSK; TÇn sè trung t©m = ',num2str(fc),...
            'Hz; R_b = ',num2str(Rb),'b/s; R_s = ',num2str(f_s),'s/s; No ave = ',num2str(N_ave)],...
            'fontname','.Vntime','fontsize',18);
        grid on
            
elseif I_plot ==3|I_plot==4|I_plot==5   % Bieu do mat, Duong bao, Bieu do pha, 
    I_filt  =   1;  % input('    Nhap 1 de du lieu duoc loc boi bo loc Butterworth; Nhap 2 neu khong loc:     ');    
    if I_filt ==1        
        BW      = input('    Nhap do rong bang thong bo loc: B= [0 den 0.8]R_b: ');
        n_order = input('   Nhap bac bo loc (1,2,3,4) =  ');
        [num,den] = butter(n_order,2*BW/samp_bit);
        y_sig   = [];
        zi      = [];
        [y_sig,zf] = filter(num,den,sig,zi);
        zi      = zf;               
    end
    N_sig = length(sig);
    
    if I_plot==3  % Bieu do mat====
        z_sig = zeros(size(y_sig));        
        if I_filt ==1            
            z_sig(1:N_sig - 5*samp_bit) = y_sig(5*samp_bit:N_sig-1);            
        elseif I_filt ==2            
            z_sig(1:N_sig - 5*samp_bit) = sig(5*samp_bit:N_sig-1);            
        end        
        N_sym = 2*T_sym/del_t;        
        tt= 0:del_t:2*T_sym - del_t;
        
        for n=2:fix((N_sig-5*samp_bit)/N_sym)
            real_eye            =[];
            imag_eye            =[];            
            real_eye(1:N_sym)   = real(z_sig((n-1)*N_sym - 0.5*N_sym + 1 : n*N_sym - 0.5*N_sym));            
            imag_eye(1:N_sym)   = imag(z_sig((n-1)*N_sym - 0.5*N_sym + 1 : n*N_sym - 0.5*N_sym));
            
            %Thanh phan I ==================
            subplot(2,1,1),
            plot(tt,real_eye);
            xlabel('Thêi gian','fontname','.Vntime','fontsize',12),
            ylabel('BiÓu ®å m¾t trªn trôc I ','fontname','.Vntime','fontsize',12);
            if I_filt ==1
                title(['BiÓu ®å m¾t tÝn hiÖu QPSK ®­îc läc bëi bé läc Butterworth bËc',num2str(n_order),' cã ®é réng b¨ng BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',16);
            elseif I_filt ==2
                title('BiÓu ®å m¾t tÝn hiÖu QPSK khong ®­îc läc ','fontname','.Vntime','fontsize',16);
            end
            if n==2
                hold on
            end
            grid on;                        
            %Thanh phan Q ==================
            subplot(2,1,2),
            plot(tt,imag_eye);
            AX = gca;
            set(AX,'fontsize',14);
            xlabel('Thêi gian','fontname','.Vntime','fontsize',12),
            ylabel('BiÓu ®å m¾t trªn trôc Q ','fontname','.Vntime','fontsize',14);
            if n==2
                hold on
            end
            grid on;
        end
        
    elseif I_plot==4 % Duong bao =======        
        plot(t,abs(y_sig));
        title(['§­êng bao tÝn hiÖu QPSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),' cã BW= ',...
                    num2str(BW),'R_b'],'fontname','.Vntime','fontsize',16);
        grid on;
    
    elseif I_plot==5 % Bieu do pha ======        
        z_sig   = [];
        if I_filt==1
            z_sig(1:N_sig-5*samp_bit) = y_sig(5*samp_bit:N_sig-1);
        elseif I_filt==2
            z_sig(1:N_sig-5*samp_bit) = sig(5*samp_bit:N_sig-1);
        end        
        plot(real(z_sig),imag(z_sig));
        hold on;
        plot(real(sig),imag(sig),'r','LineWidth',2);
        axis square;
        AX = gca;
        set(AX,'fontsize',14);
        xlabel('Thµnh phÇn I','fontname','.Vntime','fontsize',12);
        ylabel('Thµnh phÇn Q','fontname','.Vntime','fontsize',14);
        axis([-1.5 1.5 -1.5 1.5]),...            
        title(['BiÓu ®å pha tÝn hiÖu QPSK ; ®­îc läc bëi bé läc Butterwort bËc ',...
        num2str(n_order),'; BW= ',num2str(BW),'R_b'],...
        'fontname','.Vntime','fontsize',16);
        grid on;
        L   = legend('Pha cña QPSK_R_X','Pha cña QPSK_T_X');
        set(L, 'fontname','.Vntime','fontsize',14);        
    end
end

%%%===========================================================
if I_plot ==2
% set parameter for decription PSD_QPSK
P               =   1;
Eb              =   P*T_bit;
PSD_QPSK        = (Eb*log2(4))*(sinc((f-fc)*T_bit*log2(4))).^2; % M = 4
PSD_QPSK_dB     = 20*log10(PSD_QPSK/max(PSD_QPSK));
figure(2);
    plot(f,psd,'b','LineWidth',1.5);
    hold on;
    plot(f,PSD_QPSK_dB,'r','LineWidth',2);
    axis([fc-10*f_s fc+10*f_s -90 0]);    
    AX = gca;
    set(AX,'FontSize',14);
    xlabel('TÇn sè, Hz','fontname','.Vntime','fontsize',12);
    ylabel('MËt ®é phæ c«ng suÊt PSD, dB','fontname','.Vntime','fontsize',18);
    title(['Phæ tÝn hiÖu QPSK; TÇn sè trung t©m = ',num2str(fc),...
        'Hz; R_b = ',num2str(Rb),'b/s; R_s = ',num2str(f_s),'s/s; No ave = ',num2str(N_ave)],...
        'fontname','.Vntime','fontsize',18);
    grid on;
    LT   = legend('PSD cña QPSK: M« pháng','PSD cña QPSK: TÝnh to¸n ');
    set(LT, 'fontname','.Vntime','fontsize',13);        
end
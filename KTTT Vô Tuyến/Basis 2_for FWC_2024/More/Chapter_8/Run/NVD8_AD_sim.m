% file: NVD8_AD_sim
clc;
clear all;
close all;

mod_type    = input('      Nhap: 0 cho BPSK, 1 cho QPSK, 2 cho OQPSK, 3 cho MSK & 4 cho 16 QAM  = ');
display('           Luu y rang: Neu ve bieu do pha, bieu do mat & duong bao thi Nhap 0 cho OFDM = ');
ofdm_mod    = 0;       % input('  Nhap 1 cho OFDM  = ');
ph_error    = 0;       % input('  Nhap 1 cho loi pha giai dieu che (0)  = ');
if ofdm_mod==1    
    N_tones = input('   Nhap so tones cho OFDM (5) =     ')    
end

samp_bit        = 20;%input('Nhap so mau/bit de MP (20) =    ');
f0              = 5;%input('Nhap tan so song mang Hz (4) =   ');
N_bits          = 1000;%input('Nhap tong so bit MP (1000) =  ');
I_plot          = input('       Khao sat:  1= Dang song; 2 = Pho; 3= Bieu do mat; 4 = Duong bao; 5 = Bieu do pha =    ');

if I_plot ==2    
    N_ave = 7;   % input('Nhap so pho de lay trung binh uoc tinh PSD (9)= ');        
end
data    = 0.5*(sign(rand(1,N_bits)-0.5)+1);
T_bit   = 1;
del_t   = T_bit/samp_bit;
s       = 2*data - 1;
L       =length(s);
psi     = zeros(1,L);

if ph_error ==1
    type_ph_error = input('Nhap 1 cho loi pha tinh; 2 cho loi pha gaussian =   ');
    if type_ph_error==1
        psi_rad = input(' Nhap loi pha radian =   ');
        psi = psi_rad*ones(1,L);
    elseif type_ph_error==2
        var_psi_rad2 = input('Nhap phuong sai loi pha =    ') ;
        psi = sqrt(var_psi_rad2)*randn(1,L);
    end        
end

t = 0:del_t :L*T_bit - del_t;
%%==============================================
% Loop to repeat for phasor digrams
%%==============================================
clf
if mod_type~=4
    tp = 0: del_t :L*T_bit - del_t;
    tpp = 0:del_t:2*T_bit - del_t;
elseif mod_type==4
    tp = 0: del_t :(L*T_bit - del_t); % ? (L)
end
sigr    = [];
sigi    =[];
sig     =[];
s_t     =[];
xc      =[];
sigs    =[];
sig     =[];
y_sig   =[];
s_t     = s(ones(samp_bit,1),:); % Buld array whose columns are samp_bit long
s_t     = s_t(:)';               % Convert matrix where bit samples occupy columns to vector
if mod_type ~=4 & mod_type~=0
    T_sym   = 2*T_bit;
    %==============================================
    % Form array whose columns are the bits sampled samp_bit times
    sigs    = s(ones(2*samp_bit,1),:);
    sigr    = sigs(:,1:2:L);                   % Odd-indexed columns = Quadrature channel symbols
    sigi    = sigs(:,2:2:L);                   % Even-indexed columns = Inphase channel symbols
    if mod_type ==3
        AA      = sin(pi*tpp/(2*T_bit));
        CC      = (AA(ones(floor(L/2),1),:))';
        sigr    = CC.*sigr;                             % Weight symbols with half sine
        sigi    = CC.*sigi;                             %Weight symbols with half sine
    end
    sigr    = (sigr(:))';                               % Concatenate columns into row matrix
    sigi    = (sigi(:))';                               % Concatenate columns into row matrix
    if mod_type == 1
        sig     = sqrt(0.5)*(sigr - i*sigi);            % Form complex baseband signal for QPSK
    elseif mod_type ==2
        sig     = sqrt(0.5)*(sigr - i*delay(sigi,samp_bit +1)); % OQPSK BB signal
    elseif mod_type ==3
        sig     = sigr - i* delay(sigi,samp_bit +1);    % MSK complex baseband signal 
    end
elseif mod_type ==4
    T_sym   = 4*T_bit;
    for l=1:4:L-3
        if s(l)==-1&s(l+1)==-1
            ampr=-3;
        elseif s(l)==-1&s(l+1)==1
            ampr=-1;
        elseif s(l)==1&s(l+1)==1
            ampr=1;
        elseif s(l)==1&s(l+1)==-1
            ampr=3;
        end
        if s(l+2)==-1& s(l+3)==-1
            ampi = -3;
        elseif s(l+2)==-1&s(l+3)==1
            ampi = -1;
        elseif s(l+2)==1&s(l+3)==1
            ampi = 1;
        elseif s(l+2)==1&s(l+3)==-1
            ampi = 3;
        end
        sigr = [sigr hold_in(ampr,4*samp_bit)];
        sigi = [sigi hold_in(ampi,4*samp_bit)];
        sig  = sigr - i*sigi;
    end
elseif mod_type ==0
    sigr    = s_t;
    sigi    = zeros(size(t));
    sig     = sigr - i*sigi;
    T_sym   = T_bit;
end
%==============================================
if ofdm_mod ==1
    MM          = [];
    sigp        =[];
    N_sig       =length(sig);
    N_cols      = fix(N_sig/N_tones);
    T_sym_ofdm  = N_tones*T_sym;
    f_sym_ofdm  = 1/T_sym_ofdm;
    f_step      = 0.5*f_sym_ofdm;
    MM          = [0:N_tones-1]*f_step;
    sigp        = sig(1:N_tones*N_cols);
    sig         = sigp;
    N_sig       = length(sig);
end
%==============================================
N_sig       = length(sig);
freq_array  =[];
sig_pr      = [];
if ofdm_mod ==1
    sig_pr  = reshape(sig,N_tones,N_cols);
    for n=1:N_cols
        tn          =(n-1)*del_t;
        exp_fr      = exp(j*2*pi*MM*tn);
        freq_array  = [freq_array, exp_fr'];
    end
    tp      = 0:del_t:(N_cols-1)*del_t;
    sig     = sum(sig_pr.*freq_array);
end
%==============================================
xc          = sig.*exp(j*2*pi*f0*tp);
if ofdm_mod ==1
    f_s     = N_tones*f_sym_ofdm;
    f_ss    = f_sym_ofdm;
else
    f_s     =1/T_sym;
    f_ss    =1/T_sym;
end
%==============================================
if I_plot ==1
    subplot(4,1,1);
    plot(t,s_t);
    axis([0 50 -1.5 1.5]);
    xlabel('Thêi gian ','fontname','.Vntime','fontsize',12);
    ylabel('D÷ liÖu nèi tiÕp','fontname','.Vntime','fontsize',12);
    if mod_type ==0 & ofdm_mod~=1        
        title('D¹ng sãng tÝn hiÖu BPSK','fontname','.Vntime','fontsize',12);
        x_m = 1.5;        
    elseif mod_type ==1 & ofdm_mod~=1        
        title('D¹ng sãng tÝn hiÖu QPSK','fontname','.Vntime','fontsize',12);
        x_m = 1.5;        
    elseif mod_type ==2 & ofdm_mod~=1        
        title('D¹ng sãng tÝn hiÖu OQPSK ','fontname','.Vntime','fontsize',12);
        x_m = 1.5;        
    elseif mod_type ==3 & ofdm_mod~=1        
        title('D¹ng sãng tÝn hiÖu MSK','fontname','.Vntime','fontsize',12);
        x_m = 1.5;        
    elseif mod_type ==4 & ofdm_mod~=1        
        title('D¹ng sãng tÝn hiÖu 16-QAM','fontname','.Vntime','fontsize',12);
        x_m = 5;        
    end    
    if mod_type ==0 & ofdm_mod==1        
        title(['D¹ng sãng tÝn hiÖu OFDM/BPSK; TÇn sè trung t©m ./tones = ',num2str(f0),...
                'Hz/',num2str(N_tones),'; R_b = 1 bps; R_s = ',num2str(f_ss)],...
                'fontname','.Vntime','fontsize',12)
        x_m=5;        
    elseif mod_type ==1 & ofdm_mod==1        
        title(['D¹ng sãng tÝn hiÖu OFDM/QPSK; TÇn sè trung t©m./tones = ',num2str(f0),...
                'Hz/',num2str(N_tones),';R_b = 1 bps; R_s = ',num2str(f_ss)],...
                'fontname','.Vntime','fontsize',12)
        x_m=5;        
    elseif mod_type ==2 & ofdm_mod==1        
        title(['D¹ng sãng tÝn hiÖu OFDM/OQPSK; TÇn sè trung t©m ./tones = ',num2str(f0),...
                'Hz/',num2str(N_tones),'; R_b = 1 bps; R_s = ',num2str(f_ss)],...
                'fontname','.Vntime','fontsize',12)
        x_m=5;        
    elseif mod_type ==3 & ofdm_mod==1        
        title(['D¹ng sãng tÝn hiÖu OFDM/MSK; TÇn sè trung t©m./tones = ',num2str(f0),...
                'Hz/',num2str(N_tones),'; R_b = 1 bps; R_s = ',num2str(f_ss)],...
                'fontname','.Vntime','fontsize',12)
        x_m=5;        
    elseif mod_type ==4 & ofdm_mod==1        
        title(['D¹ng sãng tÝn hiÖu OFDM/16-QAM; TÇn sè trung t©m./tones = ',num2str(f0),...
                'Hz/',num2str(N_tones),'; R_b = 1 bps; R_s = ',num2str(f_ss)],...
                'fontname','.Vntime','fontsize',12)
        x_m=7;        
    end
    %% Dang song===========================================================
    subplot(4,1,2);    
    plot(tp,real(sig));
    axis([0 50 -x_m x_m]);
    xlabel('Thêi gian','fontname','.Vntime','fontsize',12);
    ylabel('D÷ liÑu I ','fontname','.Vntime','fontsize',12);
    subplot(4,1,3);
    plot(tp,imag(sig));
    axis([0 50 -x_m x_m]);
    xlabel('Thêi gian','fontname','.Vntime','fontsize',12);
    ylabel('D÷ liÖu Q','fontname','.Vntime','fontsize',12);
    subplot(4,1,4);
    plot(tp,real(xc));
    axis([0 50 -x_m x_m]);
    xlabel('Thêi gian ','fontname','.Vntime','fontsize',12);
    ylabel('TÝn hiÖu ®iÒu chÕ ','fontname','.Vntime','fontsize',12);
elseif I_plot==2
    %% Mat do pho cong suat PSD============================================
    L_xc    = length(xc);
    LL      = fix(L_xc/N_ave);
    LLlog   = fix(log2(LL));
    LL      =2^LLlog;
    fs=1/del_t;
    f_sym   = 1/T_sym;
    del_f   = fs/LL;
    % next paper
    f       = 0:del_f:fs - del_f;
    xcp     = [];
    xcp     = xc(1:LL*N_ave);
    sig     = [];
    xc      = xcp;
    L_xc    = length(xc);
    xc_pr   = reshape(xc,LL,N_ave);
    Xc      = (fft(xc_pr))';
    size(Xc)   % note Xc & xc
    X_est   = sum(abs(Xc));
    psd     = 20*log10(X_est/max(X_est));    
    plot(f,psd),...
        axis([f0-10*f_s f0+10*f_s -50 0]),...
        xlabel('TÇn sè, Hz','fontname','.Vntime','fontsize',12),...
        ylabel('MËt ®é phæ c«ng suÊt PSD, dB','fontname','.Vntime','fontsize',12),...        
    if mod_type ==1& ofdm_mod~=1
        title(['Phæ tÝn hiÖu QPSK; TÇn sè trung t©m = ',num2str(f0),...
                'Hz; R_b = 1 bps; R_s = ',num2str(f_ss),';No ave = ',num2str(N_ave)],...
                'fontname','.Vntime','fontsize',12);        
    elseif mod_type ==2& ofdm_mod~=1        
        title(['Phæ tÝn hiÖu OQPSK; TÇn sè trung t©m = ',num2str(f0),...
                'Hz; R_b = 1 bps; R_s = ',num2str(f_ss),';No ave = ',num2str(N_ave)],...
                'fontname','.Vntime','fontsize',12);

    elseif mod_type ==3& ofdm_mod~=1        
        title(['Phæ tÝn hiÖu MSK; TÇn sè trung t©m = ',num2str(f0),...
                'Hz; R_b = 1 bps; R_s = ',num2str(f_ss),';No ave = ',num2str(N_ave)],...
                'fontname','.Vntime','fontsize',12);
        
    elseif mod_type ==4& ofdm_mod~=1        
        title(['Phæ tÝn hiÖu 16-QAM ; TÇn sè trung t©m = ',num2str(f0),...
                'Hz/; R_b = 1 bps; R_s = ',num2str(f_ss),'; No ave = ',num2str(N_ave)],...
                'fontname','.Vntime','fontsize',12);        
        %%%%%%%
        
    elseif mod_type ==1& ofdm_mod==1        
        title(['Phæ tÝn hiÖu OFDM/QPSK ; TÇn sè trung t©m= ',num2str(f0),...
                'Hz/;',num2str(N_tones),'R_b =1 bps; R_s = ',num2str(f_ss),...
                'No ave = ',num2str(N_ave)],'fontname','.Vntime','fontsize',12);        
    elseif mod_type ==2& ofdm_mod==1        
        title(['Phæ tÝn hiÖu OFDM/OQPSK; TÇn sè trung t©m = ',num2str(f0),...
                'Hz/;',num2str(N_tones),'R_b =1 bps; R_s = ',num2str(f_ss),...
                'No ave = ',num2str(N_ave)],'fontname','.Vntime','fontsize',12);
        
    elseif mod_type ==3& ofdm_mod==1        
        title(['Phæ tÝn hiÖu OFDM/MSK; TÇn sè trung t©m = ',num2str(f0),...
                'Hz/;',num2str(N_tones),'R_b =1 bps; R_s = ',num2str(f_ss),...
                'No ave = ',num2str(N_ave)],'fontname','.Vntime','fontsize',12);
        
    elseif mod_type ==4& ofdm_mod==1        
        title(['Phæ tÝn hiÖu OFDM/16-QAM; TÇn sè trung t©m= ',num2str(f0),...
                'Hz/;',num2str(N_tones),'R_b =1 bps; R_s = ',num2str(f_ss),...
                'No ave = ',num2str(N_ave),'fontname','.Vntime','fontsize',12]);               
    end
    
elseif I_plot ==3|I_plot==4|I_plot==5
    I_filt = input('    Nhap 1 de du lieu duoc loc boi bo loc Butterworth; Nhap 2 neu khong loc:     ');    
    if I_filt ==1        
        BW = input('    Nhap do rong bang thong bo loc: B= [0 den 0.8]R_b: ');
        n_order = input('   Nhap bac bo loc (1,2,3,4) =  ');
        [num,den] = butter(n_order,2*BW/samp_bit);
        y_sig = [];
        zi =[];
        [y_sig,zf] = filter(num,den,sig,zi);
        zi=zf;               
    end
    N_sig = length(sig);
    if I_plot==3
        % Bieu do mat======================================================
        %z_sig =[];
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
            plot(tt,real_eye),
            xlabel('Thêi gian','fontname','.Vntime','fontsize',12),
            ylabel('BiÓu ®å m¾t trªn trôc I ','fontname','.Vntime','fontsize',12);            
            if mod_type ==0 
                title(['BiÓu ®å m¾t tÝn hiÖu BPSK ®­îc läc bëi bé läc Butterworth bËc ',num2str(n_order),' ®é réng b¨ng BW =',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);                
            elseif mod_type ==1&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu QPSK ®­îc läc bëi bé läc Butterworth bËc',num2str(n_order),' cã ®é réng b¨ng BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
            elseif mod_type ==2&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu OQPSK ®­îc läc bëi bé läc butterwort bËc ',num2str(n_order),'cã ®é réng b¨ng BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);                
            elseif mod_type ==3&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu MSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),' cã BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);                
            elseif mod_type ==4&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu 16-QAM ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),'cã BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);                
            elseif mod_type ==0&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu BPSK kh«ng ®­îc läc','fontname','.Vntime','fontsize',12);
            elseif mod_type ==1&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu QPSK kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);                
            elseif mod_type ==2&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu OQPSK kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);                
            elseif mod_type ==3&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu MSK kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);                
            elseif mod_type ==4&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu 16-QAM kh«ng ®­îc läc','fontname','.Vntime','fontsize',12);                
            end
            %Thanh phan Q ============================
            subplot(2,1,2),
            plot(tt,imag_eye),
            xlabel('Thêi gian','fontname','.Vntime','fontsize',12),
            ylabel('BiÓu ®å m¾t trªn trôc Q ','fontname','.Vntime','fontsize',12);            
            if mod_type ==0 %%%%%%%%%%%%%%%%%%                
                title(['BiÓu ®å m¾t tÝn hiÖu BPSK ®­îc läc bëi bé läc Butterworth bËc ',num2str(n_order),' ®é réng b¨ng BW =',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);                
            elseif mod_type ==1&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu QPSK ®­îc läc bëi bé läc Butterworth bËc',num2str(n_order),' cã ®é réng b¨ng BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
            elseif mod_type ==2&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu OQPSK ®­îc läc bëi bé läc butterwort bËc ',num2str(n_order),'cã ®é réng b¨ng BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);                
            elseif mod_type ==3&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu MSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),' cã BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
            elseif mod_type ==4&I_filt==1
                title(['BiÓu ®å m¾t tÝn hiÖu 16-QAM ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),'cã BW=',...
                        num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
            elseif mod_type ==0&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu BPSK kh«ng ®­îc läc','fontname','.Vntime','fontsize',12);
            elseif mod_type ==1&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu QPSK kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);
            elseif mod_type ==2&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu OQPSK kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);
            elseif mod_type ==3&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu MSK kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);
            elseif mod_type ==4&I_filt==2
                title('BiÓu ®å m¾t tÝn hiÖu 16-QAM kh«ng ®­îc läc','fontname','.Vntime','fontsize',12);
            end
            %=========== Note
            if n==2
                hold on
            end            
            subplot(2,1,1), 
            plot(tt,imag_eye); 
            xlabel('Thêi gian ','fontname','.Vntime','fontsize',12);
            ylabel('Thµnh phÇn Q_n','fontname','.Vntime','fontsize',12),...
            if n==2
                hold on
            end             
        end        
    elseif I_plot==4
        % Duong bao =======================================================
        %subplot(2,1,1);
        plot(t,abs(y_sig));        
        if mod_type ==0 
            title(['§­êng bao tÝn hiÖu BPSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),'cã BW= ',...
                    num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
        elseif mod_type ==1
            title(['§­êng bao tÝn hiÖu QPSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),' cã BW= ',...
                    num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
        elseif mod_type ==2
            title(['§­êng bao tÝn hiÖu OQPSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),' cã BW= ',...
                    num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
        elseif mod_type ==3
            title(['§­êng bao tÝn hiÖu MSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),' cã BW= ',...
                    num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);
        elseif mod_type ==4
            title(['§­êng bao tÝn hiÖu 16-QAM ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),'cã BW= ',...
                    num2str(BW),'R_b'],'fontname','.Vntime','fontsize',12);            
        end        
    elseif I_plot==5
        % Bieu do pha =====================================================
        z_sig=[];
        if I_filt==1
            z_sig(1:N_sig-5*samp_bit) = y_sig(5*samp_bit:N_sig-1);
        elseif I_filt==2
            z_sig(1:N_sig-5*samp_bit) = sig(5*samp_bit:N_sig-1);
        end        
        plot(real(z_sig),imag(z_sig));
        axis square;
        xlabel('Thµnh phÇn I','fontname','.Vntime','fontsize',12);
        ylabel('Thµnh phÇn Q','fontname','.Vntime','fontsize',12);        
            if mod_type~=4
                axis([-1.5 1.5 -1.5 1.5]),...
                else
                axis([-4.5 4.5 -4.5 4.5]),...                    
            end        
        if mod_type ==0 & I_filt==1
            title(['BiÓu ®å pha tÝn hiÖu BPSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),'; BW= ',num2str(BW),'R_b'],...
                'fontname','.Vntime','fontsize',12);
        elseif mod_type ==1 & I_filt==1
            title(['BiÓu ®å pha tÝn hiÖu QPSK ; ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),'; BW= ',num2str(BW),'R_b'],...
                'fontname','.Vntime','fontsize',12);
        elseif mod_type ==2 & I_filt==1
            title(['BiÓu ®å pha tÝn hiÖu OQPSK ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),'; BW= ',num2str(BW),'R_b'],...
                'fontname','.Vntime','fontsize',12);            
        elseif mod_type ==3 & I_filt==1
            title(['BiÓu ®å pha tÝn hiÖu MSK ®­îc läc bëi bé läc Butterwort bËc; ',num2str(n_order),'; BW= ',num2str(BW),'R_b'],...
                'fontname','.Vntime','fontsize',12);
        elseif mod_type ==4 & I_filt==1
            title(['BiÓu ®å pha tÝn hiÖu 16-QAM ®­îc läc bëi bé läc Butterwort bËc ',num2str(n_order),' ; BW= ',num2str(BW),'R_b'],...
                'fontname','.Vntime','fontsize',12);            
        elseif mod_type ==0 & I_filt==2
            title('BiÓu ®å pha tÝn hiÖu BPSK, kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);
        elseif mod_type ==1 & I_filt==2
            title('BiÓu ®å pha tÝn hiÖu QPSK, kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);
        elseif mod_type ==2 & I_filt==2
            title('BiÓu ®å pha tÝn hiÖu OQPSK, kh«ng ®­îc läc','fontname','.Vntime','fontsize',12);
        elseif mod_type ==3 & I_filt==2
            title('BiÓu ®å pha tÝn hiÖu MSK, kh«ng ®­îc läc MSK ','fontname','.Vntime','fontsize',12);
        elseif mod_type ==4 & I_filt==2
            title('BiÓu ®å pha tÝn hiÖu 16_QAM, kh«ng ®­îc läc ','fontname','.Vntime','fontsize',12);            
        end       
    end    
end
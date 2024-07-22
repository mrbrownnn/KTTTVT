function h = NVD14MFC2(doppler_freq,Fs,Tb,num_imp)


% Kenh vo tuyen di dong

% mo ta: tao dap ung xung cho kenh vo tuyen di dong
% mo hinh gom 1 duong truyen truc tiep
% 1 duong tre Tb, 1 duong tre 2*Tb;
% cac duong co suy hao 0 dB, -20 dB, va -25 dB tuong ung; 
% mo hinh gis thiet MS co van toc co dinh voi tan so doppler = v/lambda
% trong do v = van toc MS, lambda = buoc song cua song mang

%
% h = mob_rad_chan(doppler_freq,Fs,Tb,num_imp)
%
% inputs: doppler_freq = v/lambda;
% tan so doppler xac dinh toc do tai do kenh thay doi
% Fs = tan so lay mau [1/s]
% Tb = chu ky bit [s] (Fs*Tb phai nguyen)
% num_imp = so luong dap ung xung tao ra
% dau ra: h = ma tran dap ung xung; h(:,k) = dap ung tai thoi diem k
%


if round(Fs*Tb) ~= Fs*Tb   
    error('ERROR in mob_rad_chan: Fs*Tb must ben an integer')
end

% tham so
n_ss        =   2000;                %so luong diem goc de tu do mo phong co trang thai on dinh
% suy hao duong
A0          =   10^(0/10);
A1          =   10^(-20/10);
A2          =   10^(-25/10);
A           =   [A0 A1 A2];

% tre duong theo mau

d1          =   round(Tb*Fs);
d2          =   round(2*Tb*Fs);


% Nhieu Gauss qua 1 bo loc don cuc Butterworth 
[b,a]       =   butter(1,doppler_freq/Fs*2);

h           =   [randn(num_imp + n_ss,1) + j*randn(num_imp + n_ss,1) , ...
        randn(num_imp + n_ss,1) + j*randn(num_imp + n_ss,1) ,...
        randn(num_imp + n_ss,1) + j*randn(num_imp + n_ss,1)];

h           = filter(b,a,h);

% Phuong sai cho moi tap
pwr         =   std(h);
h           =   h./pwr(ones(num_imp + n_ss,1),:).*sqrt(A(ones(num_imp + n_ss,1),:));

% tap delays
h           =   [h(n_ss+1:n_ss + num_imp,1) zeros(num_imp,d1 - 1), ...
        h(n_ss+1:n_ss + num_imp,2) zeros(num_imp,d2 - d1 - 1) ,...
        h(n_ss+1:n_ss + num_imp,3)].';
function h = NVD14MFC1(tau,Fs)

%% Mo hinh Rummler
%
% Mo ta: tao dap ung xung cuar mo hinh 3 duong dan Rummler
% Mo hinh la thong dung cho tan so 6-GHz frequency
%
% h = rummler(tau,Fs)
%
% dau vao: tau = trai tre [s]
% Fs = tan so lay mau [Hz]
% dau ra: h = dap ung xung 
%
% tao B, la 1 phan bo mu voi trung binh  3.8 dB
B           =   expgen(3.8);
% tao A, 1 phan bo Gaussian voi trung binh 24.6*(Bˆ4 + 500)/(Bˆ4 + 800) dB
% va phuong sai 5 dB;
A           =   sqrt(5)*randn + 24.6*(B^4 + 500)/(B^4 + 800);
% tao f_o = theta/(2*pi*tau) trong do theta laf bien ngau nhien voi 1 goc

if rand > 5/6           
    if rand > 0.5       
        theta   =   rand*pi/2 + pi/2;
    else                
        theta   =   rand*pi/2 - pi;
    end
else                    
    theta       =   rand*pi - pi/2;
end
f_o             =   theta/(2*pi*tau);


min_phase       =   rand;
if min_phase > 0.5      
    a           =   exp(-A/20);
    b           =   1 - exp(-B/20);
    if round(tau*Fs) - 1 >= 0;
        h       =   a*[1 zeros(1,round(tau*Fs) - 1) -b*exp(j*2*pi*f_o*tau)];
    else
        h       =   a;
    end
else                    
    ab          =   exp(-A/20);
    b           =   1/(1 - exp(-B/10));
    if round(tau*Fs) - 1 >= 0
        h       =   ab*[-1/b zeros(1,round(tau*Fs) - 1) exp(j*2*pi*f_o*tau)];
    else
        h       =   -ab/b;
    end
end
%==========================================================================
%====================  Sim_MA_03_2_sim_OvsfChannelization =================
%==========================================================================

clc;
clear all;
close all;

SF  = 4;
N   = log2(SF);

% check SF
if rem(N,1)~=0
    error(['SF = ',int2str(SF),': SF must be a power of 2'])
end
% If N is an integer, then we can continue
if SF==1
    y=1;
    return
end
y=1;  % Kh?i t?o mã v?i h? s? SF=1
for k=1:N
   foo=[];
   for m=2:2:pow2(k)
      fee=y(m/2,:);
      foo=[foo;fee fee;fee -fee];
   end
   y = foo
end

% File: NVD5_filterex1.m

clear all;
close all;

n       = 40;						% number of samples
order   = 4;						% filter order
[b,a]   = butter(order,0.1);	    % prototype

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following program segment is the block processing implementation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

in1     = [1,zeros(1,n-1)];		    % input vector
out1    = filter(b,a,in1);		    % output vector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following program segment is the sample-by-sample implementation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sreg    = zeros(1,order+1);		    % initialize shift register
for k=1:n
   if k==1
      in    = 1;					% impulse input
   else
      in    = 0;
   end
   out      = b(1)*in + sreg(1,1);		% determine output
   sreg     = in*b - out*a + sreg;		% update register
   sreg     = [sreg(1,2:(order+1)),0];	% shift
   out2(k)  = out;                      % create output vector
end

%%%%%%%%%%%%%%%%%%
index   = 0:n-1;
subplot(2,1,1)
stem(index,out1)
xlabel('Ch� s� m�u','FontName','.VnTime','color','b','FontSize',12);
ylabel('X� l� kh�i','FontName','.VnTime','color','b','FontSize',12);
% title(['M� ph�ng ch�y hi�u chu�n H� th�ng CDMA v�i tham s�:  SF= ',num2str(SF),...
%      ';  N_s_y_m_b_o_l = ',num2str(N),...
%     ],'FontName','.VnTime','color','b','FontSize',12);
subplot(2,1,2)
stem(index,out2)
xlabel('Ch� s� m�u','FontName','.VnTime','color','b','FontSize',12);
ylabel('X� l� chu�i','FontName','.VnTime','color','b','FontSize',12);
% function y = NVD15_errvector
% File: NVD15_errvector.m

disp(' ')
disp('Cac gia tri mac dinh la:  ')
N = 20000											% default N			
A = [0.8 0.1 0.1; 0.2 0.6 0.2; 0.02 0.08 0.90]		% default A
B = [0.999 0.95 0.99; 0.001 0.05 0.01]				% default B
disp(' ');
disp('Chap nhan cac gia tri mac dinh ? ')
dtype = input('Nhap y neu dong y hoac n neu khong dong y: ','s');
if dtype == 'n'
   N = input('   Nhap so diem L =   ');
   A = input('   Nhap ma tran chuyen dich trang thai A =    ');
   B = input('   Nhap ma tran phan bo loi B=    ');
end
state = 1;							            % initial state
total_states = size(A,1);
out = zeros(1,N);					            % initialize error vector
state_seq = zeros(1,N);			                % initialize state sequence
h = waitbarqa(0,'Xin b¹n h·y chê, ch­¬ng tr×nh ®ang tÝnh vector lçi');
%
u2 = rand(1);	 					            % get random number
if u2>B(1,state)					            % test for error
   out(1) = 1;						            % record error
end
state_seq(1) = state;			                % record state
for t=2:N
   u1 = rand(1);					            % get random number
   cum_sum = [0 cumsum(A(state,:))];
   for i=1:total_states			                % loop to determine new state
      if u1>=cum_sum(i) & u1<cum_sum(i+1);
         state = i;				                % assign new state
      end
   end	
   state_seq(t) = state;		                % new record state
   u2 = rand(1);					            % get random number
   if u2>B(1,state)
      out(t) = 1;					            % record error
   end
   waitbarqa(t/N)
end
close(h)
% function y = NVD15_errvector_test4
% File: c15_errvector.m

N   =   20000;
A   =   a2;
B   =   b2;    

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
% function NVD15_hmmtest
% File: c15_hmmtest.m
clear all;
close all;
NVD15_errvector
pe          = sum(out)/N;
state_sum   = zeros(1,total_states);
for k=1:N
   if state_seq(k)==1
      state_sum(1)=state_sum(1)+1;
   end   
   if state_seq(k)==2
      state_sum(2)=state_sum(2)+1;
   end
   if state_seq(k)==3
      state_sum(3)=state_sum(3)+1;
   end
end
a = ['Xac suat trang thai 1 la: ',num2str(state_sum(1)/N),'.'];
b = ['Xac suat trang thai 2 la:  ',num2str(state_sum(2)/N),'.'];
c = ['Xac suat trang thai 3 la:  ',num2str(state_sum(3)/N),'.'];
d = ['Xac suat loi la: ',num2str(pe),'.'];
disp('Cac ket qua mo phong : ')
disp(a)			% display probability of state 1
disp(b)			% display probability of state 2
disp(c)			% display probability of state 3
disp(d)			% display error probability
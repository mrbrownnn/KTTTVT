function NVD15_MMtransient

% File: c15_MMtransient.m

clear all;
close all;
N           = 100;
pie         = zeros(N,2);
A           = [0.98 0.02; 0.05 0.95];
pie(1,:)    = [0.50 0.50];

for k=2:N
   pie(k,:) = pie(k-1,:)*A;
end
kk          = 1:N;

plot(kk,pie(:,1),'-o',kk,pie(:,2),'+k');
xlabel('L�p [l�n] ','fontname','.Vntime','fontsize',12);
ylabel('X�c su�t','fontname','.Vntime','fontsize',12);
title('Kh�o s�t t�nh h�i t� c�a ph�n b� x�c su�t tr�ng th�i ��n c�c gi� tr� tr�ng th�i b�n v�ng','fontname','.Vntime','color','b','fontsize',12)
text1 = ['Cac xac suat trang thai ben la ',...
      num2str(pie(N,1)),' & ' ,num2str(pie(N,2)),'.'];
legend('Trang thai 1','Trang thai 2',2)
disp(text1)
disp(' ')
disp('Gia tri cua ma tran chuyen dich trang thai A^N la'); A^N

% text1 = ['The steady-state probabilities are ',...
%       num2str(pie(N,1)),' and ' ,num2str(pie(N,2)),'.'];
% legend('Trang thai 1','Trang thai 2',2)
% disp(text1)
% disp(' ')
% disp('The value of A^N is'); A^N
% % % End of script file
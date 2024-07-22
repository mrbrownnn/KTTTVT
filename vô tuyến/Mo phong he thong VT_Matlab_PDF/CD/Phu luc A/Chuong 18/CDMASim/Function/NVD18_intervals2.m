function  [] = NVD18_intervals2(r1,r2);

% The same NVD15_intervals2.m

start1          = find(r1(2,:)==0);                     %find the index of first error free interval
maxLength_1     = max(r1(1,start1(1):2:length(r1)));    %maximum length of the interval
interval_1      = r1(1,start1(1):2:length(r1));         %get the intervals

for i = 1:maxLength_1
    rec_1(i)    =  length(find(interval_1>=i));         %record the intervals
end                                                     %clear the intermediate variable for next runlength
start2          =   find(r2(2,:)==0);                   %find the index of first error free interval
maxLength_2     =   max(r2(1,start2(1):2:length(r2)));  %maximum length of the interval
interval_2      =   r2(1,start2(1):2:length(r2));       %get the intervals
for i = 1:maxLength_2
    rec_2(i)    =  length(find(interval_2>=i));         %record the intervals
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Display Results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,1,1)
plot(1:maxLength_1,rec_1/max(rec_1))
v       = axis;
grid;
ylabel('Pr(0m|1)','fontname','.Vntime','color','b','fontsize',14);
xlabel('Chu�i g�c - Chi�u d�i c�c kho�ng m','fontname','.Vntime','color','b','fontsize',12);

subplot(2,1,2)
plot(1:maxLength_2,rec_2/max(rec_2));
axis([v])
grid;
ylabel('Pr(0m|1)','fontname','.Vntime','color','b','fontsize',14);
xlabel('Chu�i ���c t�i t�o - Chi�u d�i c�c kho�ng  m','fontname','.Vntime','color','b','fontsize',12);
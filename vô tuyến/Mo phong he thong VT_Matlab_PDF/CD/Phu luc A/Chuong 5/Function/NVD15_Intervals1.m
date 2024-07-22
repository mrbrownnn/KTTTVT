function  [] = NVD15_Intervals1(r1);
% File: NVD15_intervals1.m
start           = find(r1(2,:)==0);                     % index of first error free interval
maxLength_1     = max(r1(1,start(1):2:length(r1)));     % maximum length of the interval
interval_1      = r1(1,start(1):2:length(r1));          % get the intervals   
for i = 1:maxLength_1
    rec_1(i)    =  length(find(interval_1>=i));        %record the intervals        
end
int1out         =   rec_1/max(rec_1);
figure;
plot(1:maxLength_1,int1out)
grid;
ylabel('Pr(0m|1)','fontname','.Vntime','fontsize',14);
xlabel('Chieu dµi c¸c kho¶ng m ','fontname','.Vntime','fontsize',12);
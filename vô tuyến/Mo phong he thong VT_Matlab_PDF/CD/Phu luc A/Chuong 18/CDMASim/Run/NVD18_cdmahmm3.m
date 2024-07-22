% File: NVD18_cdmahmm3.m

clc;
clear all;
close all;
load cdmadata1						% load data from c18_cdmahmm1
load cdmadata2						% load data from c18_cdmahmm2

runcode2            = NVD18_seglength(out);

NVD18_intervals2(runcode1,runcode2)	% display intervals

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build histograms.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aa1             = runcode1(1,:);
efd1            = aa1(1:2:length(aa1));
aa2             = runcode2(1,:);
efd2            = aa2(1:2:length(aa2));

figure
subplot(2,1,1)
[N,x]           = hist(efd1,20);        %hist(efd1,x)
bar(x,N,1)
xlabel('Bin bi�u �� th�ng k�','FontName','.VnTime','color','b','FontSize',12);
ylabel('S� m�u','FontName','.VnTime','color','b','FontSize',12);

title('M� ph�ng bi�u �� th�ng k� kh�ng l�i ��i v�i Vector g�c (tr�n) & Vector kh�i ph�c (d��i) ',...
    'FontName','.VnTime','color','b','FontSize',12);
%%%%%%%%%%%%
subplot(2,1,2)
hist(efd2,x);
xlabel('Bin bi�u �� th�ng k�','FontName','.VnTime','color','b','FontSize',12);
ylabel('S� m�u','FontName','.VnTime','color','b','FontSize',12);
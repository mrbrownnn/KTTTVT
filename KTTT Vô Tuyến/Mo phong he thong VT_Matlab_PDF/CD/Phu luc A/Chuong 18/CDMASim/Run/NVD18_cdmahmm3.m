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
xlabel('Bin biÓu ®å thèng kª','FontName','.VnTime','color','b','FontSize',12);
ylabel('Sè mÉu','FontName','.VnTime','color','b','FontSize',12);

title('M« pháng biÓu ®å thèng kª kh«ng lçi ®èi víi Vector gèc (trªn) & Vector kh«i phôc (d­íi) ',...
    'FontName','.VnTime','color','b','FontSize',12);
%%%%%%%%%%%%
subplot(2,1,2)
hist(efd2,x);
xlabel('Bin biÓu ®å thèng kª','FontName','.VnTime','color','b','FontSize',12);
ylabel('Sè mÉu','FontName','.VnTime','color','b','FontSize',12);
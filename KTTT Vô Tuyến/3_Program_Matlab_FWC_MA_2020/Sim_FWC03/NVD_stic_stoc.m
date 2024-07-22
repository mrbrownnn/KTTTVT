% function NVD_stic_stoc
% Measure multiple time spans simultaneously using two pairs of tic/toc calls. To do this,
% measure the minimum and average time to compute a summation of Bessel functions:

clc
clear;

REPS = 1000;   minTime = Inf;   nsum = 10;

tic;  % TIC, pair 1

for i=1:REPS
   tStart = tic;  % TIC, pair 2  
   total = 0;
   for j=1:nsum 
      total = total + besselj(j,REPS);
   end

   tElapsed = toc(tStart);  % TOC, pair 2  
   minTime = min(tElapsed, minTime);
end
averageTime = toc/REPS  % TOC, pair 1  
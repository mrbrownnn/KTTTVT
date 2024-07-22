%-------------------------------------------------------------------------
% Program MA_05_compoversamp2.m: to sample "sample" time
%-------------------------------------------------------------------------

function [iout,qout] = MA_05_compoversamp2(iin, qin, sample)


% *************************************************************
% iin     : input Ich sequence
% qin     : input Qch sequence
% iout    : ich output data sequence
% qout    : qch output data sequence
% sample  : Number of oversamples
% *************************************************************

[h,v] = size(iin);

iout = zeros(h,v*sample);
qout = zeros(h,v*sample);

iout(:,1:sample:1+sample*(v-1)) = iin;
qout(:,1:sample:1+sample*(v-1)) = qin;

%******************************** end of file ********************************
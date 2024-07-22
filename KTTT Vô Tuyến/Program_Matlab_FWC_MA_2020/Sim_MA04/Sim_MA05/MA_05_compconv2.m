%--------------------------------------------------------------------------
% Program MA_05_compconv2.m: to perform convolution between signal and filter
%--------------------------------------------------------------------------

function [iout, qout] = MA_05_compconv2(idata, qdata, filter)


% ****************************************************************
%   idata   : ich data sequcence
%   qdata   : qch data sequcence
%   iout    : ich output data sequence
%   qout    : qch output data sequence
%   filter  : filter tap coefficience
% ****************************************************************

iout = conv2(idata,filter);
qout = conv2(qdata,filter);

%******************************** end of file ********************************
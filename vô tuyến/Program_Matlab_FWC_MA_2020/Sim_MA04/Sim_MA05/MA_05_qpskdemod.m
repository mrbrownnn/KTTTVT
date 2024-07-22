%----------------------------------------------------
% Program MA_05_qpskdemod.m: to perform QPSK demodulation
%----------------------------------------------------

function [demodata] = MA_05_qpskdemod(idata,qdata,para,nd,ml)


%****************** variables *************************
    % idata     : input Ich data
    % qdata     : input Qch data
    % demodata  : demodulated data (para-by-nd matrix)
    % para      : Number of paralell channels
    % nd        : Number of data
    % ml        : Number of modulation levels
                % (QPSK ->2  16QAM -> 4)
% *****************************************************

demodata                            = zeros(para,ml*nd);
demodata((1:para),(1:ml:ml*nd-1))   = idata((1:para),(1:nd))>=0;
demodata((1:para),(2:ml:ml*nd))     = qdata((1:para),(1:nd))>=0;

%******************** end of file ***************************
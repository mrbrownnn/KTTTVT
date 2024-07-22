%--------------------------------------------------------------------------
%------------------------ MA_08_MFC_LTE -----------------------------------
%--------------------------------------------------------------------------

function [outputSymbols, H_channel]= MA_08_MFC_LTE(inputSymbols,channelType,FFTsize)

if channelType=='pedA'
    pedAchannel         = [1 10^(-9.7/20) 10^(-22.8/20)];
    channel             = pedAchannel/sqrt(sum(pedAchannel.^2));
elseif channelType=='vehA'
    vehAchannel         = [1 0 10^(-1/20) 0 10^(-9/20) 10^(-10/20) 0 0 0 10^(-15/20) 0 0 0 10^(-20/20)];
    channel             = vehAchannel/sqrt(sum(vehAchannel.^2));
% elseif channelType=='0000'
%     channel             = 1;
end
H_channel               = fft(channel,FFTsize);
outputSymbols           = filter(channel,1,inputSymbols);
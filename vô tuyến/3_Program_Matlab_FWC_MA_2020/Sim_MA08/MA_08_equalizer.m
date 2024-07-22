%--------------------------------------------------------------------------
%------------------------ MA_08_equalizer ---------------------------------
%--------------------------------------------------------------------------

function outputSamples = MA_08_equalizer(inputSamples,H_channel,...
                                   equalizerType,SNR0)
if equalizerType =='ZERO'
    outputSamples = inputSamples./H_channel;
elseif equalizerType =='MMSE'
    C = conj(H_channel)./(conj(H_channel).*H_channel + 10^(-SNR0/10));
    outputSamples = inputSamples.*C;
end
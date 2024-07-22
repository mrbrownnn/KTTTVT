%--------------------------------------------------------------------------
%------------------------ MA_08_removeCP ----------------------------------
%--------------------------------------------------------------------------

function outputSymbols = MA_08_removeCP(inputSymbols,numSymbols,CPsize)

outputSymbols = inputSymbols(CPsize+1:numSymbols+CPsize);
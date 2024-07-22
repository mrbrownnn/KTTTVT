%--------------------------------------------------------------------------
%------------------------ MA_08_addCP -------------------------------------
%--------------------------------------------------------------------------

function outputSymbols = MA_08_addCP(inputSymbols,numSymbols,CPsize)

outputSymbols = [inputSymbols(numSymbols-CPsize+1:numSymbols) inputSymbols];
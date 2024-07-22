function outputSymbols = removeCP(inputSymbols,numSymbols,CPsize)
outputSymbols = inputSymbols(CPsize+1:numSymbols+CPsize);
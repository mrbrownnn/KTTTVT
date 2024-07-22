function outputSymbols = addCP(inputSymbols,numSymbols,CPsize)
outputSymbols = [inputSymbols(numSymbols-CPsize+1:numSymbols) inputSymbols];
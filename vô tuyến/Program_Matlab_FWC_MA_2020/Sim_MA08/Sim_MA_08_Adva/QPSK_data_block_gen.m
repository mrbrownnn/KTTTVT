function data = QPSK_data_block_gen(dataType,numSymbols)

tmp     = round(rand(2,numSymbols));
tmp     = tmp*2 - 1;
data    = (tmp(1,:) + j*tmp(2,:))/sqrt(2);
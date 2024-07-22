function data = data_block_gen(dataType,numSymbols)
if dataType == 'Q-PSK'
        tmp = round(rand(2,numSymbols));
        tmp = tmp*2 - 1;
        data = (tmp(1,:) + j*tmp(2,:))/sqrt(2);
elseif dataType == '16QAM'
        dataSet = [-3+3i -1+3i 1+3i 3+3i ...
            -3+i -1+i 1+i 3+i ...
            -3-i -1-i 1-i 3-i ...
            -3-3i -1-3i 1-3i 3-3i];
        dataSet = dataSet / sqrt(mean(abs(dataSet).^2));
        tmp = ceil(rand(1,numSymbols)*16);
        for k = 1:numSymbols,
            if tmp(k) == 0
                tmp(k) = 1;
            end
            data(k) = dataSet(tmp(k));
        end
        data = data.';
end
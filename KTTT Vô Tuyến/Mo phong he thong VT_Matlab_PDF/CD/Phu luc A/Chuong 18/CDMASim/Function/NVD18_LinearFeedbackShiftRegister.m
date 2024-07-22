function [y, outstate]    = NVD18_LinearFeedbackShiftRegister(R, generator, instate,N);

if max(generator)>R
    error('The eror1')    
end
if length(instate)>R    
    error('error2')    
end
a   =   sort(generator);
P   =   length(generator);
M   =   length(generator)+1;

for k=1:N
    fee         = instate(generator(2));
    for q=3:P
        fee     = bitxor(fee, instate(generator(q)));        
    end
    instate     =   [fee instate];
    y(k)        =   instate(1);
    instate(M)  =   [];   
end
outstate        = instate;
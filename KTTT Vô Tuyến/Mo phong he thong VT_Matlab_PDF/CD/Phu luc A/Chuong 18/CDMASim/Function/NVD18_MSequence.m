function Sequence = NVD18_MSequence(SF)

SFlog2  =   log2(SF);

if rem(SFlog2,1)~=0
    error('SF must be an integer power of 2');
end;

switch SFlog2
    
    case 3        
        R=3; instate = zeros(1,3); instate(R) = 1;
        N=2^R-1; generator = [0 1 3];
        
    case 4        
        R=4; instate = zeros(1,4); instate(R) = 1;
        N=2^R-1; generator = [0 1 4];
        
    case 5
        R=5; instate = zeros(1,5); instate(R) = 1;
        N=2^R-1; generator = [0 2 5];
        
    case 6
        R=6; instate = zeros(1,6); instate(R) = 1;
        N=2^R-1; generator = [0 1 6];
        
    case 7
        R=7; instate = zeros(1,7); instate(R) = 1;
        N=2^R-1; generator = [0 3 7];

    case 8
        R=8; instate = zeros(1,8); instate(R) = 1;
        N=2^R-1; generator = [0 2 3 4 8];
        
    case 9
        R=9; instate = zeros(1,9); instate(R) = 1;
        N=2^R-1; generator = [0 4 9];

    case 10
        R=10; instate = zeros(1,10); instate(R) = 1;
        N=2^R-1; generator = [0 3 10];

    case 11
        R=11; instate = zeros(1,11); instate(R) = 1;
        N=2^R-1; generator = [0 2 11];

    case 12
        R=12; instate = zeros(1,12); instate(R) = 1;
        N=2^R-1; generator = [0 1 4 6 12];
        
    otherwise
        error('SF must be a power of 2, >=8 and <= 2^12.');       
end

[Sequence, outstate]    = NVD18_LinearFeedbackShiftRegister(R, generator, instate,N);
Sequence                = 1- 2*Sequence;
function NVD15_ext1

u1          =   rand(1);        % get uniform RV1
cum_sum     =   [0 cum_sum(A(state,:))];

for i=1:total_states            % loop to determine new state
    if u1>=cum_sum(i)& u1<cum_sum(i+1);
        state   =   i;          % assign new state
    end
    state_seq(t)=   state;      % new stae
    u2          =   rand(1);    % get uniform RV2
    if u2>B(1,state)
        out(t)  =   1;          % record error
    end
end

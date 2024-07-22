function y_out = delay(y_in,n_delay)

% y_out = delay(y_in,n_delay); shifts the vector y_in to the right 
% by n_delay elements and fills in the vacated elements with 0's
%

N       =   length(y_in);
y_out   =   zeros(size(y_in));

y_out(n_delay+1:N) = y_in(1:N-n_delay);

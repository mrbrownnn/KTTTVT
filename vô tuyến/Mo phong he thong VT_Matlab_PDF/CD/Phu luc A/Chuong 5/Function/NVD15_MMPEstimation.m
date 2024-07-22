% function NVD15_MMPEstimation

%%%%%%%%%%%%%%%%%%%%%%%%%% papge(606)
alpha               =   zeros(len,state); % memmory allocation
for column=1:states
    alpha(1,column) =   pye(1,column)*b(1,column);
    hspace*50em                             % initialization
end

scale(1)    = sum(alpha(1,:));              % normlizazing factor
alpha(1,:)  = alpha(1,:)/scale(1,:);        % normalization
sum1=0;

for t=1:(len-1)                             % induction
    for j=1:states
        for i=1:states
            inner_sum   = alpha(t,i)*p(i,j);
            sum1        = sum1  +   inner_sum;            
        end
        alpha(t+1,j)    = sum1*b(out(t+1)+1,j);
        sum1            = 0;
    end
    scale(t+1)          = sum(alpha(t+1,:));        % normalizazing factor
    alpha(t+1,:)        = alpha(t+1,:)/scale(t+1);  % normalization
end

%%%%%%%%%%%%%%%%%%%%%%%%%% papge(606)

alpha       = zeros(len,states);                    % memory allocation
alpha(1,:)  = pye.*b(1,:);                          % initialization
scale(1)    = sum(alpha(1,:));                      % normalizing factor
alpha(1,:)  = alpha(1,:)/scale(1);                  % normalization

for t=1:len-1                                       % induction
    alpha(t+1,:)    = (alpha(t,:)*p).*b(out(t+1)+1,:);
    scale(t+1)      = sum(alpha(t+1,:));            % normalizing factor
    alpha(t+1,:)    = alpha(t+1,:)/scale(t+1);      % normalization    
end

%%%%%%%%%%%%%%%%%%%%%%%%%% papge(607)

beta        = zeros(len,states);                    % memmory allocation
beta(len,:) = 1/scale(len);                         % initialization and scaling
for t=(len-1):-1:1                                  % induction
    for i = 1:states
        for j = 1:states
            inner_sum = p(i,j)...
                *b(out(t+1)+1,j)*beta(t+1,j);
            sum2        = sum2 + inner_sum;
        end
        beta(t,i)   = sum2;
        sum2        = 0;
    end
    beta(t,:)       = beta(t,:)/scale(t);           % scaling
end
%%%%%%%%%%%%%%%%%
beta        = zeros(len,states);                % memory allocation
beta(len,:) = 1/scale(len);                     % initialization
for t=len-1:-1:1                                % induction
    beta(t,:)=(beta(t+1,:).*b(out(t+1)+1,:))...
        *(p')/scale(t);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Step 2: pape(608)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gamma       = zeros(len,states);                % memory allocation
for i=1:len    
    for j=1:states
        gamma(i,j)  = alpha(i,j)*beta(i,j);     % caculation of gamma variable
    end
    gamma(i,:)=gamma(i,:)/sum(gamma(i,:));    
end

%%%%%%%%%%%%%%%%%%%%%%%

gamma_sum       = zeros(1,states);              % memory allocation
for t = 1:len
    gamma_sum   = gamma_sum + alpha(t,:).*beta(t,:);
end

%%%%%%%%%%%%%%% Page (609)
prob_model_given_seq    = zeros(1,len);             % memory allocation for model
eta                     = zeros(states,states,len); % memory allocation for eta

for t=1:len                                         % Start the loop
    for i =1:states
        prob_model_given_seq    = zeros(1,len);     % memory allocation
        temp(i)                 = alpha(t,i)*beta(t,i);
    end
    prob_model_given_seq(t)     = sum(temp);        % probability of model
end

for i=1:states
    for j=1:states
        for t =1:(len-1)
            eta(i,j,t)=( (alpha(t,i)*p(i,j)...
                *b(out(t+1)+1),j)*beta(t+1,j)));
        end
    end    
end

%%%%%%%%%%%%%%%%%%%%%%%%%% papge(609)

eta             = zeros(states,states);             % memory allocation
sum_eta         = zeros(states,states);             % memory allocation

for t = 1:(len-1)
    for i=1:states
        eta(i,:) = ((alpha(t,i)*(p(i,:)...
            *(b(out(t+1)+1),:))).*beta(t+1,:)));        
    end
    sum_eta     = sum_eta + eta; % adds the values of eta
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% page(609)
for i=1:states
    for j =1:states
        p_estimate(i,j) = sum(eta(i,j,:))/(sum(gamma(:,i))-gamma(len,i));        
    end 
    p_estimate(i,:)     = p_estimate(i,:)/sum(p_estimate(i,:)); % normalization
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Page(610)

for i =1:sates
    for j =1:states
        p_estimate(i,j)     = sum_eta(i,j)...
            /(gamma(i)-alpha(len,i).*beta(len,i)...
            /(sum(alpha(len,:).*beta(len,:))));
    end
    p_estimate(i,:)     = p_estimate(i,:)/sum(p_estimate(i,:));
end

%%%%%%%%%%%%%%%%%%%%%%%%%% page(610)

for j =1:states
    i   = find(out==0);                             % find indices of correct bits    
    for k = 1:length(i)
        sum_gamma       = sum_gamma + gamma(i(k),j);        
    end
    b(1,j)              = sum_gamma/sum(gamma(:,j));
    sum_gamma           = 0;
end

for j = 1:sates
    ii = find(out==1);                              % find the indices of erros
    for k = 1:length(ii)
        sum_gamma       = sum_gamma + gamma(ii(k),j);        
    end
    b(2,j)              = sum_gamma/sum(gamma(:,j));
    sum_gamma           = 0;
end

for i = 1:states
    b(:,i)              = b(:,i)/sum(b(:,i));
end

%%%%%%%%%%%% page(611)

out_0       = find(out==0);                     % find correct bits indices
out_1       = find(out==1);                     % find indices of errors
sum_0       = zeros(1,states);
sum_1       = zeros(1,states);
gamma_sum   = sum(gamma);

for i =1:length(out_0)
    sum_0   = sum_0 +gamma(out_0(i),:);         % adds corrct bits    
end

for i=1:states
    for j =1:2
        if j==1
            b(j,i)  = sum_0(i)/gamma_sum(i);    % elements b error bits            
        end
    end
end

for i = 1:states
    b(:,i)  = b(:,i)/sum(b(:,i));
end
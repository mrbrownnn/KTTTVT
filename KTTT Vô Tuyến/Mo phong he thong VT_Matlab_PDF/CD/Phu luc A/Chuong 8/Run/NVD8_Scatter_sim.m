function NVD8_Scatter_sim

N           =16;
Fd          =1;
Fs          =N*Fd;
Delay       =3;
Symb        =60;
Offset      = 0;
M           =4;
msg_orig    = randsrc(Symb,1,[0:M-1],4321);
msg_tx      = modmap(msg_orig,Fd,Fd,'qask',M);
x           = complex(msg_tx(:,1),msg_tx(:,2));
[y,t]       =rcosflt(x,Fd,Fs);

%%%%% (4)
yy          = y(1 + Delay*N : end - Delay*(N+1));

%%%%%%% (8)
h1 = scatterplot_qa(yy,N);
h2 = scatterplot_qa(yy,1,0,'c');
hold on;
h2 = scatterplot_qa(yy,N,0,'b-.',h2);
hold on;
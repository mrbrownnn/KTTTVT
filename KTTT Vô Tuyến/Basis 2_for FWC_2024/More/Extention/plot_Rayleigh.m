function plot_Rayleigh
delta_ = 1;
r = 0:0.01:3;
a = 0:0.01:3;
[R,A] = meshgrid(r,a);
P = ((R + A)/delta_^2).*exp(-(R.^2 + A.^2)/(2*delta_^2));
mesh(P);
title('Hµm ph©n bè x¸c suÊt Rayleigh','FontName','.Vntime','FontSize',15,'Color','b');
xlabel('r1','FontSize',14,'Color','b');
ylabel('r2','FontSize',14,'Color','b');
zlabel('P(r1,r2)','FontSize',14,'Color','b');

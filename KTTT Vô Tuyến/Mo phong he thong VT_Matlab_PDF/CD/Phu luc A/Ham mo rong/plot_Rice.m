% function plot_Rice(handles)
% axes(handles.axes2);
delta_ = 1;
r = 0:0.01:3;
a = 0:0.01:3;
[R,A] = meshgrid(r,a);
P = (R/delta_^2).*exp(-(R.^2 + A.^2)/(2*delta_^2)).*besselj(0,A.*R/delta_^2);
mesh(P);
title('Hµm ph©n bè x¸c suÊt Rice khi K thay ®æi','FontName','.Vntime','FontSize',14,'Color','b');
xlabel('r','Color','b','FontSize',13);
ylabel('K','Color','b','FontSize',13);
zlabel('p(r, K)','Color','b','FontSize',13);


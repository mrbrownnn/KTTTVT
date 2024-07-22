%function plot_Rayleigh(handles)
%axes(handles.axes1);

delta_ = 1;
r = -3:0.01:3;
a = -3:0.01:3;
[R,A] = meshgrid(r,a);
%P = ((R + A)/delta_^2).*exp(-(R.^2 + A.^2)/(2*delta_^2));
P = 1/(sqrt(2*pi)*delta_)*exp((-R.^2 -A.^2)/(2*delta_^2));
mesh(P);
title('Hµm ph©n bè x¸c suÊt Gaussian','FontName','.Vntime','FontSize',15,'Color','b');
xlabel('x1','FontSize',14,'Color','b');
ylabel('x2','FontSize',14,'Color','b');
zlabel('P(x1,x2)','FontSize',14,'Color','b');

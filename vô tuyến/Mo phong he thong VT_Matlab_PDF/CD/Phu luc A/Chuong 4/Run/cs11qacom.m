function y = cs11qacom

t   =   -2:6/1000:2;
N   =   input('Nhap so hai = [1 3 5 7 9]   ');
c0  =   0.5;
w0  =   pi;
xN  =   c0*ones(1,length(t));  % DC Compoment
h1 = figure(1)
set(h1,'color','g');
set(h1,'Name','Designed by Eng. Nguyen Viet Dam');
for j=1:length(N)
    for k=1:2:N(j)                     % Odd function        
        theta = ((-1)^((k-1)/2)-1)*pi/2;
        xN = xN + 2/k/pi*cos(k*w0*t + theta);
    end
    plot(1:length(xN),xN);
    xN  =   c0*ones(1,length(t));  % DC Compoment
    hold on;    
end
xlabel('Thêi gian t','FontName','.VnTime','color','b','FontSize',9);
ylabel('x_N(t)','FontName','.VnTime','color','b','FontSize',12);
title(['Kh¶o s¸t d¹ng sãng tÝn hiÖu x_N(t) khi sè hai N = ',num2str(N)],'FontName','.VnTime','color','b','FontSize',12);
grid on;
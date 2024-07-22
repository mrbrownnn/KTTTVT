% file: NVD3_mparameters
clc;
clear all;
isieee =1;
format long	e              % display full percision

a = ['Gia tri cua isieee la:    ',num2str(isieee),'.'];
b = ['Gia tri cua eps la:   ',num2str(eps,15),'.'];
c = ['Gia tri cua realmax la:   ',num2str(realmax,15),'.'];
d = ['Gia tri cua realmin la:   ',num2str(realmin,15),'.'];
disp(a)                     % display isieee
disp(b)                     % display eps	
disp(c)                     % display realmax
disp(d)                     % display realmin
format short                % restore default format
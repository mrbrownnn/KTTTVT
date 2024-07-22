% exam1

clc
clear all;
close all;

H   =[-0.7i  0.3-0.3i -0.5-0.4i;
        0.8-0.6i 0.7-1.1i -0.8-1.1i;
        -0.8 0.2 + 0.3i 0.2i;
        -0.1-0.2i 1.2-0.3i -1.7-0.6i];
x   = [1+i -1-i 1+3i].';
n   = [0.6+0.4i 0.4-0.1i 0.7+0.5i 0.2-0.2i].';
y   = H*x + n;

piv_of_H    = pinv(H);

H_H         = piv_of_H*H;

x_hat_ZF    = piv_of_H*y;

W= [-0.2 + 0.7i -0.2+0.1i -0.8+0.4i 0.2-0.2i;
    0.5+0.2i 0.0+0.7i 0.5+0.3i 0.2-0.5i;
    0.4-0.1i 0.3+0.4i 0.5+0.0i -0.7-0.2i];

lengt_W_11 = norm(W(1,:))^2
lengt_W_12 = norm(W(2,:))^2
lengt_W_13 = norm(W(3,:))^2
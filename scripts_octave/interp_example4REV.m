clc; clear; close all

xdat1 = [1; 2; 4];    ydat1 = [1; 3; 3];
xdat2 = [1; 2; 4; 5]; ydat2 = [1; 3; 3; 2];

[c1,tab1] = divdif(xdat1,ydat1);
[c2,tab2] = divdifadd(xdat2,ydat2,tab1);

xgrid = 0:0.01:5;
ygrid1 = interpnewton(xgrid,xdat1,c1);
ygrid2 = interpnewton(xgrid,xdat2,c2);

figure(1)
plot(xgrid,ygrid1,'b')
hold on
plot(xgrid,ygrid2,'g',xdat2,ydat2,'or')
hold off
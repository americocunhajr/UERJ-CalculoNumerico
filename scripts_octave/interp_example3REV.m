clc; clear; close all

xdat = [1; 2; 4]; 
ydat = [1; 3; 3];

xgrid = 0:0.01:5;
ygrid = interplagrange(xdat,ydat,xgrid);

plot(xgrid,ygrid,'b',xdat,ydat,'or')

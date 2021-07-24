clc; clear; close all

beta   = [1/3 1/4 1/5 1/6];
T_beta = [60 96 147 142];

coef_T   = polyfit(beta,T_beta,3);
coef_dT  = polyder(coef_T);
beta_ast = roots(coef_dT)

x1 = 1/6:0.001:1/3;
p = @(x) polyval(coef_T,x);
y1 = p(x1);
figure(1)
plot(beta,T_beta,'om',x1,y1,'-b')
hold on
plot([beta_ast(1) beta_ast(1)],[40 160],'--k')
plot([beta_ast(2) beta_ast(2)],[40 160],'--k')
hold off
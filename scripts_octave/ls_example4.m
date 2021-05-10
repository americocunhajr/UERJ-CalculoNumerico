clc; clear; close all
dados = load('covid19_casos_rio_2020_2021.csv');
mm7 = dados;
for j=7:length(dados)
    mm7(j) = sum(dados(j-6:j))/7;
end
xdata = 1:150; ydata = mm7(xdata)';
A = [xdata; ones(size(xdata))]';
b = log(ydata)';
x = A\b;
yfit = exp(x(2))*exp(x(1)*xdata);
stem(dados,'oc','LineWidth',0.5)
hold on
plot(  mm7,'-.r','LineWidth',1)
plot( yfit,'-k','LineWidth',3)
hold off
xlabel('dias decorridos')
ylabel('novos casos por dia')
set(gca,'FontSize',18)

clc; clear; close all
dados = load('covid19_casos_rio_2020_2021.csv');
mm7 = dados;
for j=7:length(dados)
    mm7(j) = sum(dados(j-6:j))/7;
end
xdata = 1:100; ydata = mm7(xdata)';
N   = @(x,p) p(1)*p(2)*exp(-p(1)*(x-p(3)));
D   = @(x,p) (1+exp(-p(1)*(x-p(3)))).^2;
I   = @(x,p) N(x,p)./D(x,p);
E_2 = @(p) sqrt(sum(I(xdata,p) - ydata).^2/length(ydata));
p2  = fminsearch(E_2,[0.1 8e4 55]);
yfit = I(0:0.1:100,p2);
stem(dados(1:100),'oc','LineWidth',0.5)
hold on
plot(1:100    , mm7(1:100),'-.r','LineWidth',1)
plot(0:0.1:100,       yfit,'-k' ,'LineWidth',3)
hold off
xlabel('dias decorridos')
ylabel('novos casos por dia')
set(gca,'FontSize',18)

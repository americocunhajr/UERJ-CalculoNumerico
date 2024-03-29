
% Universidade do Estado do Rio de Janeiro -UERJ
% Calculo Numerico

% Aula 2 - Noções de Programação para Computação Científica

% Prof. Americo Cunha
% Prof. Augusto Barbosa
% Prof. Luiz Mariano Carvalho
% Profa. Nancy Baygorrea


% Representação Gráfica de Funções

clc
clear

% definindo uma função tipo "handle"
f = @(x) x.^2 - 4*x + 3
g = @(x) sin(2*x+pi/2)

% avaliando as funções
f(1)
g(0)

% definindo séries de dados para a função f
x = 0:1:4
y = f(x)

% plotando o gráfico de f
plot(x,y,'-or')

% definindo séries de dados para a função g
x = 0:0.1:4*pi;
y = g(x);

% plotando o gráfico de g
plot(x,y,'-or')

%{
Funcao para realizar merge de clusters num individuo.
Recebe: individuo (matriz), dados, pesos aptidao; 
Retorna: individuo e tempo gasto.

Para saber quais clusters serao fundidos, precisa calcular aptidao de cada
cluster com seu cluster mais proximo. A melhor fusao sera escolhida.

Lista de saida:
elemento 1: individuo
elemento 2: tempo
%}

function [teste1, teste2] = merge2(a)

    teste1 = a;
    teste2 = ones(2,2);

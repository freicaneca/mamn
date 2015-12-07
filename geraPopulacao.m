%%%%%%%%%%
%
% FUN��O: geraPopulacao - Gera Popula��o inicial
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
% - e1: Constante a ser passada para a fun��o
% - p: Constante a ser passada para a fun��o
%
% SA�DA:
%
% - resultI: o valor da fun��o calculada
%
%%%%%%%%%%
function [] = geraPopulacao(dados, pInicial)

    [r,c] = size(dados);
    
    kMax = round(sqrt(r));
    
    %%%%%%%%%%%%
    % Monta os ranges para gera��o dos valores dos clusters
    %%%%%%%%%%%%
    range = zeros(2,c);
    for i=1:c
        range(1,i) = min(dados(:,i));
        range(2,i) = max(dados(:,i));
    end
    
    
    for i=1:pInicial
        
        k = randi([2,kMax],1);  % N�mero de clusters a serem gerados por indiv�duo
        
    end
    
    

end
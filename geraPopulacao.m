%%%%%%%%%%
%
% FUN��O: geraPopulacao - Gera Popula��o inicial
%
% ENTRADA:
%
% - dados: Base de dados sendo utilizada
% - pInicial: Tamanho da popula��o inicial
%
% SA�DA:
%
% - pop: popula��o inicial gerada
%
%%%%%%%%%%
function [pop] = geraPopulacao(dados, pInicial)

    [r,c] = size(dados);
    
    pop = cell(1, pInicial);  % Popula��o inicial
    
    kMax = round(sqrt(r));
    
    %%%%%%%%%%%%
    % Monta os ranges para gera��o dos valores dos clusters
    %%%%%%%%%%%%
    range = zeros(2,c);
    for i=1:c
        range(1,i) = min(dados(:,i));
        range(2,i) = max(dados(:,i));
    end
    
    %%%%%%%%%%%%
    % Gera toda a popula��o inicial de forma rand�mica
    %%%%%%%%%%%%   
    for i=1:pInicial
        
        k = randi([2,kMax],1);  % N�mero de clusters a serem gerados por indiv�duo

        ind = zeros(k,c);       % Cria o indiv�duo zerado
        
        for j=1:k
            for m=1:c
                minR = range(1,m);
                maxR = range(2,m);
                ind(j,m) = minR + (maxR - minR).*rand(1,1);
            end
        end
        
        pop{i} = ind;
    end
end

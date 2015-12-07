%%%%%%%%%%
%
% FUNÇÃO: fitness
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
% - pesos: Vetor - Pesos das funções no cálculo da função de fitness
%
% SAÍDA:
%
% - result: fitness do cromossomo
%
%%%%%%%%%%
function [filho1, filho2] = crossover(pai1, pai2, nPoints)

    [k1,~] = size(pai1);
    [k2,~] = size(pai2);
    
    if nPoints >= k1
        error('ERROR CROSSOVER: Maior número de cortes do que a quantidade de clusters no pai');
    end
    
    if (k1 > k2)  % Troca os pais entre si
        temp = k2;
        tempPai = pai2;
        
        k2 = k1;
        k1 = temp;
        
        pai2 = pai1;
        pai1 = tempPai;
    end
    
    

end
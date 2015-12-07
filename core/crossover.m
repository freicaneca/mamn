%%%%%%%%%%
%
% FUN��O: fitness
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
% - pesos: Vetor - Pesos das fun��es no c�lculo da fun��o de fitness
%
% SA�DA:
%
% - result: fitness do cromossomo
%
%%%%%%%%%%
function [filho1, filho2] = crossover(pai1, pai2)

    [k1,c1] = size(pai1);
    [k2,~] = size(pai2);
    
    if (k1 > k2)  % Troca os pais entre si
        temp = k2;
        tempPai = pai2;
        
        k2 = k1;
        k1 = temp;
        
        pai2 = pai1;
        pai1 = tempPai;
    end
    
    x1 = randi(k1);
    x2 = randi(k1);
    
    if (x1 > x2)  % SWAP dos valores caso x1 seja maior que x2
        temp = x2;
        x2 = x1;
        x1 = temp;
    end
    
    x3 = randi(k2 - (x2 - x1));
    x4 = x3 + (x2 - x1);
    
    

end
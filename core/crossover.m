%%%%%%%%%%
%
% FUNÇÃO: crossover
%
% ENTRADA:
%
% - pai1: Pai 1 a ser cruzado
% - pai2: Pai 2 a ser cruzado
%
% SAÍDA:
%
% - filho1, filho2: Offsprings resultantes do crossover dos pais
%
%%%%%%%%%%
function [filho1, filho2] = crossover(pai1, pai2)

    [k1,~] = size(pai1);
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
    
    filho1 = [pai1(1:x1,:);pai2(x3+1:x4,:);pai1(x2+1:end,:)];
    filho2 = [pai2(1:x3,:);pai1(x1+1:x2,:);pai2(x4+1:end,:)];

end
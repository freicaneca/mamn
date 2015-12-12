%%%%%%%%%%
%
% FUN��O: i_index - I-index
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
function [resultI] = i_index(ind, dados, e1, p)

    [K, ~] = size(ind);     % Total de clusters

    resultEk = ek(ind,dados);
    resultDk = dk(ind);
    
    % felipe
    resultI = ( (1/K) * (e1/(resultEk+0.0001)) * resultDk )^p;
    %resultI = ( (1/K) * (e1/resultEk) * resultDk )^p;
    
    saveMinMax(resultI);
end

%%%%%%%%%%
%
% FUN��O: ek
%
%%%%%%%%%%
function [resultEk] = ek(ind, dados)
    
    [clusters, ~] = size(ind);
    
    pert = pertinencia(ind, dados);     % a que clusters os dados pertencem
    
    resultEk = 0;
    for i=1:clusters
        
        tempDados = dados(pert == i,:);   % dados pertencentes ao cluster i
        [elements,~] = size(tempDados);
        
        somaDistancias = 0;      
        for j=1:elements
            x = [tempDados(j,:);ind(i,:)];
            
            d = pdist(x)^2;             % dist�ncia ao quadrado
            
            somaDistancias = somaDistancias + d;
        end
        
        resultEk = resultEk + somaDistancias;
    end
end

%%%%%%%%%%
%
% FUN��O: dk
%
%%%%%%%%%%
function [result] = dk(ind)

    distances = pdist(ind);     % distancia entre todos os clusters
    
    result = max(distances);    % maior distancia entre os clusters   
    
end

%%%%%%%%%%
%
% FUN��O: saveMinMax
%
%%%%%%%%%%
function [] = saveMinMax(value)

    global fImin;
    global fImax;
    
    if(~isempty(fImin))
        if(fImin > value)
            fImin = value;
        end
    else
        fImin = value;
    end

    if(~isempty(fImax))
        if(fImax < value)
            fImax = value;
        end
    else
        fImax = value;
    end
end

%%%%%%%%%%
%
% FUNÇÃO: ch - Calinski Harabasz
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
%
% SAÍDA:
%
% - result: o valor da função calculada
%
%%%%%%%%%%
function [result] = ch(ind, dados)

    [K, ~] = size(ind);     % Total de clusters
    [n, ~] = size(dados);   % Total de dados

    tW = traceW(ind,dados);
    tB = traceB(ind,dados);

    result = (tB/(K - 1)) / (tW/(n - 1));
    
    saveMinMax(result);

end

%%%%%%%%%%
%
% FUNÇÃO: traceB
%
%%%%%%%%%%
function [resultTraceB] = traceB(ind, dados)

    [clusters, ~] = size(ind);
    
    pert = pertinencia(ind, dados);         % a que clusters os dados pertencem
    
    centroideDados = mean(dados);

    resultTraceB = 0;
    for i=1:clusters
    
        tempDados = dados(pert == i);       % dados pertencentes ao cluster i
        [elements,~] = size(tempDados);
        
        x = [centroideDados;ind(i,:)];            
        d = pdist(x)^2;                           % distância ao quadrado
        
        resultTraceB = resultTraceB + (elements * d);
    end
    
end

%%%%%%%%%%
%
% FUNÇÃO: traceW
%
%%%%%%%%%%
function [resultTraceW] = traceW(ind, dados)
    
    [clusters, ~] = size(ind);
    
    pert = pertinencia(ind, dados);     % a que clusters os dados pertencem
    
    resultTraceW = 0;
    for i=1:clusters
        
        tempDados = dados(pert == i);   % dados pertencentes ao cluster i
        [elements,~] = size(tempDados);
        
        somaDistancias = 0;      
        for j=1:elements
            x = [tempDados(j,:);ind(i,:)];
            
            d = pdist(x)^2;             % distância ao quadrado
            
            somaDistancias = somaDistancias + d;
        end
        
        resultTraceW = resultTraceW + somaDistancias;
    end
end

%%%%%%%%%%
%
% FUNÇÃO: saveMinMax
%
%%%%%%%%%%
function [] = saveMinMax(value)

    global fchmin;
    global fchmax;
    
    if(~isempty(fchmin))
        if(fchmin > value)
            fchmin = value;
        end
    else
        fchmin = value;
    end

    if(~isempty(fchmax))
        if(fchmax < value)
            fchmax = value;
        end
    else
        fchmax = value;
    end
end
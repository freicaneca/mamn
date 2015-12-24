%%%%%%%%%%
%
% FUN��O: ch - Calinski Harabasz
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
%
% SA�DA:
%
% - result: o valor da fun��o calculada
%
%%%%%%%%%%
function [result] = ch(ind, dados)

    [K, ~] = size(ind);     % Total de clusters
    [n, ~] = size(dados);   % Total de dados

    tW = traceW(ind,dados);
    tB = traceB(ind,dados);

    %felipe
    result = (tB/(K - 1)+0.00001) / (tW/(n - 1+0.00001)+0.00001);
    %result = (tB/(K - 1)) / (tW/(n - 1));
    
    saveMinMax(result);

end

%%%%%%%%%%
%
% FUN��O: traceB
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
        d = pdist(x)^2;                           % dist�ncia ao quadrado
        
        resultTraceB = resultTraceB + (elements * d);
    end
    
end

%%%%%%%%%%
%
% FUN��O: traceW
%
%%%%%%%%%%
function [resultTraceW] = traceW(ind, dados)
    
    [clusters, ~] = size(ind);
    
    pert = pertinencia(ind, dados);     % a que clusters os dados pertencem
    
    resultTraceW = 0;
    for i=1:clusters
        
        tempDados = dados(pert == i,:);   % dados pertencentes ao cluster i
        [elements,~] = size(tempDados);
        
        somaDistancias = 0;      
        for j=1:elements
            
            if(~isempty(tempDados))
                x = [tempDados(j,:);ind(i,:)];

                d = pdist(x)^2;             % dist�ncia ao quadrado

                somaDistancias = somaDistancias + d;
            end
        end
        
        resultTraceW = resultTraceW + somaDistancias;
    end
end

%%%%%%%%%%
%
% FUN��O: saveMinMax
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

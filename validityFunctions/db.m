%%%%%%%%%%
%
% FUNÇÃO: db - Davies-Bouldin
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
function [result] = db(ind, dados)

    [clusters,~] = size(ind);
    
    D = pdist(ind);                         % calcula todas as distâncias euclidianas
    distances = squareform(D);              % matriz de distâncias
    
    s = espacamentos(clusters, ind, dados);     % vetor de espaçamentos
    
    soma = 0;
    for i=1:clusters
        
        max = -1;
        
        for j=1:clusters                       
            if (i ~= j)
                temp = (s(i) + s(j)) / distances(i,j);
                if (temp > max)
                    max = temp;
                end
            end
        end
        
        soma = soma + max;
    end
    
    result = soma / clusters;
    
    saveMinMax(result);  % salva os valores de máximo e mínimo globalmente
    
end

%%%%%%%%%%
%
% FUNÇÃO: espacamentos
%
% ENTRADA:
%
% - totalClusters: Número total de clusters
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
%
% SAÍDA:
%
% - resultS: vetor com os valores dos espaçamentos para todos os clusters
% do cromossomo
%
%%%%%%%%%%
function [resultS] = espacamentos(totalClusters, ind, dados)

    resultS = zeros(totalClusters,1);             % vetor de espaçamentos
    
    pert = pertinencia(ind, dados);               % a que clusters os dados pertencem
    
    for i=1:totalClusters
        
        c = sum(pert == i);                       % quantidade de elementos em um dado cluster
        somaDistancias = 0;
        
        tempDados = dados(pert == i);             % elementos pertencentes ao cluster i
               
        for j=1:c
            
            x = [tempDados(j,:);ind(i,:)];
            d = pdist(x);
            somaDistancias = somaDistancias + d;
        
        end
        
        resultS(i) = somaDistancias/c;
    
    end
end

%%%%%%%%%%
%
% FUNÇÃO: saveMinMax
%
%%%%%%%%%%
function [] = saveMinMax(value)

    global fdbmin;
    global fdbmax;
    
    if(~isempty(fdbmin))
        if(fdbmin > value)
            fdbmin = value;
        end
    else
        fdbmin = value;
    end

    if(~isempty(fdbmax))
        if(fdbmax < value)
            fdbmax = value;
        end
    else
        fdbmax = value;
    end
end

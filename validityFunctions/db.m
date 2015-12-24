%%%%%%%%%%
%
% FUN��O: db - Davies-Bouldin
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
function [result] = db(ind, dados)

    [clusters,~] = size(ind);
    
    D = pdist(ind);                         % calcula todas as dist�ncias euclidianas
    distances = squareform(D);              % matriz de dist�ncias
    
    s = espacamentos(clusters, ind, dados);     % vetor de espa�amentos
    
    soma = 0;
    for i=1:clusters
        
        max = -1;
        
        for j=1:clusters                       
            if (i ~= j)
                % felipe
                %temp = (s(i) + s(j)) / distances(i,j);
                temp = (s(i) + s(j)) / (distances(i,j)+0.00001);
                if (temp > max)
                    max = temp;
                end
            end
        end
        
        soma = soma + max;
    end
    
    result = soma / clusters;
    
    saveMinMax(result);  % salva os valores de m�ximo e m�nimo globalmente
    
end

%%%%%%%%%%
%
% FUN��O: espacamentos
%
% ENTRADA:
%
% - totalClusters: N�mero total de clusters
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
%
% SA�DA:
%
% - resultS: vetor com os valores dos espa�amentos para todos os clusters
% do cromossomo
%
%%%%%%%%%%
function [resultS] = espacamentos(totalClusters, ind, dados)

    resultS = zeros(totalClusters,1);             % vetor de espa�amentos
    
    pert = pertinencia(ind, dados);               % a que clusters os dados pertencem
    
    for i=1:totalClusters
        
        c = sum(pert == i);                       % quantidade de elementos em um dado cluster
        somaDistancias = 0;
        
        tempDados = dados(pert == i,:);             % elementos pertencentes ao cluster i
               
        for j=1:c
            
            if(~isempty(tempDados))
                x = [tempDados(j,:);ind(i,:)];
                d = pdist(x);
                somaDistancias = somaDistancias + d;
            end
        
        end
        
        % felipe
        %resultS(i) = somaDistancias/c;
        resultS(i) = somaDistancias/(c+0.000001);
    
    end
end

%%%%%%%%%%
%
% FUN��O: saveMinMax
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

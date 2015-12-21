%%%%%%%%%%
%
% FUN��O: findLabels - Encontra o Labels nos Clusters
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
% - labels: Labels reais dos dados
%
% SA�DA:
%
% - resultLabels: Labels gerados dos clusters
%
%%%%%%%%%%
function [resultLabels] = findLabels(ind, dados, labels)

    [ri,ci] = size(ind);
    [rd,cd] = size(dados);
    resultLabels = zeros(rd,1);
    tempLabels = zeros(rd,1);

    for i = 1:rd
        temp = [dados(i,:);ind];
        distances = pdist(temp);
        distances = distances(1:ri);    % Pega s� as distancias do ponto para todos os clusters
        
        [~,index] = sort(distances);    % Ordena as distancias procurando a menor
        
        tempLabels(i) = index(1);       % Pega o indice do cluster mais pr�ximo
    end
    
    clusterIndex = zeros(ri,1);
    
    
    



end
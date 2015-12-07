%%%%%%%%%%
%
% FUN��O: ga - Genetic Algorithm
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
function [] = ga(dataset, solutions)

    %%%%%%%%%
    % Carrega dados da base de dados passada
    %%%%%%%%%    
    fprintf('\nDATASET: %s\n', dataset);
    [dados, ~] = loadData(sprintf('data/%s.data', dataset));    % Elimina a coluna de Lables (classes)
    
    %%%%%%%%%
    % Gera popula��o inicial
    %%%%%%%%%
    pop = geraPopulacao(dados, solutions);
    
    
    
    

end
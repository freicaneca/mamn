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
% EXEMPLO DE COMO CHAMAR ESSA FUN��O:
%
% >> ga('wine',100);
%
%%%%%%%%%%
function [] = ga(dataset, solutions)

    %%%%%%%%%
    % Carrega dados da base de dados passada
    %%%%%%%%%    
    fprintf('\nDATASET: %s\n', dataset);
    [dados, ~] = loadData(sprintf('data/%s.data', dataset));    % Elimina a coluna de Labels (classes)
    
    %%%%%%%%%
    % Gera popula��o inicial
    %%%%%%%%%
    pop = geraPopulacao(dados, solutions);
    
    %%%%%%%%%
    % Calcula o Fitness de toda a popula��o inicial
    %%%%%%%%%
    popFitness = zeros(solutions,1);
    pesos = [1/3 1/3 1/3];
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
    end
    

end
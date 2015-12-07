%%%%%%%%%%
%
% FUN��O: ga - Genetic Algorithm
%
% ENTRADA:
%
% - dataset: Base de dados que ser� utilizada
% - solutions: Quantidade de solu��es a serem geradas inicialmente
%
% SA�DA:
%
% - XXXX: XXXXXXXXXXX
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
    
    %%%%%%%%%
    % Calcula o Fitness de toda a popula��o inicial
    %%%%%%%%%
    counter = 0;
    bestFitness = max(popFitness);    

end
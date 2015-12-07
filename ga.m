%%%%%%%%%%
%
% FUNÇÃO: ga - Genetic Algorithm
%
% ENTRADA:
%
% - dataset: Base de dados que será utilizada
% - solutions: Quantidade de soluções a serem geradas inicialmente
%
% SAÍDA:
%
% - XXXX: XXXXXXXXXXX
%
% EXEMPLO DE COMO CHAMAR ESSA FUNÇÃO:
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
    % Gera população inicial
    %%%%%%%%%
    pop = geraPopulacao(dados, solutions);
    
    %%%%%%%%%
    % Calcula o Fitness de toda a população inicial
    %%%%%%%%%
    popFitness = zeros(solutions,1);
    pesos = [1/3 1/3 1/3];
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
    end
    
    %%%%%%%%%
    % Calcula o Fitness de toda a população inicial
    %%%%%%%%%
    counter = 0;
    bestFitness = max(popFitness);    

end
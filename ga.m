%%%%%%%%%%
%
% FUNÇÃO: ga - Genetic Algorithm
%
% ENTRADA:
%
% - dataset: Base de dados que será utilizada
% - solutions: Quantidade de soluções a serem geradas inicialmente
% - stop: Quantidade de gerações a serem executadas sem que o valor de
% melhor fitness seja alterado
%
% SAÍDA:
%
% - bestSolution: Melhor solução de fitness
%
% EXEMPLO DE COMO CHAMAR ESSA FUNÇÃO:
%
% >> ga('wine', 100, 20);
%
%%%%%%%%%%
function [bestSolution] = ga(dataset, solutions, stop)

    pesos = [1/3 1/3 1/3];
    
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
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
    end
    
    %%%%%%%%%
    % Repetição até que o critério de parada seja atingido
    %%%%%%%%%
    counter = 0;
    bestFitness = max(popFitness);
    
    while (counter <= stop)
    
       %%% TODO letra (a)

       %%% TODO letra (b)
       [filho1, filho2] = crossMutacao(pai1, pai2);

       %%% TODO letra (c)

       %%% TODO letra (d)

       %%% TODO letra (e)
        
    end
    
    %%%%%%%%%
    % Seleciona solução com o melhor fitness
    %%%%%%%%%
    popFitness = zeros(solutions,1);
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
    end    
    [~,i] = max(popFitness);
    bestSolution = pop{i};
    
end

%%%%%%%%%%
%
% FUNÇÃO: crossMutacao - Faz o crossover e a mutação
%
%%%%%%%%%%
function [filho1, filho2] = crossMutacao(pai1, pai2)

    [filho1, filho2] = crossover(pai1, pai2);
    [filho1] = mutacao_gauss(filho1, p, sigma, min_valor, max_valor);
    [filho2] = mutacao_gauss(filho2, p, sigma, min_valor, max_valor);

end


%%%%%%%%%%
%
% FUN��O: ga - Genetic Algorithm
%
% ENTRADA:
%
% - dados: data to be used (matrix)
% - solutions: Quantidade de solu��es a serem geradas inicialmente
% - stop: Quantidade de gera��es a serem executadas sem que o valor de
% melhor fitness seja alterado
% - pop: initial population
%
% SA�DA:
%
% - bestSolution: Melhor solu��o de fitness
%
% EXEMPLO DE COMO CHAMAR ESSA FUN��O:
%
% >> ga('wine', 100, 20);
%
%%%%%%%%%%
function [bestSolution, bestInd] = ga(dados, solutions, stop, pop)

    %page_screen_output(0);
    %page_output_immediately(1);
    %debug_on_warning(1)
    %warning("off");

    %%%%%%%%%
    % Hidden variables
    %%%%%%%%%

    % Fitness functions weights
    pesos = [1/3 1/3 1/3];

    % Mutation probability
    p = 0.01;

    % Gaussian mutation standard deviation
    sigma = 1;
    
    % Number of iterations before RTS adaptation begins
    g = stop/4;

    % Name of the local search weights file
    local_search_filename = 'local_search.weights';
    delete(local_search_filename);

    % Setting w_min and w_max
    w_min = round(solutions/20);
    w_max = round(solutions/2);

    %%%%%%%%%
    % Finding minimum and maximum values in data (for mutation)
    %%%%%%%%%
    min_value = min(min(dados));
    max_value = max(max(dados));
    
    %%%%%%%%%
    % Gera popula��o inicial
    %%%%%%%%%
    %pop = geraPopulacao(dados, solutions);
    
    %%%%%%%%%
    % Calcula o Fitness de toda a popula��o inicial
    %%%%%%%%%
    popFitness = zeros(solutions,1);
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
    end
    popFitness(1) = fitness(pop{1}, dados, pesos);  % Escapar do NaN
    
    %%%%%%%%%
    % Repeti��o at� que o crit�rio de parada seja atingido
    %%%%%%%%%
    counter = 0;
    bestFitness = max(popFitness);

    % Initializing number of iterations with no PD improvement
    count_PD = 0;
    PDmax = 1;

    while (counter <= stop)
    
       %%% TODO letra (a)
       % Generating parents indices
       parent_ind = ParesComRepo(solutions);
       
       for i=1:solutions
           popFitness(i) = fitness(pop{i}, dados, pesos);
       end

       % Crossover + mutation
       for i = 1:size(parent_ind,1)
           
           pai1 = pop{parent_ind(i,1)};
           pai2 = pop{parent_ind(i,2)};
           [filho1, filho2] = crossMutacao(pai1, pai2, p, sigma, min_value, max_value);

           % Adding offspring to population
           pop{end+1} = filho1;
           pop{end+1} = filho2;

       end

       % Adaptive local search in the whole population

       for i = 1:length(pop)
            
           pop{i} = controlador_busca_local(pop{i}, bestFitness,...
               local_search_filename, dados, pesos);

       end

       % Picking offspring from the population
       offspring = {pop{solutions+1:end}};

       % Calculating fitness of population

       for i=1:2*solutions
           popFitness(i) = fitness(pop{i}, dados, pesos);
       end
       
       popFitness
       % Adaptive RTS
       %size(pop)
       [pop, PDmax, count_PD] = selecao_RTS_adaptativo({pop{1:solutions}}, popFitness, solutions,...
           offspring, dados, pesos, counter, count_PD, PDmax, w_min, w_max, g);
       counter = counter + 1;
       %size(pop)
        
    end
    
    %%%%%%%%%
    % Seleciona solu��o com o melhor fitness
    %%%%%%%%%
    popFitness = zeros(solutions,1);
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
    end    
    [~,i] = max(popFitness);
    bestInd = pop{i}                % Best Individuo
    bestSolution = popFitness(i);    % Best Fitness Result
    disp('fitness do best ind')
    bestSolution = popFitness(i)    % Best Fitness Result
    disp('rand do best ind')
    rand_index(bestInd, 'wine') 

end

%%%%%%%%%%
%
% FUN��O: crossMutacao - Faz o crossover e a muta��o
%
%%%%%%%%%%
function [filho1, filho2] = crossMutacao(pai1, pai2, p, sigma, min_valor, max_valor)

    [filho1, filho2] = crossover(pai1, pai2);
    [filho1] = mutacao_gauss(filho1, p, sigma, min_valor, max_valor);
    [filho2] = mutacao_gauss(filho2, p, sigma, min_valor, max_valor);

end


%%%%%%%%%%
%
% FUNÇÃO: ga - Genetic Algorithm
%
% ENTRADA:
%
% - data: data to be used (matrix)
% - solutions: Quantidade de soluções a serem geradas inicialmente
% - stop: Quantidade de gerações a serem executadas sem que o valor de
% melhor fitness seja alterado
% - pop: initial population
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
function [bestSolution, bestInd] = ga(data, solutions, stop, pop)

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
    p = 0.05;

    % Gaussian mutation standard deviation
    sigma = 1;
    
    % Number of iterations before RTS adaptation begins
    g = 20;

    % Name of the local search weights file
    local_search_filename = 'local_search.weights';
    delete(local_search_filename);

    % Setting w_min and w_max
    w_min = round(solutions/20);
    w_max = round(solutions/2);

    %%%%%%%%%
    % Carrega dados da base de dados passada
    %%%%%%%%%    
    %fprintf('\nDATASET: %s\n', dataset);
    %[dados, ~] = loadData(sprintf('data/%s.data', dataset));    % Elimina a coluna de Labels (classes)
    dados = data;

    %%%%%%%%%
    % Finding minimum and maximum values in data (for mutation)
    %%%%%%%%%
    min_value = min(min(dados));
    max_value = max(max(dados));
    
    %%%%%%%%%
    % Gera população inicial
    %%%%%%%%%
    %pop = geraPopulacao(dados, solutions);
    
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

    % Initializing number of iterations with no PD improvement
    count_PD = 0;
    PDmax = 1;

    while (counter <= stop)
    
       %%% TODO letra (a)
       % Generating parents indices
       parent_ind = ParesComRepo(solutions);
       
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
       offspring = {pop{solutions:end}};

       % Calculating fitness of offspring

       for i=1:solutions
           popFitness(solutions+i) = fitness(pop{solutions+i}, dados, pesos);
       end
       
       % Adaptive RTS

       [pop, PDmax, count_PD] = selecao_RTS_adaptativo(pop, popFitness, solutions,...
           offspring, dados, pesos, counter, count_PD, PDmax, w_min, w_max, g);

       counter = counter + 1;
        
    end
    
    %%%%%%%%%
    % Seleciona solução com o melhor fitness
    %%%%%%%%%
    popFitness = zeros(solutions,1);
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
    end    
    [~,i] = max(popFitness);
    bestInd = pop{i};                % Best Individuo
    bestSolution = popFitness(i);    % Best Fitness Result

end

%%%%%%%%%%
%
% FUNÇÃO: crossMutacao - Faz o crossover e a mutação
%
%%%%%%%%%%
function [filho1, filho2] = crossMutacao(pai1, pai2, p, sigma, min_valor, max_valor)

    [filho1, filho2] = crossover(pai1, pai2);
    [filho1] = mutacao_gauss(filho1, p, sigma, min_valor, max_valor);
    [filho2] = mutacao_gauss(filho2, p, sigma, min_valor, max_valor);

end


%%%%%%%%%%
%
% FUNCTION: ga_contrib
%
% ENTRADA:
%
% - dataset: Base de dados que será utilizada
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
% >> ga_contrib('wine', 100, 20);
%
%%%%%%%%%%
function [bestSolution, bestInd] = ga_contrib(data, solutions, stop, pop)

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
    p = 0.25;

    % Gradient mutation initial step size
    passo = 1;

    % Gradient mutation number of neighbors to analyze
    n = 4;

    % Name of the local search weights file
    local_search_filename = 'local_search.weights';
    delete(local_search_filename);

    % Setting w_min and w_max
    %w_min = round(solutions/20);
    %w_max = round(solutions/2);

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
    %count_PD = 0;
    %PDmax = 1;

    while (counter <= stop)
    
       %%% TODO letra (a)
       % Generating parents indices
       parent_ind = ParesComRepo(solutions);
       
       % Temporary population to handle gradient mutation
       pop_temp = pop;

       % Crossover + mutation
       for i = 1:size(parent_ind,1)
           
           pai1 = pop{parent_ind(i,1)};
           pai2 = pop{parent_ind(i,2)};

           %[filho1, filho2] = crossMutacao(pai1, pai2, p, sigma, min_value, max_value);

           [filho1, filho2, novo_passo] = crossMutacaoGrad(pai1, pai2, n, passo, pop,...
                popFitness, dados, pesos, p);
           passo = novo_passo;
           % Adding offspring to population
           pop_temp{end+1} = filho1;
           pop_temp{end+1} = filho2;

       end

       % Updating pop
       pop = pop_temp;

       % Adaptive local search in the whole population

       for i = 1:length(pop)
            
           pop{i} = controlador_busca_local(pop{i}, bestFitness,...
               local_search_filename, dados, pesos);

       end

       % Picking offspring from the population
       offspring = pop{solutions:end};

       % Calculating fitness of offspring

       for i=1:solutions
           popFitness(solutions+i) = fitness(pop{solutions+i}, dados, pesos);
       end
       
       % Probabilistic crowding. Picking old population (before generating offspring)
       old_pop = pop{1:solutions};

       pop = crowding_probabilistico(old_pop, popFitness, solutions, parent_ind,...
       offspring, dados, pesos);

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
% FUNÇÃO: crossMutacaoGauss - Faz o crossover e a mutação gaussiana
%
%%%%%%%%%%
function [filho1, filho2] = crossMutacaoGauss(pai1, pai2, p, sigma, min_valor, max_valor)

    [filho1, filho2] = crossover(pai1, pai2);
    [filho1] = mutacao_gauss(filho1, p, sigma, min_valor, max_valor);
    [filho2] = mutacao_gauss(filho2, p, sigma, min_valor, max_valor);

end


%%%%%%%%%%
%
% FUNÇÃO: crossMutacaoGrad - Faz o crossover e a mutação gradiente
%
%%%%%%%%%%
function [filho1, filho2, novo_passo] = crossMutacaoGrad(pai1, pai2, n, passo, pop,...
    popFitness, dados, pesos, p)

    [filho1, filho2] = crossover(pai1, pai2);

    % Checking mutation probability
    num = rand;

    if num < p

        % Gradient mutation returns offspring and gradient step size
        lista_filho1_passo = mutacao_gradiente(filho1, n, passo, pop, popFitness, dados,...
            pesos);
        lista_filho2_passo = mutacao_gradiente(filho2, n, passo, pop, popFitness, dados,...
            pesos);

        % New gradient step size is the mean of both offspring'
        novo_passo = (lista_filho1_passo{2}+lista_filho2_passo{2})/2;

        % New offspring are the first item in offspring list
        filho1 = lista_filho1_passo{1};
        filho2 = lista_filho2_passo{1};

    else

        novo_passo = passo;

    end

end

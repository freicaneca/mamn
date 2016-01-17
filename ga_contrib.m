%%%%%%%%%%
%
% FUNCTION: ga_contrib
%
% ENTRADA:
%
% - dados: Base de dados que ser� utilizada
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
% >> ga_contrib('wine', 100, 20);
%
%%%%%%%%%%
function [bestSolution, bestInd] = ga_contrib(dados, solutions, stop, pop)

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
    p = 0.99;

    % Gradient mutation initial step size
    passo = 0.5;

    % Gradient mutation number of neighbors to analyze
    n = 4;

    % Name of the local search weights file
    local_search_filename = 'local_search.weights';
    delete(local_search_filename);

    %%%%%%%%%
    % Finding minimum and maximum values in data (for mutation)
    %%%%%%%%%
    min_value = min(min(dados));
    max_value = max(max(dados));
    
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
    %count_PD = 0;
    %PDmax = 1;

    while (counter <= stop)
    
       %%% TODO letra (a)
       % Generating parents indices
       parent_ind = ParesComRepo(solutions);
       
       for i=1:solutions
           popFitness(i) = fitness(pop{i}, dados, pesos);
       end
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
           %if any(any(isnan(filho1))) | any(any(isnan(filho2)))
           % error('eh nan!!!');
           %end

       end

       % Updating pop
       pop = pop_temp;

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
       
       % Probabilistic crowding. Picking old population (before generating offspring)
       old_pop = {pop{1:solutions}};
       %disp('pop antiga');
       % old_pop{1:end};
       % offspring{1:end};
       % disp('aptidao antiga');
        %popFitness
       pop = crowding_probabilistico(old_pop, popFitness, solutions, parent_ind,...
       offspring, dados, pesos);
       %disp('pop nova')
       %size(pop)
       % pop{1:end}
       counter = counter + 1;
        
    end
    
    %%%%%%%%%
    % Seleciona solu��o com o melhor fitness
    %%%%%%%%%
    popFitness = zeros(solutions,1);
    for i=1:solutions
        popFitness(i) = fitness(pop{i}, dados, pesos);
        %rand_index(pop{i}, 'wine') 
    end    
    [~,i] = max(popFitness);
    bestInd = pop{i}                % Best Individuo
    %disp('fitness do best ind')
    %bestSolution = popFitness(i)    % Best Fitness Result
    %disp('rand do best ind')
    %rand_index(bestInd, 'wine') 
end

%%%%%%%%%%
%
% FUN��O: crossMutacaoGauss - Faz o crossover e a muta��o gaussiana
%
%%%%%%%%%%
function [filho1, filho2] = crossMutacaoGauss(pai1, pai2, p, sigma, min_valor, max_valor)

    [filho1, filho2] = crossover(pai1, pai2);
    [filho1] = mutacao_gauss(filho1, p, sigma, min_valor, max_valor);
    [filho2] = mutacao_gauss(filho2, p, sigma, min_valor, max_valor);

end


%%%%%%%%%%
%
% FUN��O: crossMutacaoGrad - Faz o crossover e a muta��o gradiente
%
%%%%%%%%%%
function [filho1, filho2, novo_passo] = crossMutacaoGrad(pai1, pai2, n, passo, pop,...
    popFitness, dados, pesos, p)

    [filho1, filho2] = crossover(pai1, pai2);
    %pai1
    %pai2
    %filho1
    %filho2

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
        %filho1
        %filho2

    else

        novo_passo = passo;

    end

end

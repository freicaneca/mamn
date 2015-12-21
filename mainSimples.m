%{
FUNCTION: main.m

DESCRIPTION: Runs the original MAMN algorithm and the modified one (with
crowding and gradient mutation).

INPUTS: 

    - Database file;
    - Population size;
    - Maximum number of generations;
    - The K parameter from Crossvalidation

If 'both', the same generated population will be used for both algorithms.

OUTPUTS (as prints):

    - Best individual for each method;
    - Best fitness for each method.
%}

function [] = mainSimples(dataset, pop_size, max_gen, K)

    %%%%%%%%%
    % Código mais simples com o uso de Crossvalidation (K-fold)
    %%%%%%%%%
    aveFitnessOrig = 0;
    aveFitnessCont = 0;
    
    aveRuntimeOrig = 0;
    aveRuntimeCont = 0;
    
    aveRIOrig = 0;
    aveRICont = 0;

    %%%%%%%%%
    % Carrega dados da base de dados passada
    %%%%%%%%%    
    fprintf('\nDATASET: %s\n', dataset);
    [dados, labels] = loadData(sprintf('data/%s.data', dataset));    % Elimina a coluna de Labels (classes)

    for i = 1:K
        % Generating initial population
        pop = geraPopulacao(dados, pop_size);

        
        % Dados do GA original
        tic;
        [tempFit,ind] = ga(dados, pop_size, max_gen, pop);
        time_original = toc;
        aveFitnessOrig = aveFitnessOrig + tempFit;
        aveRuntimeOrig = aveRuntimeOrig + time_original;
        
        u = findLabels(ind, dados, labels);
        tempRandi = calculo_rand(u,labels);
        
        aveRIOrig = aveRIOrig + tempRandi;

        % Dados do GA modificado
        tic;
        ga_contrib(dados, pop_size, max_gen, pop);
        time_contrib = toc;
    end

end







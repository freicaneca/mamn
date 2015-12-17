%{
FUNCTION: main.m

DESCRIPTION: Runs the original MAMN algorithm and the modified one (with
crowding and gradient mutation).

INPUTS: 

    - Database file;
    - Population size;
    - Maximum number of generations;
    - Algorithm(s) to run:
        - 'both': runs original MAMN and the modified one;
        - 'original': runs only original MAMN;
        - 'modified': runs only modified one.

If 'both', the same generated population will be used for both algorithms.

OUTPUTS (as prints):

    - Best individual for each method;
    - Best fitness for each method.
%}

function [] = main(dataset, pop_size, max_gen, alg)

    %%%%%%%%%
    % Carrega dados da base de dados passada
    %%%%%%%%%    
    fprintf('\nDATASET: %s\n', dataset);
    [dados, ~] = loadData(sprintf('data/%s.data', dataset));    % Elimina a coluna de Labels (classes)

    % Generating initial population
    pop = geraPopulacao(dados, pop_size);
    
    fprintf('\nCHOSEN: %s\n', alg);

    if strcmp(alg, 'both')
    
        fprintf('\n###\nORIGINAL\n###');
        ga(dados, pop_size, max_gen, pop);
        fprintf('\n###\nMODIFIED\n###');
        ga_contrib(dados, pop_size, max_gen, pop);

    elseif strcmp(alg, 'original')

        fprintf('\n###\nORIGINAL\n###');
        ga(dados, pop_size, max_gen, pop);
    
    elseif strcmp(alg, 'modified')

        fprintf('\n###\nMODIFIED\n###');
        ga_contrib(dados, pop_size, max_gen, pop);

    end







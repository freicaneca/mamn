%{
FUNCTION: main.m

DESCRIPTION: Runs the original MAMN algorithm and the modified one (with
crowding and gradient mutation).

INPUTS: 

    - Database file;
    - Population size;
    - Maximum number of generations;
    - The K parameter from number of repeats

If 'both', the same generated population will be used for both algorithms.

OUTPUTS (as prints):

    - Best individual for each method;
    - Best fitness for each method.
%}

function [] = mainSimples(dataset, pop_size, max_gen, K)

    %%%%%%%%%
    % Código mais simples com o uso de K repetições
    %%%%%%%%%
    aveFitnessOrig = 0;
    aveFitnessCont = 0;
    
    aveRuntimeOrig = 0;
    aveRuntimeCont = 0;
    
    aveRIOrig = 0;
    aveRICont = 0;
    
    clustersOrig = zeros(K,1);
    clustersCont = zeros(K,1);

    %%%%%%%%%
    % Carrega dados da base de dados passada
    %%%%%%%%%    
    fprintf('\nDATASET: %s\n', dataset);
    [dados, labels] = loadData(sprintf('data/%s.data', dataset));    % Elimina a coluna de Labels (classes)

    for i = 1:K
        % Generating initial population
        pop = geraPopulacao(dados, pop_size);
       
        %%%%%%%%%%%%%%%%
        % Dados do GA original
        %%%%%%%%%%%%%%%%
        tic;
        [tempFit,ind] = ga(dados, pop_size, max_gen, pop);
        time_original = toc;

        aveFitnessOrig = aveFitnessOrig + tempFit;
        aveRuntimeOrig = aveRuntimeOrig + time_original;
        
        u = findLabels(ind, dados, labels);
        tempRandi = calculo_rand(u,labels);
        
        aveRIOrig = aveRIOrig + tempRandi;
        
        [rInd, ~] = size(ind);
        clustersOrig(i) = rInd; % Número de clusters do resultado

        %%%%%%%%%%%%%%%%
        % Dados do GA modificado
        %%%%%%%%%%%%%%%%
        tic;
        [tempFit,ind] = ga_contrib(dados, pop_size, max_gen, pop);
        time_contrib = toc;
        
        aveFitnessCont = aveFitnessCont + tempFit;
        aveRuntimeCont = aveRuntimeCont + time_contrib;
        
        u = findLabels(ind, dados, labels);
        tempRandi = calculo_rand(u,labels);
        
        aveRICont = aveRICont + tempRandi;
        
        [rInd, ~] = size(ind);
        clustersCont(i) = rInd;
        
    end
    
    aveFitnessOrig = aveFitnessOrig/K;
    aveFitnessCont = aveFitnessCont/K;
    
    aveRuntimeOrig = aveRuntimeOrig/K;
    aveRuntimeCont = aveRuntimeCont/K;
    
    aveRIOrig = aveRIOrig/K;
    aveRICont = aveRICont/K;
    
    %%%%%%%%%%%%%%%%
    % Montagem do arquivo texto com os dados para tabulação
    %%%%%%%%%%%%%%%%
    filename = strcat('dados/', dataset, '.txt');

    fileID = fopen(filename,'w');
    fprintf(fileID,'Média do Fitness - Média do Tempo - Média do RI - #Clusters - Count Cluster\n');
    fprintf(fileID,'Primeira Linha: ORIGINAL\n');
    fprintf(fileID,'Segunda Linha: CONTRIBUIÇÃO\n');

    [MOrig,FOrig] = mode(clustersOrig);
    [MCont,FCont] = mode(clustersCont);
    fprintf(fileID,'%.2f;%.2f;%.2f;%d;%d',aveFitnessOrig,aveRuntimeOrig,aveRIOrig,MOrig,FOrig);
    fprintf(fileID,'%.2f;%.2f;%.2f;%d;%d',aveFitnessCont,aveRuntimeCont,aveRICont,MCont,FCont);
    fclose(fileID);    

end







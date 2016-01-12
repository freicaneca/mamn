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
    % C�digo mais simples com o uso de K repeti��es
    %%%%%%%%%
    aveFitnessOrig = zeros(K,1);
    aveFitnessCont = zeros(K,1);
    
    aveRuntimeOrig = zeros(K,1);
    aveRuntimeCont = zeros(K,1);
    
    aveRIOrig = zeros(K,1);
    aveRICont = zeros(K,1);
    
    clustersOrig = zeros(K,1);
    clustersCont = zeros(K,1);
    
    indOrig = cell(K,1);
    indContrib = cell(K,1);

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

        t1 = tic;
        [tempFit,indOrig{i}] = ga(dados, pop_size, max_gen, pop);
        time_original = toc(t1);

        aveFitnessOrig(i) = tempFit;
        aveRuntimeOrig(i) = time_original;
        
        u = findLabels(indOrig{i}, dados, labels);
        tempRandi = calculo_rand(u,labels);
        
        aveRIOrig(i) = tempRandi;
        
        [rInd, ~] = size(indOrig{i});
        clustersOrig(i) = rInd;    % N�mero de clusters do resultado

        %%%%%%%%%%%%%%%%
        % Dados do GA modificado
        %%%%%%%%%%%%%%%%
        t2 = tic;
        [tempFit,indContrib{i}] = ga_contrib(dados, pop_size, max_gen, pop);
        time_contrib = toc(t2);
        
        aveFitnessCont(i) = tempFit;
        aveRuntimeCont(i) = time_contrib;
        
        u = findLabels(indContrib{i}, dados, labels);
        tempRandi = calculo_rand(u,labels);
        
        aveRICont(i) = tempRandi;
        
        [rInd, ~] = size(indContrib{i});
        clustersCont(i) = rInd;
               
    end
    
    filenameMAT = strcat('mamn/results/', dataset, 'NEW.mat');
    save(filenameMAT);
    
    %%%%%%%%%%%%%%%%
    % Montagem do arquivo texto com os dados para tabula��o
    %%%%%%%%%%%%%%%%
    filename = strcat('mamn/results/', dataset, 'NEW.txt');

    fileID = fopen(filename,'w');
    fprintf(fileID,'Media do Fitness - Media do Tempo - Media do RI - #Clusters - Count Cluster\n');
    fprintf(fileID,'Primeira Linha: ORIGINAL\n');
    fprintf(fileID,'Segunda Linha: CONTRIBUICAO\n');

    [MOrig,FOrig] = mode(clustersOrig);
    [MCont,FCont] = mode(clustersCont);
    fprintf(fileID,'%.2f;%.2f;%.2f;%d;%d\n',mean(aveFitnessOrig),mean(aveRuntimeOrig),mean(aveRIOrig),MOrig,FOrig);
    fprintf(fileID,'%.2f;%.2f;%.2f;%d;%d',mean(aveFitnessCont),mean(aveRuntimeCont),mean(aveRICont),MCont,FCont);
    fclose(fileID);    

end







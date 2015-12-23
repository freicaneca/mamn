%{
Realiza split num individuo. 
Recebe: um individuo, dados;
Retorna: um individuo com um centroide a mais, tempo gasto.

O individuo retornado eh aquele que, depois de dividido, obtiver a melhor
aptidao. Inicialmente todos os centroides serao divididos.

O calculo dos novos centroides sera feito baseado no maior desvio padrao obtido
dentre as dimensoes de cada centroide. Para isso, eh preciso calcular a
pertinencia dos dados a cada centroide. 

Lista de saida:
elemento 1: individuo
elemento 2: tempo
%}

function out_list = split2(ind, data, fitness_w)

    tic;

    [no_cent, dim_cent] = size(ind);
    pertinency_ = pertinencia(ind, data);

    best_fitness = 0;

    for i = 1:no_cent
        
        [candidate, cand_fitness] = subsplit(ind, i, data, fitness_w,...
            pertinency_);

        if cand_fitness > best_fitness
            best_fitness = cand_fitness;
            out_ind = candidate;
        end

    end

    out_list{1} = out_ind;
    out_list{2} = toc;
end



% Function that performs split operation.

function [new_ind, new_fitness] = subsplit(ind, cent_index, data, fitness_w, pertinency)

    % Data belonging to the centroid
    data_pert = data(pertinency==cent_index,:);

    % If no data belongs to centroid, consider all data
    if isempty(data_pert)
        data_pert = data;
    end

    % Finding maximum standard deviation among data_pert dimensions
    [max_std, max_index] = max(std(data_pert));

    % Adding and subtracting to new centroids dimensions
    ind(cent_index, max_index) = max_std + ind(cent_index, max_index);
    new_cent_add = ind(cent_index,:);
    ind(cent_index, max_index) = ind(cent_index, max_index) - 2*max_std;
    new_cent_subtract = ind(cent_index,:);

    ind(cent_index,:) = [];
    new_ind = [ind; new_cent_subtract; new_cent_add];
    new_fitness = fitness(new_ind, data, fitness_w);
end

    

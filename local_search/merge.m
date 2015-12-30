%{
Funcao para realizar merge de clusters num individuo.
Recebe: individuo (matriz), dados, pesos aptidao; 
Retorna: individuo e tempo gasto.

Para saber quais clusters serao fundidos, precisa calcular aptidao de cada
cluster com seu cluster mais proximo. A melhor fusao sera escolhida.

Lista de saida:
elemento 1: individuo
elemento 2: tempo
%}

function out_list = merge(ind, data, fitness_w)

    tic;

    ind
    no_cent = size(ind, 1);
    dim_cent = size(ind, 2);

    % If only two centroid, cannot merge
    if no_cent ~= 2

        % Finding nearest cluster to each of the clusters    
        nearest_indices = proximos(ind);

        % Finding the belongingness of each data sample
        pertinency = pertinencia(ind, data);

        best_fitness = 0;

        % Merging all clusters with the one closest to them    
        for i = 1:no_cent
            
            [candidate, cand_fitness] = submerge(ind, data, i, ...
                nearest_indices(i), pertinency, fitness_w);

            if cand_fitness > best_fitness
                best_fitness = cand_fitness;
                new_ind = candidate;
            end

        end

        time_ = toc;
        out_list{1} = new_ind;
        out_list{2} = time_;

    else

        % Return original individual
        out_list{1} = ind;
        out_list{2} = toc;

    end
end

% Subfunction: merges two centroids.

function [new_ind, new_fitness] = submerge(ind, data, cent1_index, cent2_index, pertinency, fitness_w)

    %cent1_index
    %cent2_index
    % Finding data belonging to both centroids
    data_both = data((pertinency == cent1_index) | (pertinency == cent2_index),:);

    % If no data is assigned to any of those two centroids, return same ind
    if isempty(data_both)
        
        %data_both = data;
        new_ind = ind;
        new_fitness = fitness(new_ind, data, fitness_w);
        return

    end

    % Finding new centroid coordinates related to data_both
    new_cent = mean(data_both);

    % Building new individual with new centroid. Deleting one of them and
    % overwriting the other.
    
    if(cent2_index == 0)
        s = 1;
    end
    
    new_ind = ind;
    new_ind(cent1_index,:) = [];
    new_ind(cent2_index,:) = new_cent;

    new_fitness = fitness(new_ind, data, fitness_w);
end



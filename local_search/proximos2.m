%{
Calcula o centroide mais proximo de cada centroide de um individuo.
Recebe: um individuo (matriz).
Retorna: um vetor do mesmo tamanho do individuo. O valor do elemento no indice i eh o indice do
centroide (numero da linha) mais proximo da linha i.
Ex.:
2 4 1 3

O primeiro centroide tem o segundo como mais proximo; o segundo tem o quarto
como mais proximo; o terceiro tem o primeiro; o quarto tem o terceiro.
%}

function indices = proximos2(ind)
tic;
    dim_cent = size(ind,2);
    qtde_cent = size(ind,1);
    indices = zeros(1, dim_cent);

    % Encontrando o cluster mais proximo a cada um dos clusters
    for i = 1:qtde_cent
        
        % Calculating the difference between ind(i,:) and all other centroids
        % except itself
        %dif = repmat(ind(i,:),(qtde_cent-1),1) - ind((1:qtde_cent~=i),:);
        dif = ind(i,:) - ind((1:qtde_cent~=i),:);

        % Taking the index of the smallest distance
        [~, index_] = min(sum(abs(dif), 2));

        % If index_ is equal to or larger than i, add one (since i has been
        % withdrawn from the difference matrix)

        if index_ >= i
            index_ = index_ + 1;
        end

        indices(i) = index_;
    end
toc

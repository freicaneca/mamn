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

function indices = proximos(ind)

    qtde_cent = size(ind,1);
    indices = zeros(1, qtde_cent);

    % Encontrando o cluster mais proximo a cada um dos clusters
    for i = 1:qtde_cent
        % Centroide atual
        atual_cent = ind(i,:);
        outros = ind;
        outros(i,:) = [];
        
        [r,~] = size(outros);
        
        result = pdist([atual_cent;outros]);
        result = result(1:r);
        
        [~,index] = sort(result);
        
        x = outros(index(1),:);
        
        I = ismember(ind,x,'rows');
        newIndex = find(I == 1);
        
        indices(i) = newIndex(1); % Primeiro índice do elemento mais próximo!
    end
end
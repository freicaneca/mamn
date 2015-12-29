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

    dim_cent = size(ind,2);
    qtde_cent = size(ind,1);
    indices = zeros(1, qtde_cent);

    % Encontrando o cluster mais proximo a cada um dos clusters
    for i = 1:qtde_cent
        % Centroide atual
        atual_cent = ind(i,:);
        % Valor inicial da menor distancia tem que ser alto
        menor_dist = 999999999;

        % Iterando nos outros centroides
        for j = 1:qtde_cent
            % Evitando que calcule a distancia para o proprio atual_cent
            if j ~= i
                % Centroide candidato
                cand_cent = ind(j,:);
                dist = sum(abs(atual_cent - cand_cent)); 
                if dist < menor_dist 
                   menor_dist = dist;
                   indices(i) = j;
                end
            end
        end
    end

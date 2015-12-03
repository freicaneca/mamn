%{
Enche individuo de zeros para permitir calculo de distancia entre individuos de
diferentes quantidades de centroides. 

Recebe: dois individuos (matriz)
Retorna: dois individuos (matriz) com mesma quantidade de dimensoes

Por exemplo: recebe: individuo com 3centroides e outro com 5. os novos
individuos
terao 5 centroides no total.
%}

function new_inds = enche_zeros(ind1, ind2)
    
    no_cent1 = size(ind1, 1);
    no_cent2 = size(ind2, 1);
    dim_cent = size(ind1, 2);

    % Se forem da mesma dimensao, retorna os individuos de entrada

    if no_cent1 == no_cent2
        new_inds = {ind1, ind2}; 
        return
    end

    % Transformando os inds numa linha

    ind1 = mat2ind(ind1);
    ind2 = mat2ind(ind2);

    % Vetor de zeros que sera appended a um dos ind

    vec_zeros = zeros(1, abs(size(ind2,2)-size(ind1,2)));
    
    % Adicionando zeros ao ind com menos centroides

    if no_cent1 < no_cent2
        ind1 = [ind1 vec_zeros];
    elseif no_cent2 < no_cent1
        ind2 = [ind2 vec_zeros];
    end

    % Transformando inds em matriz. Numero de centroides eh max(no_cent2, no_cent1)

    new_inds = {ind2mat(ind1, dim_cent), ind2mat(ind2, dim_cent)};
    
    



    

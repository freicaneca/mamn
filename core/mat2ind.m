%{
Transforma individuo matriz em individuo linha.

Recebe: individuo matriz
Retorna: individuo linha
%}

function new_ind = mat2ind(ind)

    no_cent = size(ind, 1);
    dim_cent = size(ind, 2);

    new_ind = reshape(transpose(ind), 1, no_cent*dim_cent);


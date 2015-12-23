% Transforma um individuo (linha de centroides) numa matrix, onde cada linha
% corresponde a um centroide. Isso torna mais facil a delimitação dos
% centroides.
% Recebe: individuo, dimensao do centroide.
% Retorna: matriz do individuo.

function ind_mat = ind2mat(ind, dim_cent)
    
    no_lines = qtde_cent(ind, dim_cent);
    no_col = dim_cent;

    % Reshape faz o rearranjo por coluna. Entao preciso colocar o numero de
    % linhas igual ao de colunas e depois faco a transposta
    ind_mat = transpose(reshape(ind, no_col, no_lines));
end

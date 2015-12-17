% Calcula a pertinencia de cada dado aos clusters.
% Recebe: individuo (em forma de matriz) e dados;
% Retorna: vetor com numero de elementos igual a quantidade de dados.
% Ex.: [1 3 1 4 2] significa que o primeiro dado pertence ao centroide 1,
% o segundo, ao tres, e assim por diante.

function out_pert = pertinencia(ind, dados)

    qtde_dados = size(dados, 1);
    qtde_cent = size(ind, 1);

    out_pert = zeros(1, qtde_dados);
    for i = 1:qtde_dados
        % Inicializando menor_dist como valor alto
        menor_dist = 999999;
        for j = 1:qtde_cent
            % Calculando distancia entre o dado i e o centroide j
            dist = abs(dados(i) - ind(j));
            if dist < menor_dist
                menor_dist = dist;
                out_pert(i) = j;
            end
        end
    end


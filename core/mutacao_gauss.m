%{
Realiza mutação gaussiana.

Recebe: individuo (matriz), probabilidade de mutacao para cada gen, desvio
padrao, min e max.

Retorna: individuo mutado

%}

function new_ind = mutacao_gauss(ind, p, sigma, min_valor, max_valor)

    no_cent = size(ind, 1);
    dim_cent = size(ind, 2);

    for i = 1:no_cent
        for j = 1:dim_cent
            
            % Sorteia um numero aleatorio entre 0 e 1. Se menor do que p,
            % ind(i,j) vai sofrer mutacao.

            num = rand;
            if num < p
            
                % Sorteia um numero de uma dist normal centrada em ind(i,j). 
                num_p = random('normal', ind(i,j), sigma);
                ind(i,j) = ind(i,j) + num_p;

                if ind(i,j) > max_valor
                    ind(i,j) = max_valor;
                elseif ind(i,j) < min_valor
                    ind(i,j) = min_valor;
                end

            end

        end
    end

    new_ind = ind;
end

%{
Pega n vizinhos proximos de um individuo dentro da populacao.

Recebe: individuo, n, populacao (cell array)
Retorna: vetor com indices dos individuos proximos 

Nota: se o individuo ind estiver dentro da populacao, indices_proximos sempre
tera o indice correspondente ao do proprio individuo,ja que ind eh o mais
proximo dele mesmo.
%}

function indices_proximos = pega_vizinhos_proximos(ind, n, populacao)

    no_cent = size(ind,1);
    dim_cent = size(ind, 2);
    pop_size = length(populacao);

    if n > pop_size
        error("n maior do que tamanho da populacao.");
    end

    % Vetor que armazenara distancias. Elemento 1 eh a distancia entre o
    % individuo e o individuo 1 da populacao. Inicializo tudo com um valor
    % alto.

    dist_vector = 1028*ones(1, pop_size);
    
    for i = 1:pop_size

        % Calculando distancia entre ind e populacao{i}. Mesmo se forem de
        % diferentes dimensoes, a funcao calcula_distancia resolve isso. Ela
        % retorna o vetor diferenca. Como queremos um escalar, pegamos a soma
        % do vetor.

        dist_vector(i) = sum(abs(calcula_diferenca(ind, populacao{i})));
        
    end

    % Pegando os menores valores e seus indices associados
    [valor indice] = sort(dist_vector);

    indices_proximos = indice(1:n);






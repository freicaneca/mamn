%{
Calcula o vetor diferenca entre dois individuos, mesmo que eles tenham
diferentes quantidades de centroides.

Recebe: dois individuos (matriz);
Retorna: um vetor

Nota: o vetor nao eh estritamente positivo! Essa eh uma diferenca, e nao uma
distancia. A distancia eh abs(diferenca).

%}

function diferenca = calcula_diferenca(ind1, ind2)

    no_cent1 = size(ind1, 1);
    no_cent2 = size(ind2, 1);

    new_inds = enche_zeros(ind1, ind2);

    % Individuos tem que estar em linha pra calcular a distancia

    diferenca = mat2ind(new_inds{1}) - mat2ind(new_inds{2});

%{
Realiza a mutacao gradiente. O individuo procura os n individuos mais proximos;
cada individuo mais proximo contribuira para a direcao de movimentacao do
individuo. Essa contribuicao eh proporcional a aptidao de cada individuo
proximo. Logo, quanto maior a aptidao do individuo proximo, maior sera o
deslocamento do individuo nessa direcao. O passo
dessa movimentacao eh autoadaptativo.

Recebe: individuo, n (quantidade de proximos), passo, populacao (cell array), matriz de aptidao;
Retorna: individuo mutado, passo atualizado.
%}

function out_list = mutacao_gradiente(ind, n, passo, populacao, matriz_aptidao)

    no_cent = size(ind, 1);
    dim_cent = size(ind, 2);

    % Pegando indice dos vizinhos proximos  
    indices_proximos = pega_vizinhos_proximos(ind, n, populacao);

    % Construindo um vetor de subpopulacao onde todos os individuos tem o mesmo
    % numero de centroides de ind. Os individuos tambem serao transformados
    % numa linha para facilitar o calculo do gradiente.

    %for i = 1:length(indices_proximos)
    %    ind_linha = reshape(populacao{indices_proximos(i)}, 1, dim_cent*no_cent);
    %    subpop(i,:) = ind_linha;
    %    subpop_aptidao(i) = matriz_aptidao(i);
    %end

    % O vetor que indica a direcao do gradiente eh igual a ind - subpop(i). O
    % sentido pode ser positivo ou negativo, dependendo da diferenca entre
    % aptidao de ind e de subpop(i). Somando as contribuicoes de cada membro de
    % subpop, teremos o gradiente resultante.

    grad = zeros(1, dim_cent);
    for i = indices_proximos
        
        % Calculando aptidao de ind e subtraindo da aptidao de populacao(i)
        dif_aptidao = aptidao_teste(ind) - matriz_aptidao(i);

        % Calculando diferenca entre ind e populacao(i)
        dif_ind = calcula_distancia(ind, populacao{i})(1:dim_cent*no_cent)

        % Calculando distancia
        %grad = grad + dif_aptidao*dif_ind;
    end
    
    grad

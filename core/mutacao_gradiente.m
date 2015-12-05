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

    % Valor de correcao do passo. Mesmo valor utilizado na tese de Cicero
    csi = 1.8;

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

    grad = zeros(1, dim_cent*no_cent);
    for i = indices_proximos
       
        % Calculando aptidao de ind e subtraindo da aptidao de populacao(i)
        dif_aptidao = aptidao_teste(ind) - matriz_aptidao(i);

        % Calculando vetor diferenca entre ind e populacao(i)
        % Como o vetor diferenca pode ter mais/menos dimensoes de no_cent, o
        % deslocamento sera na quantidade de dimensoes permitida pelo ind. Ex.:
        % se ind = [1 1; 2 2] e populacao{i} = [0 0; 1 1; 2 2], temos que a
        % subtracao eh [-1 -1; -1 -1; 2 2], mas ind nao pode se locomover
        % no espaco 3d. Logo, a terceira dimensao sera desprezada, resultando
        % em [-1 -1; -1 -1]

        dif_ind = calcula_diferenca(ind, populacao{i})(1:dim_cent*no_cent);

        % Calculando distancia
        grad = grad + dif_aptidao*dif_ind;
    end
    
    % Como so importa a direcao do gradiente, podemos transforma-lo num vetor
    % unitario dividindo por sua norma.

    grad_norm = grad/norm(grad);

    % Atualizando ind. Sera transformado em linha para ser adicionado ao grad
    % (que esta em linha) multiplicado pelo passo.

    new_ind = mat2ind(ind);
    new_ind = ind2mat(new_ind + passo*grad_norm, dim_cent);

    % Corrigindo passo: se aptidao do individuo original usando passo =
    % sigma*csi for maior do que usando sigma/csi, o proximo sigma sera
    % sigma*csi. Caso contrario, sera sigma/csi.

    ind_produto = ind2mat(mat2ind(ind) + passo*csi*grad_norm, dim_cent);
    ind_divisao = ind2mat(mat2ind(ind) + passo/csi*grad_norm, dim_cent);

    if aptidao_teste(ind_produto) >= aptidao_teste(ind_divisao)
        new_passo = passo*csi;
    else
        new_passo = passo/csi;
    end

    out_list = {new_ind, new_passo};   


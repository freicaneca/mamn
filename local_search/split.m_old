%{
Realiza split num individuo. 
Recebe: um individuo, dados;
Retorna: um individuo com um centroide a mais, tempo gasto.

O individuo retornado eh aquele que, depois de dividido, obtiver a melhor
aptidao. Inicialmente todos os centroides serao divididos.

O calculo dos novos centroides sera feito baseado no maior desvio padrao obtido
dentre as dimensoes de cada centroide. Para isso, eh preciso calcular a
pertinencia dos dados a cada centroide. 

Lista de saida:
elemento 1: individuo
elemento 2: tempo
%}

function out_list = split(ind, dados, pesos_aptidao)

    % Gravando tempo
    tic;

    no_cent = size(ind,1);
    dim_cent = size(ind,2);
    qtde_dados = size(dados,1);
    pertinencia_ = pertinencia(ind, dados); 

    % Lista com os dados pertencentes a cada cluster. O elemento 1 contem umas
    % matriz com os dados que pertencem ao centroide 1, e assim por diante.

    lista_pert = {};

    % Inicializando valores em lista_pert para permitir append
    for i = 1:no_cent
        lista_pert{i} = inf*ones(1,dim_cent);
    end

    % Preenchendo lista_pert e retirando linha de infinito
    for i = 1:qtde_dados
        lista_pert{pertinencia_(i)} = [lista_pert{pertinencia_(i)};dados(i,:)];
    end

    for i = 1:size(lista_pert,2)
        lista_pert{i}(1,:) = [];
    end

    % Calculando maximo desvio padrao de cada dimensao de cada conjunto de pertinencias. Ex.: o
    % conjunto lista_pert{1,:} tera um desvio padrao para cada uma das duas
    % dimensoes. Sera escolhida a dimensao que apresenta maior desvio padrao.

    % Vetor que armazenara todos os desvios padroes maximos (um desvio padrao
    % max para cada centroide)
    desv_max = zeros(1,no_cent);

    % Vetor que armazenara a dimensao que apresenta maior desvio padrao para
    % cada centroide
    dim_max = ones(1,no_cent);

    for i = 1:size(lista_pert,2)
        for j = 1:dim_cent
            desv = std(lista_pert{i}(:,j));
            if desv > desv_max(i)
                desv_max(i) = desv;
                dim_max(i) = j;
            end
        end
    end

    % Como cada centroide sera dividido, sera criado um novo individuo pra cada
    % centroide. Cada novo individuo tera um centroide a mais.

    % no_cent individuos, cada um com no_cent+1 centroides.
    qtde_ind = no_cent;
    new_inds = zeros(no_cent+1, dim_cent, no_cent);

    % Replicando ind em new_inds
    for i = 1:no_cent
        new_inds(1:no_cent,:,i) = ind;

        % A ultima linha eh igual a i-esima. As atualizacoes acontecerao na
        % i-esima e na ultima linhas.
        new_inds(no_cent+1,:,i) = new_inds(i,:,i);

        % Atualizando i-esima linha, somando com desv_max na dim_max
        new_inds(i,dim_max(i),i) = new_inds(i,dim_max(i),i) + desv_max(i);

        % Atualizando ultima linha, subtraindo desv_max na dim_max
        new_inds(no_cent+1,dim_max(i),i) = new_inds(no_cent+1,dim_max(i),i) - desv_max(i);
    end

    % Colocando new_inds numa lista para avaliar aptidao
    new_inds_list = {};
    for i = 1:qtde_ind
        new_inds_list{i} = new_inds(:,:,i);
    end

    out_ind = pega_melhor(new_inds_list, dados, pesos_aptidao);
    out_list{1} = out_ind;
    out_list{2} = toc;




%{
Realiza uma rodada de k-means: atribui os dados aos centroides de um
individuo, e depois calcula os novos centroides.
Recebe: um individuo, dados
Retorna: um individuo com centroides atualizados
%}

function new_ind = kmeans(ind, dados)

    no_cent = size(ind, 1);
    dim_cent = size(ind, 2);
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

    % Calculando novos centroides
    
    new_ind = zeros(no_cent, dim_cent);
    for i = 1:size(lista_pert,2)
        for j = 1:dim_cent
            
            % Pode haver centroides sem pertinencia. 
            if isempty(lista_pert{i}(:,j)) == 0
                new_ind(i,j) = mean(lista_pert{i}(:,j));
            end
        end
    end

    % Corrigindo centroides que nao tiveram pertinencia de nenhum dado
    % Se a i-esima linha de ind nao estiver em pertinencia_, quer dizer que
    % nenhum dado foi atribuido ao i-esimo cluster. Logo, ele deve permanecer
    % inalterado.

    for i = 1:size(ind,1)
        if ismember(i, pertinencia_) == 0
            new_ind(i,:) = ind(i,:);
        end
    end

    
    

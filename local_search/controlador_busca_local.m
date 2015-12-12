%{
Realiza todo o workflow da busca local para um unico individuo.

Recebe: individuo, melhor aptidao, arquivo, dados.
Retorna: individuo atualizado.

O arquivo eh o que contem os pesos/recompensas. Esse arquivo tambem sera
atualizado.
%}

function new_ind = controlador_busca_local(ind, melhor_aptidao, arq_pesos, dados, pesos_aptidao)

    % Abrindo arquivo arq_nome para leitura/escrita. Caso ele nao exista, sera
    % criado (opcao a+ faz isso.)

    arq = fopen(arq_pesos, 'a+');

    % Carregando dados de arq_pesos
    [no_cent_arq op_local_arq peso_arq] = textread(arq_pesos, '%d %d %f');

    % Numero de centroides do individuo
    no_cent = size(ind, 1);

    % Parametro u do calculo de peso
    u = 0.5;

    % Se o arquivo nao tiver entradas de no_cent, roda uma vez split, uma vez
    % merge, povoa o arquivo e retorna o individuo sem mudancas
    
    if ismember(no_cent, no_cent_arq) == 0
        
        % If no_cent = 2, cannot merge.
        if no_cent ~= 2

            % Pegando recompensa/new_ind da operacao de merge (0)
            r_new_ind_merge = recompensa(ind, melhor_aptidao, 0, dados,...
                pesos_aptidao);

            % Calculando peso com essa recompensa. Inicializando w_atual com 0
            r_merge = r_new_ind_merge{1};
            w_merge = calcula_peso(u, 0, r_merge);

            % Escrevendo no arquivo de pesos para merge (0)
            escreve_pesos(no_cent, 0, w_merge, arq_pesos);

        else
            
            % Write 0 reward to the file
            escreve_pesos(no_cent, 0, 0, arq_pesos);

        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Pegando recompensa/new_ind da operacao de split (1)
        r_new_ind_split = recompensa(ind, melhor_aptidao, 1, dados, pesos_aptidao);

        % Calculando peso com essa recompensa. Inicializando w_atual com 0
        r_split = r_new_ind_split{1};
        w_split = calcula_peso(u, 0, r_split);

        % Escrevendo no arquivo de pesos para merge (0)
        escreve_pesos(no_cent, 1, w_split, arq_pesos);

        new_ind = ind;

    % Caso haja alguma entrada com no_cent no arquivo de pesos
    elseif ismember(no_cent, no_cent_arq) == 1
        
        % Precisamos encontrar as linhas onde se encontram as entradas com
        % no_cent no arquivo. Sempre ocorrem duas linhas pra cada no_cent (uma
        % pra split outra pra merge). O objetivo eh povoar o vetor de pesos
        % entregue a roleta.

        for i = 1:size(no_cent_arq,1)
            if no_cent_arq(i) == no_cent

                % Caso op_local seja 0, ou seja, merge, povoa o primeiro
                % elemento de roleta_peso
                if op_local_arq(i) == 0
                    roleta_peso(1) = peso_arq(i);
                
                % Caso seja 1 (split), povoa o segundo
                elseif op_local_arq(i) == 1
                    roleta_peso(2) = peso_arq(i);
                end
            end
        end

        % Sabendo o peso entregue a roleta, chame a funcao roleta para escolher
        % qual op_local sera escolhido
        op_local = roleta(roleta_peso);

        % Calculando recompensa, w e escrevendo no arquivo
        r_ind_list = recompensa(ind, melhor_aptidao, op_local, dados, pesos_aptidao);
        r_atual = r_ind_list{1};

        % Retornando new_ind
        new_ind = r_ind_list{2};

        if r_atual ~= inf

            % w_atual eh o peso de merge ou split dado a roleta. Como 'op_local'
            % so pode ser 0 ou 1, e roleta_peso so tem indices 1 ou 2, o valor
            % de w_atual eh o valor do indice op_local+1. Ex.: caso escolha
            % tenha sido 0 (merge), o w_atual sera o relativo a merge (indice 1
            % de roleta_peso)

            w_novo = calcula_peso(u, roleta_peso(op_local+1), r_atual);
            escreve_pesos(no_cent, op_local, w_novo, arq_pesos);

        end

    end

    % No final de tudo, aplica k-means pra refinar os centroides.
    
    new_ind = kmeans(new_ind, dados);



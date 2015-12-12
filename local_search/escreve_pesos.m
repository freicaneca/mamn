%{
Escreve no arquivo de pesos. Tambem verifica se ja existe uma linha com mesmo
numero de clusters e mesmo operador. Se houver, deleta e atualiza.

Recebe: numero de centroides, operador local escolhido (0 merge ou 1 split), peso calculado, nome do
arquivo.
Retorna: nada. (arquivo escrito)

Formato:
no_cent op_local peso
(quantidades separadas por espaco)
%}

function [] = escreve_pesos(no_cent, op_local, peso, arq_nome)

    % Abrindo arquivo para leitura e escrita
    arq = fopen(arq_nome, 'a+');

    % Armazenando conteudos de arq numa matriz (inteiro, inteiro, float)
    [no_cent_ op_local_ peso_] = textread(arq_nome, '%d %d %f');
    
    % Flag que sera acionada caso seja encontrada uma linha com no_cent e
    % op_local fornecidos
    flag = 0;

    % Procurando se ja existe alguma linha com o no_cent fornecido
    % Lembrando que vetor no_cent_ eh vetor coluna
    for i = 1:size(no_cent_,1)
        if ((no_cent_(i) == no_cent) & (op_local_(i) == op_local))

            flag = 1;
            
            % Atualizando conteudo de peso
            peso_(i) = peso;
            dlmwrite(arq_nome, [no_cent_ op_local_ peso_], ' ')
        end
    end

    % Caso nao tenha sido encontrada linha com no_cent e op_local, escreve no
    % final o conteudo (no_cent, op_local e peso)

    if flag == 0
        fprintf(arq, '%d %d %f\n', no_cent, op_local, peso);
    end
    fclose(arq);

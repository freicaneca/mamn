%{
Calcula a recompensa de um dado operador local.
Recebe: individuo, melhor fitness, um inteiro 0 ou 1 (merge ou split) e dados
Retorna: lista com recompensa (escalar real) e individuo
%}

function out_list = recompensa(ind, melhor_aptidao, op_loc, dados, pesos_aptidao)

    if op_loc == 1
        list = split(ind, dados, pesos_aptidao);
    elseif op_loc == 0
        list = merge(ind, dados, pesos_aptidao);
    elseif op_loc == 2
        
        % Caso a operacao seja nenhuma, a recompensa sera infinito para
        % facilitar o parsing em etapas subsequentes
        out_list = {inf, ind};
        return;
    else
        error ('Operador local: deve ser 0 (merge), 1 (split) ou 2 (nenhum)');
    end

    % Lembrando que list{1} eh o new_ind; list{2} eh o tempo gasto
    new_ind = list{1};
    t = list{2};

    new_aptidao = fitness(new_ind, dados, pesos_aptidao);
    old_aptidao = fitness(ind, dados, pesos_aptidao);
    %rec = (new_aptidao/melhor_aptidao)*(new_aptidao - old_aptidao)/sqrt(t);
    rec = (new_aptidao/(melhor_aptidao+0.00001))*(new_aptidao - old_aptidao);

    if rec < 0
        rec = 0;
    end

    out_list{1} = rec;
    out_list{2} = new_ind;

    

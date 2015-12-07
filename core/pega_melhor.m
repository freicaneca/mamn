%{
Retorna o individuo com aptidao mais alta.
Recebe: cell array contendo mais de um individuo.
Retorna: o individuo com a maior aptidao.

Cada elemento do cell array eh um individuo.
%}

function melhor_ind = pega_melhor(inds, dados, pesos_aptidao)

   qtde_ind = size(inds,2);
   melhor_apt = 0;

   for i = 1:qtde_ind
        aptidao = fitness(inds{i}, dados, pesos_aptidao);
        if aptidao > melhor_apt
           melhor_apt = aptidao;
           melhor_ind = inds{i};
        end
    end

 

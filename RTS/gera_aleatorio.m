
function [ind_selecionado] = gera_aleatorio (w, mi)
%{
%Função que gera "w" valores inteiros aleatórios distintos entre 1 e mi

----------------------------Entradas-----------------------------
 w  = "window" número de valores que serão gerados aleatórios
 mi = valor máximo possível gerado por essa função 
      (representa o número de indivíduos da população)
------------------------------Saída------------------------------
ind_selecionado = vetor (1 x w) com os valores selecionados
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 02/12/2015                                             
Data de atualização: 03/12/2015 
%}

%Gera um vetor (de tamanho "w") com "mi" possíveis valores 
ind_selecionado = randi (mi, [1,w]);

% Verificação de valores repetidos

%{
% Faz a contagem de quanto um determinado valor apareceu
avalia = histc(ind_selecionado, 1:mi);

if all(avalia > 1)
end
%}

for i = 1:(w-1)
    for j = (i+1):w
        if (ind_selecionado (i) == ind_selecionado(j))
            % Se houver um valor igual será selecionado o valor subsequente
            aux = true;
            while (aux)
                ind_selecionado(j) = ind_selecionado(j) + 1;
                % Verificação se o valor encontrado não é superior ao tamanaho da população
                if (ind_selecionado(j) > mi) 
                    ind_selecionado(j) = 1;
                end
                % Verifica se o novo valor é igual aos valores comparados anteriormente
                aux1 = true;
                l = 1;
                while ((l <= i)&&(aux1 == true))
                    if (ind_selecionado (j) == ind_selecionado(l))
                        aux1 = false;
                    end
                    l = l+1;                    
                end 
                if (l == i+1)
                    aux = false;
                end
            end                         
        end
    end
end
end

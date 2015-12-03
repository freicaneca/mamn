
function [ind_selecionado] = gera_aleatorio (w, mi)
%{
%Fun��o que gera "w" valores inteiros aleat�rios distintos entre 1 e mi

----------------------------Entradas-----------------------------
 w  = "window" n�mero de valores que ser�o gerados aleat�rios
 mi = valor m�ximo poss�vel gerado por essa fun��o 
      (representa o n�mero de indiv�duos da popula��o)
------------------------------Sa�da------------------------------
ind_selecionado = vetor (1 x w) com os valores selecionados
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 02/12/2015                                             
Data de atualiza��o: 03/12/2015 
%}

%Gera um vetor (de tamanho "w") com "mi" poss�veis valores 
ind_selecionado = randi (mi, [1,w]);

% Verifica��o de valores repetidos

%{
% Faz a contagem de quanto um determinado valor apareceu
avalia = histc(ind_selecionado, 1:mi);

if all(avalia > 1)
end
%}

for i = 1:(w-1)
    for j = (i+1):w
        if (ind_selecionado (i) == ind_selecionado(j))
            % Se houver um valor igual ser� selecionado o valor subsequente
            aux = true;
            while (aux)
                ind_selecionado(j) = ind_selecionado(j) + 1;
                % Verifica��o se o valor encontrado n�o � superior ao tamanaho da popula��o
                if (ind_selecionado(j) > mi) 
                    ind_selecionado(j) = 1;
                end
                % Verifica se o novo valor � igual aos valores comparados anteriormente
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

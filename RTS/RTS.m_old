function [popNova] = RTS (popVelha, Aptidao, mi, filhos, w, dados, pesos)

%{
Fun��o seleciona os indiv�duos atrav�s do m�todos RTS
que ser�o considerados na gera��o seguinte

----------------------------Entradas-----------------------------
 popVelha = Popula��o ap�s o processo de sele��o de indiv�duos
 filhos = 
 w  = "window" n�mero de valores que ser�o gerados aleat�rios
 mi = valor m�ximo poss�vel gerado por essa fun��o 
      (representa o n�mero de indiv�duos da popula��o)
 Aptidao - Aptidao dos indiv�duos da popula��o

------------------------------Sa�da------------------------------
popNova = Popula��o ap�s o processo de sele��o de indiv�duos
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 07/12/2015                                             
Data de atualiza��o: 07/12/2015 

%}

popNova = popVelha;

%Para cada filho aplicar a sele��o (lambda = mi)
for i = 1:mi
    % Seleciona w indiv�duos a serem comparados com 1 filho
    [indSelec] = gera_aleat (w, mi);
    % Analisa entre os w indiv�duos aquele que for mais proximo do filho em
    % quest�o
    distancia = zeros(1,w);
    for j = 1:w
        distancia(j) = distEuclid( filhos{i}, popNova{indSelec(j)} );
    end
    [~, IndProx] = min(distancia);
    %IndProx � o �ndice do individuo de popNova mais proximo do filho{i}
    IndProx = indSelec(IndProx);
    
    % Comparar filhos{i} com popVelha{IndProx}
    [result_filho] = fitness(filhos{i}, dados, pesos);
    %%%%%
    %Ao colocar Aptidao como entrada n�o � necess�rio calcular a aptid�o de
    %nenhum pai
    %[result_IndProx] = fitness(popNova{IndProx}, dados, pesos);
    %%%%%
    if (result_filho >= Aptidao(IndProx))
        popNova{IndProx} = filhos{i};
    end        
end
end

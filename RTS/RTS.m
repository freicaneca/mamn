function [popNova] = RTS (popVelha, Aptidao, mi, filhos, w, dados, pesos)

%{
Função seleciona os indivíduos através do métodos RTS
que serão considerados na geração seguinte

----------------------------Entradas-----------------------------
 popVelha = População após o processo de seleção de indivíduos
 filhos = 
 w  = "window" número de valores que serão gerados aleatórios
 mi = valor máximo possível gerado por essa função 
      (representa o número de indivíduos da população)
 Aptidao - Aptidao dos indivíduos da população

------------------------------Saída------------------------------
popNova = População após o processo de seleção de indivíduos
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 07/12/2015                                             
Data de atualização: 07/12/2015 

%}

popNova = popVelha;

%Para cada filho aplicar a seleção (lambda = mi)
for i = 1:mi
    % Seleciona w indivíduos a serem comparados com 1 filho
    [indSelec] = gera_aleat (w, mi);
    % Analisa entre os w indivíduos aquele que for mais proximo do filho em
    % questão
    distancia = zeros(1,w);
    for j = 1:w
        distancia(j) = distEuclid( filhos{i}, popNova{indSelec(j)} );
    end
    [~, IndProx] = min(distancia);
    %IndProx é o índice do individuo de popNova mais proximo do filho{i}
    IndProx = indSelec(IndProx);
    
    % Comparar filhos{i} com popVelha{IndProx}
    [result_filho] = fitness(filhos{i}, dados, pesos);
    %%%%%
    %Ao colocar Aptidao como entrada não é necessário calcular a aptidão de
    %nenhum pai
    %[result_IndProx] = fitness(popNova{IndProx}, dados, pesos);
    %%%%%
    if (result_filho >= Aptidao(IndProx))
        popNova{IndProx} = filhos{i};
    end        
end
end

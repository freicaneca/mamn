function [popNova, PDmax, count] = selecao_RTS_adaptativo (P, mi, dados, pesos, geracao, count, PDmax, wmin, wmax, g)
%{
Função que aplica o método de seleção de sobreviventes RTS usando método 
adaptativo

----------------------------Entradas-----------------------------
P - População
mi - número de indivíduos da população
Wmin - valor mínimo permitido de w
Wmax - valor máximo permitido de w
geracao - geracao vigente 
PD - Diversidade da população
PDmax - maior valor de PD registrado
g - número de gerações sem alterações no valor de PD
popVelha = População após o processo de seleção de indivíduos
filhos = População de novos invidíduos 
w  = "window" número de valores que serão gerados aleatórios
mi = valor máximo possível gerado por essa função 
     (representa o número de indivíduos da população)
Aptidao - Aptidao dos indivíduos da população
------------------------------Saída------------------------------
PD - Diversidade da população
Aptidao - Aptidao dos indivíduos da população
w - valor do w do RTS
count - número de gerações sem melhorias no valor de PD
popNova = População após o processo de seleção de indivíduos
-----------------------------------------------------------------


Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 08/12/2015                                             
Data de atualização: 08/12/2015 
%}

[PD, Aptidao] = ajusteAdaptativo (P, mi, dados, pesos);

[w, count, PDmax] = estrategiaAdaptacao (geracao, count, PD, PDmax, wmin, wmax, g);

[popNova] = RTS (popVelha, Aptidao, mi, filhos, w, dados, pesos);
end
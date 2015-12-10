function [popNova, PDmax, count] = selecao_RTS_adaptativo (P, mi, dados, pesos, geracao, count, PDmax, wmin, wmax, g)
%{
Fun��o que aplica o m�todo de sele��o de sobreviventes RTS usando m�todo 
adaptativo

----------------------------Entradas-----------------------------
P - Popula��o
mi - n�mero de indiv�duos da popula��o
Wmin - valor m�nimo permitido de w
Wmax - valor m�ximo permitido de w
geracao - geracao vigente 
PD - Diversidade da popula��o
PDmax - maior valor de PD registrado
g - n�mero de gera��es sem altera��es no valor de PD
popVelha = Popula��o ap�s o processo de sele��o de indiv�duos
filhos = Popula��o de novos invid�duos 
w  = "window" n�mero de valores que ser�o gerados aleat�rios
mi = valor m�ximo poss�vel gerado por essa fun��o 
     (representa o n�mero de indiv�duos da popula��o)
Aptidao - Aptidao dos indiv�duos da popula��o
------------------------------Sa�da------------------------------
PD - Diversidade da popula��o
Aptidao - Aptidao dos indiv�duos da popula��o
w - valor do w do RTS
count - n�mero de gera��es sem melhorias no valor de PD
popNova = Popula��o ap�s o processo de sele��o de indiv�duos
-----------------------------------------------------------------


Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 08/12/2015                                             
Data de atualiza��o: 08/12/2015 
%}

[PD, Aptidao] = ajusteAdaptativo (P, mi, dados, pesos);

[w, count, PDmax] = estrategiaAdaptacao (geracao, count, PD, PDmax, wmin, wmax, g);

[popNova] = RTS (popVelha, Aptidao, mi, filhos, w, dados, pesos);
end
function [popNova, PDmax, count] = selecao_RTS_adaptativo (P, mi, dados, pesos, geracao, count, PDmax, wmin, wmax, g)
%{
Fun��o que aplica o m�todo de sele��o de sobreviventes RTS usando m�todo 
adaptativo


Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 08/12/2015                                             
Data de atualiza��o: 08/12/2015 
%}

[PD, Aptidao] = ajusteAdaptativo (P, mi, dados, pesos);

[w, count, PDmax] = estrategiaAdaptacao (geracao, count, PD, PDmax, wmin, wmax, g);

[popNova] = RTS (popVelha, Aptidao, mi, filhos, w, dados, pesos);
end
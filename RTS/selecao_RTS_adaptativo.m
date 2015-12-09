function [popNova, PDmax, count] = selecao_RTS_adaptativo (P, mi, dados, pesos, geracao, count, PDmax, wmin, wmax, g)
%{
Função que aplica o método de seleção de sobreviventes RTS usando método 
adaptativo


Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 08/12/2015                                             
Data de atualização: 08/12/2015 
%}

[PD, Aptidao] = ajusteAdaptativo (P, mi, dados, pesos);

[w, count, PDmax] = estrategiaAdaptacao (geracao, count, PD, PDmax, wmin, wmax, g);

[popNova] = RTS (popVelha, Aptidao, mi, filhos, w, dados, pesos);
end
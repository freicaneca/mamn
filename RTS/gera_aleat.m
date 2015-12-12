function [ind_selecionados] = gera_aleat (w, mi)
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
%ind_selecionados = datasample(1:mi,w,'Replace',false);
ind_selecionados= randsample(mi, w);
end

function [ind_selecionados] = gera_aleat (w, mi)
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
%ind_selecionados = datasample(1:mi,w,'Replace',false);
ind_selecionados= randsample(mi, w);
end

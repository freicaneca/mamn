function [pares] = ParesComRepo (mi)
%{
Fun��o gera pares de indiv�duos com reposi��o.
Os pares constru�dos ser�o da seguinte forma (n�meros referentes a posi��o 
do vetor << pares >>): 
1-2, 3-4, 5-6 ... mi-1 - mi
----------------------------Entradas-----------------------------
pares - pares de indiv�duos para a recombina��o

------------------------------Sa�da------------------------------
mi - tamanho da popula��o
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 07/12/2015                                             
Data de atualiza��o: 07/12/2015 
%}

pares = zeros(mi/2,2);
for i = 1:(mi/2)
    %Gera dois valores aleat�riamente
    pares(i,:) = datasample(1:mi,2,'Replace',false);
end

end
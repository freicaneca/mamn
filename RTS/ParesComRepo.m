function [pares] = ParesComRepo (mi)
%{
Função gera pares de indivíduos com reposição.
Os pares construídos serão da seguinte forma (números referentes a posição 
do vetor << pares >>): 
1-2, 3-4, 5-6 ... mi-1 - mi
----------------------------Entradas-----------------------------
pares - pares de indivíduos para a recombinação

------------------------------Saída------------------------------
mi - tamanho da população
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 07/12/2015                                             
Data de atualização: 07/12/2015 
%}

pares = zeros(mi/2,2);
for i = 1:(mi/2)
    %Gera dois valores aleatóriamente
    pares(i,:) = datasample(1:mi,2,'Replace',false);
end

end
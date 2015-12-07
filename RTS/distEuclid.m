function distancia = distEuclid(ind1, ind2)
%{
FORTEMENTE BASEADA NA FUN��O calcula_diferenca FEITA POR FELIPE

Fun��o que calcula a dist�ncia euclidiana entre dois indiv�duos

----------------------------Entradas-----------------------------
 ind1, ind2 - Indiv�duos onde ser� calculada a dist�ncia entre eles

------------------------------Sa�da------------------------------
distancia - dist�ncia euclidana entre os individuos de entrada
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 07/12/2015                                             
Data de atualiza��o: 07/12/2015 
%}
    no_cent1 = size(ind1, 1);
    no_cent2 = size(ind2, 1);

    new_inds = enche_zeros(ind1, ind2);
    distancia = norm(mat2ind(new_inds{1}) - mat2ind(new_inds{2}));
    % Individuos tem que estar em linha pra calcular a distancia
end

 
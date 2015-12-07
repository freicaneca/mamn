function distancia = distEuclid(ind1, ind2)
%{
FORTEMENTE BASEADA NA FUNÇÃO calcula_diferenca FEITA POR FELIPE

Função que calcula a distância euclidiana entre dois indivíduos

----------------------------Entradas-----------------------------
 ind1, ind2 - Indivíduos onde será calculada a distância entre eles

------------------------------Saída------------------------------
distancia - distância euclidana entre os individuos de entrada
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 07/12/2015                                             
Data de atualização: 07/12/2015 
%}
    no_cent1 = size(ind1, 1);
    no_cent2 = size(ind2, 1);

    new_inds = enche_zeros(ind1, ind2);
    distancia = norm(mat2ind(new_inds{1}) - mat2ind(new_inds{2}));
    % Individuos tem que estar em linha pra calcular a distancia
end

 
%{
Funcao aptidao apenas para realizacao de testes. 
Recebe: individuo (matriz)
Retorna: aptidao (float)

A funcao simplesmente soma os valores dos centroides.
%}

function aptidao = aptidao_teste(ind)

  no_cent = size(ind,1);
  dim_cent = size(ind,2);

  aptidao = 0;

  for i = 1:no_cent
    for j = 1:dim_cent
        aptidao = aptidao + ind(i,j);
    end
  end
end

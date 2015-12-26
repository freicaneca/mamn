%%%%%%%%%%
%
% FUN��O: fitness
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
% - pesos: Vetor - Pesos das fun��es no c�lculo da fun��o de fitness
%
% SA�DA:
%
% - result: fitness do cromossomo
%
%%%%%%%%%%
function [result] = fitness(ind, dados, pesos)

    resultDB = db(ind, dados);
    resultCH = ch(ind, dados);
    resultI_index = i_index(ind, dados, 2, 2);  % O valor de E1 foi colocado 2 (POR ENQUANTO) <==== OBSERVA��O IMPORTANTE

    normalize_resultDB = normalizeDB(resultDB);
    normalize_resultCH = normalizeCH(resultCH);
    normalize_resultI_index = normalizeI_index(resultI_index);

    result = (pesos(1) * normalize_resultDB) + (pesos(2) * normalize_resultCH) + (pesos(3) * normalize_resultI_index);

end
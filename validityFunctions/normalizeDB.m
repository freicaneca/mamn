%%%%%%%%%%
%
% FUNÇÃO: normalizeDB
%
% ENTRADA:
%
% - fValue: Valor da ser normalizado
%
% SAÍDA:
%
% - result: valor da função normalizada
%
%%%%%%%%%%
function [fLinha] = normalizeDB(fValue)

    global fdbmin;
    global fdbmax;
    
    fLinha = (fValue - fdbmin) / (fdbmax - fdbmin);

end
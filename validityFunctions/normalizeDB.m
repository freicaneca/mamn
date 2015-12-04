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

    fmin = 0;
    fmax = 10;
    
    fLinha = (fValue - fmin) / (fmax - fmin);

end
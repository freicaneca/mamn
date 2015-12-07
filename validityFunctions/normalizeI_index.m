%%%%%%%%%%
%
% FUNÇÃO: normalizeI_index
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
function [fLinha] = normalizeI_index(fValue)

    global fImin;
    global fImax;
    
    fLinha = (fValue - fImin) / (fImax - fImin);

end
%%%%%%%%%%
%
% FUNÇÃO: normalizeCH
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
function [fLinha] = normalizeCH(fValue)

    global fchmin;
    global fchmax;
    
    fLinha = (fValue - fchmin) / (fchmax - fchmin);

end
%%%%%%%%%%
%
% FUN��O: normalizeDB
%
% ENTRADA:
%
% - fValue: Valor da ser normalizado
%
% SA�DA:
%
% - result: valor da fun��o normalizada
%
%%%%%%%%%%
function [fLinha] = normalizeDB(fValue)

    fmin = 0;
    fmax = 10;
    
    fLinha = (fValue - fmin) / (fmax - fmin);

end
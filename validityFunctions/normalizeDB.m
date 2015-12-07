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

    global fdbmin;
    global fdbmax;
    
    fLinha = (fValue - fdbmin) / (fdbmax - fdbmin);

end
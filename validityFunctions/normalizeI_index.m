%%%%%%%%%%
%
% FUN��O: normalizeI_index
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
function [fLinha] = normalizeI_index(fValue)

    global fImin;
    global fImax;
    
    fLinha = (fValue - fImin) / (fImax - fImin);

end
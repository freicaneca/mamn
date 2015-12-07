%%%%%%%%%%
%
% FUN��O: normalizeCH
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
function [fLinha] = normalizeCH(fValue)

    global fchmin;
    global fchmax;
    
    fLinha = (fValue - fchmin) / (fchmax - fchmin);

end
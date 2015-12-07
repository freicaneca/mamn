%%%%%%%%%%
%
% FUNÇÃO: ga - Genetic Algorithm
%
% ENTRADA:
%
% - ind: Cromossomo com os clusters
% - dados: Base de dados sendo utilizada
% - e1: Constante a ser passada para a função
% - p: Constante a ser passada para a função
%
% SAÍDA:
%
% - resultI: o valor da função calculada
%
%%%%%%%%%%
function [] = ga(dataset, solutions)

    fprintf('\nDATASET: %s\n', dataset);

    [dados, ~] = loadData(sprintf('data/%s.data', dataset));

end
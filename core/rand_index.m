% Calculates Rand index.
% Inputs:
%   Individual;
%   Database.
% Output:
%   Rand index.
%
%
% Ex.: rand_index(best_ind, 'wine')

function ri = rand_index(ind, database)

    name = [database '.data'];
    data = loadData(name);
    our_clst = pertinencia(ind, data);
    name = [database 'NEW'];
    a = load(name);
    true_clst = a.labels;
    ri = calculo_rand(our_clst, true_clst);

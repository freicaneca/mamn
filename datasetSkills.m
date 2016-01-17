function [] = datasetSkills(dataset)

    fprintf('\nDATASET: %s\n', dataset);
    
    [data, labels] = loadData(sprintf('data/%s.data', dataset));

    data = [labels,data]; % Juntar dados e labels
    
    [r,c] = size(data);
    
    fprintf('CLASSES: %.2f\n',length(unique(data(:,1))));
    fprintf('FEATURES: %.2f\n',c-1);
    fprintf('INSTANCIAS: %.2f\n',r);
    
end
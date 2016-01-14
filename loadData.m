%
% loadData('data/wine.data');
%
function [data, labels] = loadData(filename)
  file = importdata(filename);
  
  if isstruct(file)
      data = file.data;
      labels = cell2mat(file.textdata);
  else
      data = file(:, 2:size(file, 2));
      data = normalize(data);
      labels = file(:, 1);
  end
end

% Normalizing data
function normalized_data = normalize(data)

    [no_lines, no_cols] = size(data);
    max_ = max(data);
    min_ = min(data);
    for j=1:no_cols
        
        max_j = max_(j);
        min_j = min_(j);
        for i=1:no_lines

            normalized_data(i,j) = (data(i,j) - min_j)/(max_j - min_j);

        end

    end
end

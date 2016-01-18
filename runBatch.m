names = {'iris','glass','transfusion','column','wine'};

tam = size(names,2);

for i=1:tam
    mainSimples(names{i}, 100, 200, 20, 10);
end
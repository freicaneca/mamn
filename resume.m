% =====>>>>>>    TODO

%%%%%%%%%%%%%%%%%%%%%%%%%%
% �ndice de Rand Corrigido
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ajuste das matrizes para valores 1 e 2
rotulosResultado = zeros(300,1);
rotulosResultado(hard(:,3) == 1) = 2;
rotulosResultado(rotulosResultado == 0) = 1;
rotulos(rotulos == 1) = 2;
rotulos(rotulos == 0) = 1;

randIndex = calculo_rand(rotulos,rotulosResultado);

% Volta para 0 e 1
rotulos(rotulos == 1) = 0;
rotulos(rotulos == 2) = 1;
rotulosResultado(rotulosResultado == 1) = 0;
rotulosResultado(rotulosResultado == 2) = 1;

fprintf('\n�ndice de Rand Corrigido: %.4f\n', randIndex);

%%%%%%%%%%%%%%%%%%%%%%%%%%
% C�lculo do Erro
%%%%%%%%%%%%%%%%%%%%%%%%%%

[erro_global, erro_classe] = calculo_erro(rotulosResultado,rotulos);

fprintf('Erro de Classificacao Global: %.4f\n', erro_global);
fprintf('Erro de Classificacao Classe 1: %.4f\n', erro_classe(1));
fprintf('Erro de Classificacao Classe 2: %.4f\n', erro_classe(2));

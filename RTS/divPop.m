function [SubP, b, Aptidao, SubAptidao] = divPop (P, mi,dados, pesos)

%{
%Função que divide a população de indivíduos em subpopulações de acordo com
o número de clusters dos indivíduos

%{
O cell array da população é separado em um cell array de subpopulações onde
uma subpopulação ficará disponível em uma linha do cell array, a primeira
componente de cada linha indicará o número de clusters da subpopulação,
enquanto que a segunda componente indica o número de indivíduos da
subpopulação
%}

----------------------------Entradas-----------------------------
P - População
mi - número de indivíduos da população
------------------------------Saída------------------------------
SubP - Subpopulações
d - dimensão do problema
b - número de subpopulações
Aptidao - vetor contendo a aptidão de todos os indivíduos da população
SubAptidao - cell array contendo a aptidão dos indivíduos seguindo a 
             organização de SubP
----------------------------Variáveis----------------------------
S - vetor contendo o número de clusters de cada indivíduos
c - número de indivíduos numa subpopulação
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 08/12/2015                                             
Data de atualização: 08/12/2015 
%}

% Descubrindo o número de clusters de cada indivíduo da população
S = zeros(1,mi);

for i = 1:mi
    [S(i),~] = size(P{i}); 
end

% Cálculo da aptidão de cada indivíduo
Aptidao = zeros(1,mi);
for i = 1:mi
   Aptidao(1,i) = fitness(P{i}, dados, pesos);
end

% Separação
% Primeira subpopulação
b = 1;
SubP{b,1} = S(1);
SubP{b,3} = P{1};
SubAptidao{b,3} = Aptidao(1);
c = 3;
for i = 2:mi
    if (S(i) == S(1))
        c = c + 1;
        SubP{b,c} = P{i};
        SubAptidao{b,c} = Aptidao(i);
    end
end
SubP{b,2} = c-2;
% Para as outras subpopulações ...

for i = 2:mi
    if all( S(1:(i-1)) ~= S(i))
        b = b + 1;
        SubP{b,1} = S(i);
        SubP{b,3} = P{i};
        SubAptidao{b,3} = Aptidao(i);
        c = 3;
        for j = (i+1):mi
            if (S(j) == S(i))
                c = c + 1;
                SubP{b, c} = P{j};
                SubAptidao{b,c} = Aptidao(i);
            end
        end
        SubP{b, 2} = c-2;
    end
end

end
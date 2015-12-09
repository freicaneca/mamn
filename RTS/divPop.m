function [SubP, b, Aptidao, SubAptidao] = divPop (P, mi,dados, pesos)

%{
%Fun��o que divide a popula��o de indiv�duos em subpopula��es de acordo com
o n�mero de clusters dos indiv�duos

%{
O cell array da popula��o � separado em um cell array de subpopula��es onde
uma subpopula��o ficar� dispon�vel em uma linha do cell array, a primeira
componente de cada linha indicar� o n�mero de clusters da subpopula��o,
enquanto que a segunda componente indica o n�mero de indiv�duos da
subpopula��o
%}

----------------------------Entradas-----------------------------
P - Popula��o
mi - n�mero de indiv�duos da popula��o
------------------------------Sa�da------------------------------
SubP - Subpopula��es
d - dimens�o do problema
b - n�mero de subpopula��es
Aptidao - vetor contendo a aptid�o de todos os indiv�duos da popula��o
SubAptidao - cell array contendo a aptid�o dos indiv�duos seguindo a 
             organiza��o de SubP
----------------------------Vari�veis----------------------------
S - vetor contendo o n�mero de clusters de cada indiv�duos
c - n�mero de indiv�duos numa subpopula��o
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 08/12/2015                                             
Data de atualiza��o: 08/12/2015 
%}

% Descubrindo o n�mero de clusters de cada indiv�duo da popula��o
S = zeros(1,mi);

for i = 1:mi
    [S(i),~] = size(P{i}); 
end

% C�lculo da aptid�o de cada indiv�duo
Aptidao = zeros(1,mi);
for i = 1:mi
   Aptidao(1,i) = fitness(P{i}, dados, pesos);
end

% Separa��o
% Primeira subpopula��o
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
% Para as outras subpopula��es ...

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
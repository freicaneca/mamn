function [PD, Aptidao] = ajusteAdaptativo (P, mi, dados, pesos)
%{
%Fun��o que disp�e o valor de PD e da aptid�o da popula��o de pais

----------------------------Entradas-----------------------------
P - Popula��o
mi - n�mero de indiv�duos da popula��o
Wmin - valor m�nimo permitido de w
Wmax - valor m�ximo permitido de w
------------------------------Sa�da------------------------------
PD - Diversidade da popula��o
Aptidao - Aptidao dos indiv�duos da popula��o
----------------------------Vari�veis----------------------------
b - n�mero de subpopula��es
SubP - subpopula��es (onde os indiv�duos possuem o mesmo n�mero de clusters)
cmax - valor m�ximo de colunas de SubP
S - vetor contendo o n�mero de clusters de cada indiv�duos
c - n�mero de indiv�duos numa subpopula��o
k - n�mero de clusters de um indiv�duo 
d - dimens�o dos dados
fave - m�dia da aptid�o de toda a popula��o
fi - aptid�o do indiv�duo i
wi = fi/fave
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 08/12/2015                                             
Data de atualiza��o: 08/12/2015 
%}

% Dividindo a Popula��o em Subpopula��es, cada linha do array SubP
% representa uma subpopula��o, o primeiro elemento da linha indica o n�mero
% de cluster da subpopula��o (k), enquanto que a segunda componente indica 
% o n�mero de indiv�duos da subpopula��o (c)

[SubPi, b, Aptidao, SubAptidao] = divPop (P, mi,dados, pesos);
[SubP] = ordenamento (SubPi, b);

% Execu��o das etapas 1 at� 3 do artigo (p�gina 730):
% _______________________________Etapa 1___________________________________
% Equa��o 8 do artigo. 
% Am � um cell array coluna onde cada coluna representa o resultado do 
% som�torio de uma subpopula��o  
Am = cell(b,1);

for i = 1:b
    Am{i,1} = 0;
    aux = SubP{i,2} + 2;
    for j = 3:aux 
       Am{i,1} = Am{i,1} + SubP{i,j}; 
    end
    Am{i,1} = Am{i,1}/SubP{i,2}; 
end

% _______________________________Etapa 2___________________________________ 
% Equa��o 9 do artigo.
fave = sum(Aptidao)/mi;
[~, cmax] = size(SubP);
PD_Sj_i = cell(b,cmax);
% PD_Sj_i � sempre um n�mero n�o negativo, ou seja, qualquer valor poss�vel
% de PD_Sj_i � maior que -1.
PD_max_i = -1;

for i = 1:b
    aux = SubP{i,2} + 2;
    for j = 3:aux
        k = SubP{i,1};
        wi = SubAptidao{i,j}/fave;
        diferenca = (SubP{i,j} - Am{i,1}).^2; 
        PD_Sj_i{i,j} = sum(sum(diferenca));
        PD_Sj_i{i,j} = wi*sqrt(PD_Sj_i{i,j}/k);
        
        %Encontra o maior valor de PD_Sj_i
        if (PD_Sj_i{i,j} >= PD_max_i)
            PD_max_i = PD_Sj_i{i,j}; 
        end    
    end
end
% _______________________________Etapa 3___________________________________
% Equa��o 10 do artigo.

PD_Sj = cell(b,1);
SomaPD_Sj = 0; 
for i = 1:b
    PD_Sj{i,1} = 0;
    aux = SubP{i,2} + 2;
    for j = 3:aux 
       PD_Sj{i,1} = PD_Sj{i,1} + PD_Sj_i{i,j}; 
    end
    SomaPD_Sj = SomaPD_Sj + PD_Sj{i,1}; 
end
% _________________________________________________________________________
% Equa��o 11 do artigo.
PD_b = b*PD_max_i;

% Equa��o 12 do artigo
PD = PD_b + SomaPD_Sj;
end
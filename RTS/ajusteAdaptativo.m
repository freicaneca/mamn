function [PD, Aptidao] = ajusteAdaptativo (P, mi, dados, pesos)
%{
%Função que dispõe o valor de PD e da aptidão da população de pais

----------------------------Entradas-----------------------------
P - População
mi - número de indivíduos da população
Wmin - valor mínimo permitido de w
Wmax - valor máximo permitido de w
------------------------------Saída------------------------------
PD - Diversidade da população
Aptidao - Aptidao dos indivíduos da população
----------------------------Variáveis----------------------------
b - número de subpopulações
SubP - subpopulações (onde os indivíduos possuem o mesmo número de clusters)
cmax - valor máximo de colunas de SubP
S - vetor contendo o número de clusters de cada indivíduos
c - número de indivíduos numa subpopulação
k - número de clusters de um indivíduo 
d - dimensão dos dados
fave - média da aptidão de toda a população
fi - aptidão do indivíduo i
wi = fi/fave
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 08/12/2015                                             
Data de atualização: 08/12/2015 
%}

% Dividindo a População em Subpopulações, cada linha do array SubP
% representa uma subpopulação, o primeiro elemento da linha indica o número
% de cluster da subpopulação (k), enquanto que a segunda componente indica 
% o número de indivíduos da subpopulação (c)

[SubPi, b, Aptidao, SubAptidao] = divPop (P, mi,dados, pesos);
[SubP] = ordenamento (SubPi, b);

% Execução das etapas 1 até 3 do artigo (página 730):
% _______________________________Etapa 1___________________________________
% Equação 8 do artigo. 
% Am é um cell array coluna onde cada coluna representa o resultado do 
% somátorio de uma subpopulação  
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
% Equação 9 do artigo.
fave = sum(Aptidao)/mi;
[~, cmax] = size(SubP);
PD_Sj_i = cell(b,cmax);
% PD_Sj_i é sempre um número não negativo, ou seja, qualquer valor possível
% de PD_Sj_i é maior que -1.
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
% Equação 10 do artigo.

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
% Equação 11 do artigo.
PD_b = b*PD_max_i;

% Equação 12 do artigo
PD = PD_b + SomaPD_Sj;
end
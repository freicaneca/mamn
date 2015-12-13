function [Pop] = crowding_probabilistico (Pop, Aptidao, mi, pares, filhos, dados, pesos)
%{

Função que aplica o crowding determinístico como método de seleção de
sobreviventes

IMPORTANTE: PARA ESSA FUNÇÃO ESTOU CONSIDERANDO QUE O PRIMEIRO PAR DE PAIS
GERARÁ O PRIMEIRO PAR DE FILHOS

----------------------------Entrada-----------------------------
Pop - População de pais
Aptidao - Aptidao dos pais
mi - tamanho da população
pares - pares de pais selecionados
filhos - população de filhos
dados, pesos - variáveis necessárias para o cálculo da aptidão dos filhos
------------------------------Saída------------------------------
Pop - População de sobreviventes após a atuação do crowding
determinístico
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 10/12/2015                                             
Data de atualização: 13/12/2015 
%}


%PARA A UTILIZAÇÃO DO CROWDING É NECESSÁRIO UTILIZAR A SELEÇÃO DE PAIS SEM 
%REPOSIÇÃO FUNÇÃO ParesComRepo
for i = 1:(mi/2)
    d = zeros(2,2);
    %Definindo quem são os pais e quem são os filhos
    
    %Primeiro Pai = Pop{pares(i,1)};
    %Segundo Pai = Pop{pares(i,2)};
    %Primeiro filho = filhos{2*i-1};
    %Segundo filho = filhos{2*i};
    
    %Calculando o fitness dos filhos
    [result_filho1] = fitness(filhos{2*i-1}, dados, pesos);
    [result_filho2] = fitness(filhos{2*i}, dados, pesos);
    
    %Analisando a distância FENOTÍPICA entre pais e filhos
    %É montado uma MATRIZ onde a linha representa os pais e a coluna os filhos
    %Exemplo, a d(1,2) é a distância entre o primeiro pai e o segundo filho
    d(1,1) = abs(Aptidao(pares(i,1)) - result_filho1);
    d(1,2) = abs(Aptidao(pares(i,1)) - result_filho2);
    d(2,1) = abs(Aptidao(pares(i,2)) - result_filho1);
    d(2,2) = abs(Aptidao(pares(i,2)) - result_filho2);
    
    if ( d(1,1) + d(2,2) <= d(1,2) + d(2,1) )
        % Competição entre o filho 1(x) e pai1(y). A propabilidade do 
        % filho1 vencer a competição é dado por p(x) = f(x)/(f(x)+f(y)), 
        % onde f é a função de aptidão
        p11 = result_filho1/(result_filho1 + Aptidao(pares(i,1)));
        % Competição pai 2 e filho 2
        p22 = result_filho2/(result_filho2 + Aptidao(pares(i,2)));
        
        aux1 = rand(1,1);
        aux2 = rand(1,1);
        if (aux1 <= p11)
            Pop{pares(i,1)} = filhos{2*i-1};
        end
        if (aux2 <= p22)
            Pop{pares(i,2)} = filhos{2*i};
        end
    else
        % Competição pai 1 e filho 2
        p12 = result_filho2/(result_filho2 + Aptidao(pares(i,1)));
        aux1 = rand(1,1);
        % Competição pai 2 e filho 1
        p21 = result_filho1/(result_filho1 + Aptidao(pares(i,2)));      
        aux2 = rand(1,1);
        
        if (aux1 <= p12)
            Pop{pares(i,1)} = filhos{2*i};
        end
        if (aux2 <= p21)
            Pop{pares(i,2)} = filhos{2*i-1};
        end
    end
end
end
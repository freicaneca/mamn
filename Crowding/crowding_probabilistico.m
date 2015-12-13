function [Pop] = crowding_probabilistico (Pop, Aptidao, mi, pares, filhos, dados, pesos)
%{

Fun��o que aplica o crowding determin�stico como m�todo de sele��o de
sobreviventes

IMPORTANTE: PARA ESSA FUN��O ESTOU CONSIDERANDO QUE O PRIMEIRO PAR DE PAIS
GERAR� O PRIMEIRO PAR DE FILHOS

----------------------------Entrada-----------------------------
Pop - Popula��o de pais
Aptidao - Aptidao dos pais
mi - tamanho da popula��o
pares - pares de pais selecionados
filhos - popula��o de filhos
dados, pesos - vari�veis necess�rias para o c�lculo da aptid�o dos filhos
------------------------------Sa�da------------------------------
Pop - Popula��o de sobreviventes ap�s a atua��o do crowding
determin�stico
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 10/12/2015                                             
Data de atualiza��o: 13/12/2015 
%}


%PARA A UTILIZA��O DO CROWDING � NECESS�RIO UTILIZAR A SELE��O DE PAIS SEM 
%REPOSI��O FUN��O ParesComRepo
for i = 1:(mi/2)
    d = zeros(2,2);
    %Definindo quem s�o os pais e quem s�o os filhos
    
    %Primeiro Pai = Pop{pares(i,1)};
    %Segundo Pai = Pop{pares(i,2)};
    %Primeiro filho = filhos{2*i-1};
    %Segundo filho = filhos{2*i};
    
    %Calculando o fitness dos filhos
    [result_filho1] = fitness(filhos{2*i-1}, dados, pesos);
    [result_filho2] = fitness(filhos{2*i}, dados, pesos);
    
    %Analisando a dist�ncia FENOT�PICA entre pais e filhos
    %� montado uma MATRIZ onde a linha representa os pais e a coluna os filhos
    %Exemplo, a d(1,2) � a dist�ncia entre o primeiro pai e o segundo filho
    d(1,1) = abs(Aptidao(pares(i,1)) - result_filho1);
    d(1,2) = abs(Aptidao(pares(i,1)) - result_filho2);
    d(2,1) = abs(Aptidao(pares(i,2)) - result_filho1);
    d(2,2) = abs(Aptidao(pares(i,2)) - result_filho2);
    
    if ( d(1,1) + d(2,2) <= d(1,2) + d(2,1) )
        % Competi��o entre o filho 1(x) e pai1(y). A propabilidade do 
        % filho1 vencer a competi��o � dado por p(x) = f(x)/(f(x)+f(y)), 
        % onde f � a fun��o de aptid�o
        p11 = result_filho1/(result_filho1 + Aptidao(pares(i,1)));
        % Competi��o pai 2 e filho 2
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
        % Competi��o pai 1 e filho 2
        p12 = result_filho2/(result_filho2 + Aptidao(pares(i,1)));
        aux1 = rand(1,1);
        % Competi��o pai 2 e filho 1
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
function [w, count, PDmax] = estrategiaAdaptacao (geracao, count, PD, PDmax, wmin, wmax, g)
%{

Fun��o que encontra o valor adequado de w para a popula��o da itera��o
vigente

----------------------------Entradas-----------------------------
geracao - geracao vigente 
PD - Diversidade da popula��o
PDmax - maior valor de PD registrado
wmin - valor m�nimo de w 
wmax - valor m�ximo de w 
g - n�mero de gera��es sem altera��es no valor de PD
delta_PD - margem de erro de varia��o de PD
------------------------------Sa�da------------------------------
w - valor do w do RTS
count - n�mero de gera��es sem melhorias no valor de PD
----------------------------Vari�veis----------------------------

-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 08/12/2015                                             
Data de atualiza��o: 08/12/2015 
%}

if (geracao == 1)
   PDmax = PD;
   count = 0;
end

if (count <= g)
    %Para melhorar o desempenho o if anterior pode ficar aqui, mas para
    %isso o valor de count deve ser definido do inicio do programa ga.
    w = wmax;
    if (PD > PDmax)
        PDmax = PD;   
        count = 0;
    else
        count = count + 1;
    end
else   
   if (PD > PDmax)
        PDmax = PD;
   end 
   w = wmax - (PD/PDmax)*(wmax - wmin); 
end

end
function [w, count, PDmax] = estrategiaAdaptacao (geracao, count, PD, PDmax, wmin, wmax, g)
%{

Função que encontra o valor adequado de w para a população da iteração
vigente

----------------------------Entradas-----------------------------
geracao - geracao vigente 
PD - Diversidade da população
PDmax - maior valor de PD registrado
wmin - valor mínimo de w 
wmax - valor máximo de w 
g - número de gerações sem alterações no valor de PD
delta_PD - margem de erro de variação de PD
------------------------------Saída------------------------------
w - valor do w do RTS
count - número de gerações sem melhorias no valor de PD
----------------------------Variáveis----------------------------

-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biomédica - CTG / UFPE                     
Data de criação: 08/12/2015                                             
Data de atualização: 08/12/2015 
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
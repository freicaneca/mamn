function [SubP] = ordenamento (SubPi, b)
%{
%Orndena as subpopula��es para que clusters similares fiquem em posi��es
similares nos indiv�duos

----------------------------Entradas-----------------------------
SubPi - Subpopula��o inicial antes da reorganiza��o
b - n�mero de subpopula��es
------------------------------Sa�da------------------------------
SubP- Subpopula��o final depois da reorganiza��o
----------------------------Vari�veis----------------------------
cmax - valor m�ximo de colunas de SubP
-----------------------------------------------------------------

Autor: Valter Augusto de Freitas Barbosa                                        
Aluno de Mestrado em Eng. Biom�dica - CTG / UFPE                     
Data de cria��o: 08/12/2015                                             
Data de atualiza��o: 08/12/2015 
%}
[~,d] = size (SubPi{1,3});
SubP = SubPi;
for i = 1:b
    aux = SubPi{i,2} + 2;       
    if (aux > 3)
       ind1 = SubPi{i,3};
       k = SubPi{i,1};
       for j = 4:aux 
           ind2 = SubPi{i,j};
           ind3 = zeros(k,d);
           vmax = k;           
           for u = 1:k
            dist = zeros(1,vmax);
            for v = 1:vmax
                dist(v) = norm(ind1(u,:) - ind2(v,:));
            end
            [~,I] = min(dist);
            ind3(u,:) = ind2(I,:);
            ind2(I,:) = [];
            vmax = vmax - 1;
           end
            SubP{i,j} = ind3;    
       end
    end
end
end
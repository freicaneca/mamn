%%%%%%%%%%
%
% FUNÇÃO: calculo_rand
%
% Computes the adjusted Rand index to assess the quality of a clustering.
% Perfectly random clustering returns the minimum score of 0, perfect
% clustering returns the maximum score of 1.
%
% ENTRADA:
% - u = the labeling as predicted by a clustering algorithm
% - v = the true labeling
%
% SAÍDA:
%
% - randIndex = o índice de Rand ajustado
%
% AUTOR: Tijl De Bie, february 2003.
%
%%%%%%%%%%
function randIndex = calculo_rand(u,v)

    n=length(u);
    ku=max(u);
    kv=max(v);
    m=zeros(ku,kv);

    for i=1:n
        m(u(i),v(i)) = m(u(i),v(i)) + 1;
    end
    mu=sum(m,2);
    mv=sum(m,1);

    a=0;
    for i=1:ku
        for j=1:kv
            if m(i,j)>1
                a=a+nchoosek(m(i,j),2);
            end
        end
    end

    b1=0;
    b2=0;
    for i=1:ku
        if mu(i)>1
            b1=b1+nchoosek(mu(i),2);
        end
    end
    for i=1:kv
        if mv(i)>1
            b2=b2+nchoosek(mv(i),2);
        end
    end

    c=nchoosek(n,2);

    randIndex = (a-b1*b2/c)/(0.5*(b1+b2)-b1*b2/c);
end

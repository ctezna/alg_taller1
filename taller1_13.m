%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 13
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcule el número condición de la matriz de covarianzas de portfolio100 
% en su versión original. Implemente alternativas para mejorarlo 
% y reducirlo a la cuarta parte.
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;

filename = 'portfolio100.txt';
delimiterIn = ' ';
headerlinesIn = 1;
Data = importdata(filename,delimiterIn);
Data = Data(:,2:end);
C = cov(Data);
[f, c] = size(Data);
[a, b] = size(C);
con = cond(C);
[CLW, shrinkage] = cov1para(Data);
NCLW = cond(Data);
err = [];

target = 0.75

for n=1:1000
    if n==1
        ini_cond = cond(cov(Data))
    end
    x = Data + (eye(f, c) * n);
    cov_n = cov(x);
    err(n) = cond(cov_n);
    
    if err(n)<=(1-target)*ini_cond
        break
    end
end

%disp(max(err));

plot(err, 'b');
change = (con-err(end))/con;
%title(['Condition number: ', num2str(con),' Condition number final: ', num2str(err(end))]);
title(['Porcentaje de decrecimiento: ', num2str(change*100), '%', '- objetivo: ',num2str(target*100),'%']);
xlabel("Iteraciones");
ylabel("Numero condicion");

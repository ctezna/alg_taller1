% Calcule el n ́umero condici ́on de la matriz de covarianzas de 
% portfolio100 en su versi ́on original.Implemente alternativas
% para mejorarlo y reducirlo a la cuarta parte.

clear;

filename = 'portfolio100.txt';
delimiterIn = ' ';
headerlinesIn = 1;
Data = importdata(filename,delimiterIn);
Data = Data(:,2:end);
C = cov(Data);
[f c] = size(Data);
[a b] = size(C);
con = cond(C);
CLW = cov1para(Data);
NCLW = cond(Data);
err = [];

for n=1:500
    x = Data + (eye(f, c) * n);
    cov_n = cov(x);
    err(n) = cond(cov_n);
end

disp(max(err));

plot(err, 'b');
change = (con-err(end))/con;
%title(['Condition number: ', num2str(con),' Condition number final: ', num2str(err(end))]);
title(['Condition number decrease: ', num2str(change*100), '%']);
xlabel("Iteration");
ylabel("Condition number");
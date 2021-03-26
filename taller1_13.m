clear all

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

for n=1:1000
    x = Data + (eye(f, c) * n);
    cov_n = cov(x);
    err(n) = cond(cov_n);
end

disp(max(err));

plot(err);
change = (con-err(end))/con;
%title(['Condition number: ', num2str(con),' Condition number final: ', num2str(err(end))]);
title(['Condition number decrease: ', num2str(change*100), '%']);
xlabel("Iteration");
ylabel("Condition number");
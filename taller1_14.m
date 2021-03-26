% Sea Hn(i, j) =1/i+j−1, llamada la matriz de Hilbert. Simule 1000 datos normales con matriz decovarianza Hn. 
% Estime la matriz de covarianzas desde los datos simulados. Realice una gr ́afica denen el ejexcon el n ́umero 
% condici ́on de la matriz de covarianza estimada en el ejey. Qu ́e tipode comportamiento observa.
% Haga lo mismo para su determinante. Realice lo mismo estimando lamatriz de covarianza utilizando
% el shrinkage de Ledoit and Wolf. Compare los resultados. Haga unan ́alsis gr ́afico y de visualizaci ́on 
% donde se observe si al final el shrinkage mejora el n ́umero condici ́on.
clear;
for n=1:20
    
    h = hilb(n);
    mu = zeros(1, n);
    x = mvnrnd(mu, h, 1000);
    h_shrink = cov1para(x, -1);
    
    h_cond(n) = cond(h);
    h_det(n) = det(h);
    
    h_shrink_cond(n) = cond(h_shrink);
    h_shrink_det(n) = det(h_shrink);
    
end

subplot(2,2,1)
plot(h_cond, 'r')
title("Hilbert")
xlabel("n")
ylabel("Condition number")

subplot(2,2,2)
plot(h_shrink_cond, 'b')
title("Shrinked Hilbert")
xlabel("n")
ylabel("Condition number")

subplot(2,2,3)
plot(h_det, 'r')
%title("Hilbert")
xlabel("n")
ylabel("Determinant")

subplot(2,2,4)
plot(h_shrink_det, 'b')
%title("Determinant - Shrinked Hilbert")
xlabel("n")
ylabel("Determinant")
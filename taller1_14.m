%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 14
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sea Hn(i, j) = 1 i+j−1, llamada la matriz de Hilbert. Simule 1000 datos
% normales con matriz de covarianza Hn. Estime la matriz de covarianzas desde
% los datos simulados. Realice una gráfica de n en el eje x con el número 
% condición de la matriz de covarianza estimada en el eje y. 
% Qué tipo de comportamiento observa. Haga lo mismo para su determinante. 
% Realice lo mismo estimando la matriz de covarianza utilizando el shrinkage 
% de Ledoit and Wolf.Compare los resultados. Haga un análisis gráfico y 
% de visualización donde se observe si al final el shrinkage mejora 
% el número condición.
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
ND = 1000;
N = 30



for n=1:N
    
    Hn = hilb(n);
    mu = zeros(1,n);
    x = mvnrnd(mu,Hn,ND); % contruir datos con esa matriz de covarianza
    cov_x = cov(x); % covarianza muestral
    [cov_LW,shrinkage] = cov1para(x);
    
    cov_condi(n) = cond(cov_x);
    cov_det(n) = det(cov_x);
     
    cov_LW_condi(n) = cond(cov_LW);
    cov_LW_det(n) = det(cov_LW);
    
end

close all
%condicion
figure(1)
semilogy(cov_condi,"r");
hold on
semilogy(cov_LW_condi,"b");
title("Comparacion numeros condicionantes")
xlabel("n")
ylabel("Condicionante")
legend("Datos Hilb-cov","Datos shrinkage L&W",'Location','northwest')


%determiante
figure(2)
semilogy(cov_det,"r");
hold on
semilogy(cov_LW_det,"b");
title("Comparacion determinantes")
xlabel("n")
ylabel("determinante")
legend("Datos Hilb-cov","Datos shrinkage L&W",'Location','southwest')

% 
% for j=1:5
%     H = hilb(j)
%     mu=zeros(1,j);
%     x=mvnrnd(mu,H,500)
%     C=cov(x)
%     [CLW,shrinkage] = cov1para(x);
%     condiC(j) =cond(C);
%     condiLW(j)=cond(CLW);
%     deteC(j)=det(C);
%     deteLW(j)=det(CLW);
% end
% 
% plot(condiC)
% hold on
% plot(condiLW,"r")

%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 16
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Realice lo mismo que los dos puntos anteriores pero con la matriz de 
% Vandermonde en lugar que la Hilbert. Consulte qué tipos de problemas útiles 
% de aplicaciones matemáticas en analítica de datos usan la matriz de
% Vandermonde y la de Hilbert. Tiene alguna sugerencia para contribuir a mejorar
% estas aplicaciones matemáticas? ya que son problemas muy mal condicionados.
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% se realiza lo del punto 14


clear;
ND = 1000;
N = 30


for n=1:N
    
    Vn = vander(1:n); % es la matriz de vandermonde
    %mu = zeros(1,n);
    %x = mvnrnd(mu,Vn,ND); % contruir datos con esa matriz de covarianza
    x = Vn
    cov_x =cov(x); % covarianza muestral
    [cov_LW,shrinkage] = cov1para(x);
    
    cov_condi(n) = cond(cov_x);
    cov_det(n) = det(cov_x);
     
    cov_LW_condi(n) = cond(cov_LW);
    cov_LW_det(n) = det(cov_LW);
    
end

close all
%condicion
figure(1)
plot(cov_condi,"r");
hold on
plot(cov_LW_condi,"b");
title("Comparacion numeros condicionantes")
xlabel("n")
ylabel("Condicionante")
legend("Datos Vander-cov","Datos shrinkage L&W",'Location','northwest')


%determiante
figure(2)
semilogy(cov_det,"r");
hold on
semilogy(cov_LW_det,"b");
title("Comparacion determinantes")
xlabel("n")
ylabel("determinante")
legend("Datos Vander-cov","Datos shrinkage L&W",'Location','southwest')




%% se realiza lo del punto 15
% % Setup original
 clc;
 clear;
% vector de entrada
x0 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]'

% definimos la matriz de hilbert 15

%H = hilb(length(x0));
V = vander(x0);
% definimos b
b = V*x0

% resolvamos el sistema x = invH*b
invV_1 = inv(V)
%invH_2 = invhilb(length(x0)) 


x1 = invV_1*b
%x2 = invH_2*b
x3 = V\b
condV = cond(V)
% comparamos x0 con x
dif_x1 = norm(x0-x1,2)
%dif_x2 = norm(x0-x2,2)
dif_x3 = norm(x0-x3,2)

%Mejorando el determinante de  la matriz de Vandermonde

% Utilizando Shrinkage de Ledoy and Wolf

hilb_shrink = cov1para(V,0.5)
b_shrink = hilb_shrink*x0

cond_H_shrink = cond(hilb_shrink)
det_H_shrink = det(hilb_shrink)

x_shrink = inv(hilb_shrink)*b_shrink

dif_shrink = norm(x0-x_shrink,2)

% incrementando la diagonal utilizando un factor lambda 

lambda = 1 % un valor calibrable

vander_daum = V + lambda*eye(length(x0))
b_daum = vander_daum*x0

cond_H_daum = cond(vander_daum)
det_H_daum = det(vander_daum)

x_daum = inv(vander_daum)*b_daum

dif_daum = norm(x0-x_daum,2)

% in

%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PUNTO 15
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Considere x = [1,2,3,4,5,6,7,8,9,10,11,12,13 ,14,15]  Defina b = H15x. 
% Resuelva el sistema con la forma x = H−1b. Qué conclusión obtiene. 
% Busque alternativas para resolver el problema observado.
%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setup original
clc
% vector de entrada
x0 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]'

% definimos la matriz de hilbert 15

H = hilb(length(x0))

% definimos b
b = H*x0

% resolvamos el sistema x = invH*b
invH_1 = inv(H)
invH_2 = invhilb(length(x0)) 


x1 = invH_1*b
x2 = invH_2*b
x3 = H\b
condH = cond(H)
% comparamos x0 con x
dif_x1 = norm(x0-x1,2)
dif_x2 = norm(x0-x2,2)
dif_x3 = norm(x0-x3,2)
%% Mejorando el determinante de  la funcion Hilbert

% Utilizando Shrinkage de Ledoy and Wolf

hilb_shrink = cov1para(H,0.5)
b_shrink = hilb_shrink*x0

cond_H_shrink = cond(hilb_shrink)
det_H_shrink = det(hilb_shrink)

x_shrink = inv(hilb_shrink)*b_shrink

dif_shrink = norm(x0-x_shrink,2)

% incrementando la diagonal utilizando un factor lambda 

lambda = 1 % un valor calibrable

hilb_daum = H + lambda*eye(length(x0))
b_daum = hilb_daum*x0

cond_H_daum = cond(hilb_daum)
det_H_daum = det(hilb_daum)

x_daum = inv(hilb_daum)*b_daum

dif_daum = norm(x0-x_daum,2)

% in

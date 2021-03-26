% En el fichero (porfolio100.txt), saque la media de cada fila, 
% es decir el vector de media ser ́a un vectorde 668×1. Defina la
% variable binaria como 1 donde el vector de medias es mayora 1.5
% y cero enotro caso. Defina la matriz binaria que vale 1 si en
% portfolio100 hay unvalor positivo y cero en otrocaso. Con las 
% m ́etricas binarias (Pearson, Jaccard y Dice) identifique los 10
% activos m ́as parecidos ylos 10 menos parecidos al vector binario
% de medias.


clear;
% data import 
importedData = importdata('portfolio100.txt');
data = importedData(:,2:end);
myMean = mean(data,2);

% dimesions
[fdata,cdata] = size(data);
[fmean,cmean] = size(myMean);

% mean binary array
for i=1:fmean
    if myMean(i,1)>0
        binaryArray(i) = 1;
    else
        binaryArray(i) = 0;
    end
end

% data binary matrix
for i=1:fdata
    for j=1:cdata
        if data(i,j)>0
            binaryMatrix(i,j) = 1;
        else
            binaryMatrix(i,j) = 0;
        end
    end
end

for i=1:cdata
    
    mcon = confusionmat(binaryArray,binaryMatrix(:,i));
    d = mcon(1,1);
    c = mcon(1,2);
    b = mcon(2,1);
    a = mcon(2,2);
    
    distanceDice(i)= (2*a)/(2*a+b+c);
    distanceJaccard(i)=(a)/(a+b+c) ;
    distancePearson(i)= (a*d-b*c)/sqrt((a+c)*(b+d)*(a+b)*(c+d));
end

% Pearson indicator
[pearsonFarValues,personFarIndex]=maxk(distancePearson,10);
[pearsonCloseValues,personCloseIndex]=mink(distancePearson,10);
pearsonFarDiff = ([personFarIndex(:),pearsonFarValues(:)]);
pearsonCloseDiff = ([personCloseIndex(:),pearsonCloseValues(:)])

% Dice indicator
[diceFarValues,diceFarIndex]=maxk(distanceDice,10);
[diceCloseValues,diceCloseIndex]=mink(distanceDice,10);
diceFarDiff = ([diceFarIndex(:),diceFarValues(:)]);
diceCloseDiff = ([diceCloseIndex(:),diceCloseValues(:)])

% Jaccard indicator
[jaccardFarValues,jaccardFarIndex]=maxk(distanceJaccard,10);
[jaccardCloseValues,jaccardCloseIndex]=mink(distanceJaccard,10);
jaccardFarDiff = ([jaccardFarIndex(:),jaccardFarValues(:)]);
jaccardCloseDiff = ([jaccardCloseIndex(:),jaccardCloseValues(:)])
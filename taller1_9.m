% Describa y ejecute un proceso de identificaci ́on de outliers
% en variables binarias. Util ́ıcelo para identi-ficar qu ́e meses
% en portfolio100, versi ́on binario siendo 1 si hay valor positivo,
% son considerados mesesat ́ıpicos.


clear;

importedData = importdata('portfolio100.txt');
data = importedData(:,2:end);

myActiveMean = mean(data);
[fdata,cdata] = size(data);

[factive, cactive] = size(myActiveMean);

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

for i=1:cactive
    if myActiveMean(1,i)>0
        binaryActiveArray(i) = 1;
    else
        binaryActiveArray(i) = 0;
    end
end

for i=1:fdata
    
    mcon = confusionmat(binaryActiveArray,binaryMatrix(i,:));
    d = mcon(1,1);
    c = mcon(1,2);
    b = mcon(2,1);
    a = mcon(2,2);
   
    distanceActiveJaccard(i)= (a)/(a+b+c);
end
PActive = prctile(distanceActiveJaccard,90);
IActive = find(distanceActiveJaccard > PActive);

outliers = importedData(IActive,1);
disp(outliers);

plot(importedData(:,1),distanceActiveJaccard,'o')
hold on
plot(importedData(IActive,1), distanceActiveJaccard(IActive),'or')
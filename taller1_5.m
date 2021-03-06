% Consulte y programe el algoritmo dek−means. Progr ́amelo siendo los inputs,
% el n ́umero de grupos,la distanciapconp= 0,1,2, . . ., y el n ́umero
% de iteracciones hasta la parada. Suponga quep= 0 esla distancia de
% Mahalanobis. Simule 4 muestras aleatorias de distribuciones normales
% bivariantes condistintas medias, luego haga un an ́alisis de qu ́e
% distancia tiene un mejor desempe ̃no para clasificarlas muestras.
% (enviar c ́odigo)


%Initialising Data
%The variable k is the number of clusters, the variable p_upper_limit is
%the maximum p where p is metric of distance
clear;
iterations = 10;
k = 4;
p_upper_limit = 6;
total_errors = [];

for distance_metric=0:p_upper_limit
    ND = 1000;
    mu = zeros(1,k);
    h = hilb(k);
    data = mvnrnd(mu,h,ND);
    count = 1;
    %fprintf('P = %d:\n', distance_metric);
    rows = size(data, 1);
    cols = size(data, 2);
    data = data(1:rows, 1:cols-1);
    clusters = randi([1 k], rows, 1);
    clustered_data = [data clusters];
    mean_matrix = zeros(k, cols-1);
    

    %Calculating Mean

    for i = 1:k
        index = clustered_data(:, end) == i;
        indexed_data = clustered_data(index, 1:end-1);
        mean_matrix(i, :) = mean(indexed_data);
       
    end
    
    %Computing Error

    error = get_error(clustered_data, mean_matrix, distance_metric);
    %fprintf('After initialization: error = %.4f \n', error);
    
    %Starting Iterations

    for p = 1:iterations
        for q = 1:rows
            %Deciding which Cluster data belongs
            dist = get_distance(data(q, :), mean_matrix, distance_metric);
            [minimum_row, minimum_col] = min(dist);
            clusters(q) = minimum_col;
        end
    
        clustered_data = [data, clusters];
       
        %Calculating Mean
    
        for i = 1:k
            index = clustered_data(:, end) == i;
            indexed_data = clustered_data(index, 1:end-1);
            mean_matrix(i, :) = mean(indexed_data);
        end
    
        %Computing Error
    
        prev_error = error;
        error = get_error(clustered_data, mean_matrix, distance_metric);
        %fprintf('After iteration %d: error = %.4f \n', p, error);
    
        if error  == prev_error
            break;
        end
    end
    total_errors(distance_metric+1) = error;
    total_clusters(distance_metric+1,:) = clusters;
end

subplot(1,2,1);
gscatter(data(:,1),data(:,2),clusters,['b', 'r', 'g', 'c', 'm', 'k', 'w', 'y']);
title("Clustering");
subplot(1,2,2);
bar(0:p_upper_limit, total_errors);
title("Errors comparation");
xlabel("P Value");
ylabel("Error");
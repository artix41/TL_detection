function new_matrix=normalization(matrix,mean,std)
    new_matrix = (double(matrix)-mean)/std;
    
    
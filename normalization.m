function new_matrix=normalization(matrix)
    display('Mean :')
    display(mean(matrix(:)));
    display('STD : ')
    display(std(matrix(:)));
    new_matrix = (double(matrix)-mean(matrix(:)))/std(matrix(:));

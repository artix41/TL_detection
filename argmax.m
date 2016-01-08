function [arg] = argmax(matrix)
    cur_max = -Inf;
    arg = [0 0];
    for i = 1:size(matrix,1)
        for j = 1:size(matrix,2)
            if matrix(i,j) > cur_max
                cur_max = matrix(i,j);
                arg = [i j];
            end
        end
    end
end

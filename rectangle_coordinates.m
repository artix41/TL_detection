function [coord] = rectangle_coordinates(point,image_size,size)
    line = max(point(1)-floor(size/2),1);
    col = max(point(2)-floor(size/2),1);
    new_size = [size size]
    
    if line + size > image_size(1)
        new_size(1) = image_size(1)-line;
    end
    if col + size > image_size(2)
        new_size(2) = image_size(2)-col;
    end
    coord = [col line new_size(2) new_size(1)];
function [coord] = rectangle_coordinates(point, image_size, size_col, size_li)
    line = max(point(1)-floor(size_li/2),1);
    col = max(point(2)-floor(size_col/2),1);
    new_size = [size_li size_col];
    
    if line + size_li > image_size(1)
        new_size(1) = image_size(1)-line;
    end
    if col + size_col > image_size(2)
        new_size(2) = image_size(2)-col;
    end
    coord = [col line new_size(2) new_size(1)];

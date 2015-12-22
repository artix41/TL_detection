function detection=showDetection(image, point, size_col, size_li)
    % Cut a rectangle of size size_li*size_col, horizontally centered on the point
    % and vertically cut with the point at 1/6 of the rectangle from the top 
    % (to have all the traffic light, with the red fire at the top))
    
    vertical_proportion = 1/6;
    image_size = size(image);
    
    line = max(point(1)-floor(size_li*vertical_proportion),1);
    col = max(point(2)-floor(size_col/2),1);
    new_size = [size_li size_col];
    
    if line + size_li > image_size(1)
        line = image_size(1) - new_size(1);
    end
    if col + size_col > image_size(2)
        col = image_size(2) - new_size(2);
    end

    detection = image(line:line+new_size(1), col:col+new_size(2),:);
    


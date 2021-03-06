function list_argmax=detectMaxima(F, n_maxima)
    modified_F = F;
    list_argmax = zeros(n_maxima,2);
    for i = 1:n_maxima
        list_argmax(i,:) = argmax(modified_F);
        coord_rect = rectangle_coordinates(list_argmax(i,:), size(F), 11, 27);
        rectangle('Position', coord_rect, 'LineWidth',2, 'EdgeColor','b' );
        for iLineRect = coord_rect(2):coord_rect(2)+coord_rect(4)
            for iColRect = coord_rect(1):coord_rect(1)+coord_rect(3)
                modified_F(iLineRect, iColRect) = 0;
            end
        end
    end

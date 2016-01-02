function y = showImagesAndResults(start,stop, directory)
    subplot(2,2,1);
    hold off;
    iImage = start;
    continuer = 1;
    count = 5465; % Indice of the last saved image
    while continuer && iImage < stop
        display(iImage);
        rgb_image = imread(sprintf('%s/frame_%06d.jpg', directory, iImage));

        % Conversion in La*b* format and getting F=L*(a+b)
        [lab_image, F] = convertColorSpace(rgb_image);

        % Plot F and the original image
        subplot(2,2,1);
        imagesc(rgb_image);
        subplot(2,2,2);
        imagesc(F)
        colorbar;

        % Plot rectangle
        coord_maxima = detectMaxima(F, 5);
        display(coord_maxima);

        % Plot the convolute image
        subplot(2,2,3);
        convImage = convolution(mexican_hat(20, 4), F);
        imagesc(convImage);
        colorbar;

        % Plot the extracted traffic light
        hax = subplot(2,2,4);
        detection = extractDetection(rgb_image, coord_maxima(1,:), 10, 26);
        imagesc(detection);
        axis equal tight;

        % Keyboard detection
        waitforbuttonpress;
        set(gcf, 'KeyPressFcn', @(x,y)disp(get(gcf,'CurrentCharacter')));
        typed_char = get(gcf, 'CurrentCharacter');
        if typed_char == 'j' && iImage > 0
            iImage = iImage - 1;
        end
        if typed_char == 'k'
            iImage = iImage + 1;
        end
        if typed_char == ' '
            continuer = 0;
        end

        iImage = iImage + 1;
    end

function y = showImagesAndResults(start,stop, directory)
    subplot(2,2,1);
    hold off;
    iImage = start;
    continuer = 1;
    while continuer && iImage < stop
        display(iImage);
        rgb_image = imread(sprintf('%s/frame_%06d.jpg', directory, iImage));

        % Conversion in La*b* format and getting F
        [lab_image, F] = convertColorSpace(rgb_image);
        
        % Plot F and the original image
        subplot(2,2,1);
        imagesc(rgb_image);
        subplot(2,2,2);
        imagesc(F)
        colorbar;
        
        % Plot rectangle
        detectMaxima(F, 1);
        
        % Plot the convolute image
        subplot(2,2,3);
        convImage = convolution(mexican_hat(20, 4), F);
        imagesc(convImage);
        colorbar;
        
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
        display(iImage);
    end 
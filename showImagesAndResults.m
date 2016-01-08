function y = showImagesAndResults(start,stop, directory)
    subplot(3,5,1);
    hold off;
    iImage = start;
    continuer = 1;
    while continuer && iImage < stop
        display(iImage);
        rgb_image = imread(sprintf('%s/frame_%06d.jpg', directory, iImage));

        % Conversion in La*b* format and getting F=L*(a+b)
        [lab_image, F] = convertColorSpace(rgb_image);

        % Plot F and the original image
        subplot(3,5,[1,2]);
        imagesc(rgb_image);
        set(gca,'xtick',[],'ytick',[]);
        subplot(3,5,[4,5]);
        imagesc(F)
        set(gca,'xtick',[],'ytick',[]);

        % Plot rectangle
        nbrMaxima = 5;
        coord_maxima = detectMaxima(F, nbrMaxima);

        % Plot the extracted traffic light
        detection = uint8(zeros(nbrMaxima, 27, 11, 3));
        for i = 1:nbrMaxima
            subplot(3,5,5+i);
            detection(i,:,:,:) = extractDetection(rgb_image, coord_maxima(i,:), 10, 26);
            imagesc(reshape(detection(i,:,:,:), [27,11,3]));
            set(gca,'xtick',[],'ytick',[]);
            axis equal tight;
        end

        % Detect if it is a red light with neural networks
        iRedLight = -1;
        count = 0;
        for i = 1:nbrMaxima
            if isRedLight(reshape(detection(i,:,:,:), [27,11,3]), '/home/artix41/Logiciels/caffe')
                iRedLight = i;
                count = count + 1;
            end
        end
        count
        subplot(3,5,13)
        if iRedLight ~= -1
            imagesc(imread('images/stop.png'));
            imwrite(reshape(detection(iRedLight,:,:,:), [27,11,3]),sprintf('~/image.jpg', count));
        else
            imagesc(imread('images/continue.jpg'));
        end
        title(sprintf('%d', iRedLight));
        set(gca,'xtick',[],'ytick',[]);

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

function y = createDataset(start, stop, directory)
    % Create a dataset of images in jpg format
    % corresponding to rectangles around the maximum of the pictures
    % Goal : produce a dataset of negative class images (false traffic lights)

    iImage = start;
    continuer = 1;
    count = 5465; % Indice of the last saved image
    while continuer && iImage < stop
        rgb_image = imread(sprintf('%s/frame_%06d.jpg', directory, iImage));

        [lab_image, F] = convertColorSpace(rgb_image);

        % Find the maximum
        coord_maxima = detectMaxima(F, 1);

        % Find the extracted traffic light (rectangle 11x27)
        detection = extractDetection(rgb_image, coord_maxima, 10, 26);

        % Save it as a jpg file
        imwrite(detection,sprintf('datasets/image_%04d.jpg', count));

        iImage = iImage + 1;
        if mod(iImage,20)==0
            display(iImage)
        end
        count = count + 1;
    end

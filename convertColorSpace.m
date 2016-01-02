function [lab_image, F] = convertColorSpace(image)
    % Conversion in lab
    addpath('lib/RGB2Lab/')

    lab_image = RGB2Lab(image);
    %lab_image_normalized(:,:,1) = normalization(lab_image(:,:,1));
    %lab_image_normalized(:,:,2:3) = normalization(lab_image(:,:,2:3));
    lab_image_normalized = lab_image;
    % Getting F = L*(a+b)
    F = lab_image_normalized(:,:,1).*(lab_image_normalized(:,:,2)+lab_image_normalized(:,:,3));
    %display(F(1:50, 1:50));
    %imagesc(F);

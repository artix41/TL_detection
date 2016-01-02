function [lab_image, F] = convertColorSpace(image)
    % Conversion in lab
    cform = makecform('srgb2lab');
    lab_image = applycform(image,cform);

    lab_image_normalized(:,:,1) = normalization(lab_image(:,:,1),0,256);
    lab_image_normalized(:,:,2:3) = normalization(lab_image(:,:,2:3),128,128);
    
    % Getting F = L*(a+b)
    F = lab_image_normalized(:,:,1).*(lab_image_normalized(:,:,2)+lab_image_normalized(:,:,3));
    %imagesc(F);
    
% Question 3 : 3 dimensions dont les valeurs sont comprises entre 0 et
% 255. Les deux premières dimensions sont les coordonnées de l'image et
% la 3e représente la valeur de R, G ou B (3e dimension de taille 3)

% Question 4 : Toujours 3 dimensions et des valeurs entre 0 et 255.
% Pour obtenir les bonnes plages de valeurs, il faut normaliser la
% matrice.

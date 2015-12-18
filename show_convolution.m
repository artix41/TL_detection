function y = show_convolution(start,stop, directory)
    subplot(1,1,1);
    hold off;
    iImage = start;
    continuer = 1;
    while continuer && iImage < stop
        rgb_image = imread(sprintf('%s/frame_%06d.jpg', directory, iImage));
        cform = makecform('srgb2lab');
        lab_image = applycform(rgb_image,cform); 
        imagesc(lab_image);
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
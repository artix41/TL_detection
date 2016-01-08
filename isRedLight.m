function y = isRedLight(image, caffe_directory)
    % caffe_directory = '/home/artix41/Logiciels/caffe/'
    %size(image)
    %assert(isequal(size(image), [27 11 3]), 'Error in the dimension of the image')

    if ~exist('net') % if we have not already instantiated the model
        % instantiate the network
        addpath(genpath(caffe_directory));
        model_dir = strcat(caffe_directory, '/traffic_lights/');
        net_model = strcat(model_dir, '/protos/deploy.prototxt');
        net_weights = strcat(model_dir, '/snapshots/snapshot_iter_3870.caffemodel');
        phase = 'test';

        addpath(genpath('matlab')); % to add matlab-caffe functions
        caffe.set_mode_cpu();

        net = caffe.Net(net_model, net_weights, phase);
        net.blobs('data').reshape([27 11 3 1]);

        % Load the mean
        mean = imread('../datasets/mean.jpg');
        mean = reshape(mean, [27 11 3]);

    end
    image = caffe.io.load_image(image);
    image = reshape(image, [27 11 3]);
    prep_image = int64(image) - int64(mean);
    input{1} = prep_image;
    scores = net.forward(input);

    display(net.blobs('prob').get_data());
    y_tableau = argmax(net.blobs('prob').get_data());
    y = y_tableau(1)-1;

    %y = uint8((abs(x_final(1)) + abs(x_final(2)))/2 < 6.0); % a revoir

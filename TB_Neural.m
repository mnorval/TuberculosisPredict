  
for n = 1:2
    %clearvars –global
    %clearvars
    %clc
    %LASTN = maxNumCompThreads(1)
    %rng(0)
    %rng(4151941)
    %rng('default')

    
categories = {'No_TB','Has_TB'};

rootFolder = 'D:\Temp\Original\Small_Set';

imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'IncludeSubfolders', true,'LabelSource', 'foldernames'); 

        imageSize = [64,64];
        fprintf('Imagesize = 64  \n');
        image_size = 64;
        image_color_channels = 1;
        imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);


    %split the datastore into training x% and x%
    [imagedataTrain,imagedataValidation] = splitEachLabel(imagedata,0.9);

    if image_color_channels == 1
      augmentedTrainingSet = augmentedImageDatastore(imageSize, imagedataTrain,'ColorPreprocessing', 'rgb2gray');
      augmentedValidateSet = augmentedImageDatastore(imageSize, imagedataValidation,'ColorPreprocessing', 'rgb2gray');
      fprintf('Color Channel = 1  \n');
    end

    varSize = image_size;
    conv1 = convolution2dLayer(5,varSize,'Padding',2,'BiasLearnRateFactor',2);
    conv1.Weights = gpuArray(single(randn([5 5 image_color_channels varSize])*0.0001));
    fc1 = fullyConnectedLayer(image_size*2,'BiasLearnRateFactor',2);
    fc1.Weights = gpuArray(single(randn([image_size*2 7*7*image_size])*0.1));
    fc2 = fullyConnectedLayer(2,'BiasLearnRateFactor',2);
    fc2.Weights = gpuArray(single(randn([2 image_size*2])*0.1));

    layers = [
        imageInputLayer([varSize varSize image_color_channels]);
        conv1;
        maxPooling2dLayer(3,'Stride',2);
        reluLayer();
        convolution2dLayer(5,32,'Padding',2,'BiasLearnRateFactor',2);
        reluLayer();
        averagePooling2dLayer(3,'Stride',2);
        convolution2dLayer(5,64,'Padding',2,'BiasLearnRateFactor',2);
        reluLayer();
        averagePooling2dLayer(3,'Stride',2);
        fc1;
        reluLayer();
        fc2;
        softmaxLayer()
        classificationLayer()];    


    opts = trainingOptions('sgdm', ...
        'InitialLearnRate', 0.001, ...
        'LearnRateSchedule', 'piecewise', ...
        'LearnRateDropFactor', 0.1, ...
        'LearnRateDropPeriod', 8, ...
        'L2Regularization', 0.004, ...
        'ValidationData',augmentedValidateSet,...
        'ValidationFrequency',1,... 
        'MaxEpochs', 50, ...
        'MiniBatchSize', 50, ...
        'Verbose', true, ...
        'VerboseFrequency',1, ...    
        'Plots','training-progress'); 

    %net = feedforwardnet(1);
    %setwb(net,1);
    [net, info] = trainNetwork(augmentedTrainingSet, layers, opts);
end

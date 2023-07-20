clearvars
clc
categories = {'Adjusted_Cropped_Has_TB1024_RGB','Adjusted_Cropped_No_TB1024_RGB'};
%categories = {'Adjusted_Cropped_Has_TB64','Adjusted_Cropped_No_TB64'};
rootFolder = 'E:\Documents\Dropbox\Personal\Study\MTech\Simulations\Datasets';
 
imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');  

image_size = 64;
image_color_channels = 3;
imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);
  
    
    
%split the datastore into training x% and x%
[imagedataTrain,imagedataValidation] = splitEachLabel(imagedata,0.9);
    

conv1 = convolution2dLayer(5,image_size,'Padding',2,'BiasLearnRateFactor',2);
%conv1.Weights = gpuArray(single(randn([5 5 image_color_channels image_size])*0.0001));
fc1 = fullyConnectedLayer(image_size*2,'BiasLearnRateFactor',2);
%32 fc1.Weights = gpuArray(single(randn([image_size*2 image_size*18])*0.1));
%fc1.Weights = gpuArray(single(randn([image_size*2 7*7*128])*0.01));
fc2 = fullyConnectedLayer(2,'BiasLearnRateFactor',2);
%fc2.Weights = gpuArray(single(randn([2 image_size*2])*0.1));
 
layers = [
    imageInputLayer([image_size image_size image_color_channels]);
    conv1;
    maxPooling2dLayer(3,'Stride',2);
    reluLayer();
    convolution2dLayer(5,image_size,'Padding',2,'BiasLearnRateFactor',2);
    reluLayer();
    averagePooling2dLayer(3,'Stride',2);
    convolution2dLayer(5,image_size*2,'Padding',2,'BiasLearnRateFactor',2);
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
    'MaxEpochs', 30, ...
    'Shuffle', 'once', ...
	'Verbose', true, ...
    'VerboseFrequency',1, ... 
    'MiniBatchSize', 50); 
 
 
[net, info] = trainNetwork(imagedataTrain, layers, opts);
%save('/home/36825050/neural_net/cpu/64_nn.mat','net')

clearvars;
clc;
load('30March2019Net');
inputSize = net.Layers(1).InputSize;
layersTransfer = net.Layers(1:end-2);


categories = {'Has_TB','No_TB'};
rootFolder = 'C:\Temp';

imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'IncludeSubfolders', true,'LabelSource', 'foldernames');  

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


numClasses = numel(categories(imagedataTrain.Labels));
%fc1 = fullyConnectedLayer(image_size*2,'BiasLearnRateFactor',2);
layers = [
    layersTransfer
    %fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    %fullyConnectedLayer(numClasses)
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];
	
%{ 
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',30, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imagedataValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');	
%}

opts = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 8, ...
    'L2Regularization', 0.004, ...
    'ValidationData',augmentedValidateSet,...
    'ValidationFrequency',3,... 
    'ExecutionEnvironment','GPU',...
    'MaxEpochs', 30, ...
    'Shuffle', 'every-epoch', ...
    'MiniBatchSize', 50, ...
    'Verbose', true, ...
    'VerboseFrequency',1, ...    
    'Plots','training-progress');  

[net, info] = trainNetwork(augmentedTrainingSet, layers, opts);